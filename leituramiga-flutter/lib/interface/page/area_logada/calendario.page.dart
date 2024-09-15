import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/notificacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.service.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  bool _exibindoEmAndamento = false;
  bool _visualizarSolicitacao = false;
  SolicitacaoComponent solicitacaoComponent = SolicitacaoComponent();

  TemaState get _temaState => TemaState.instancia;
  DataHora? dataSelecionada = DataHora.hoje();

  Tema get tema => _temaState.temaSelecionado!;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  @override
  void initState() {
    super.initState();
    solicitacaoComponent.inicializar(
      SolicitacaoMockRepo(),
      SolicitacaoMockService(),
      NotificacaoMockRepo(),
      atualizar,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await solicitacaoComponent.obterNotificacoes(_autenticacaoState.usuario!.numero!);
      await solicitacaoComponent.obterSolicitacoesIniciais(_autenticacaoState.usuario!.numero!);
    });
  }

  void atualizar() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        voltar: () => Rota.navegar(context, Rota.HOME),
        carregando: solicitacaoComponent.carregando || solicitacaoComponent.itensPaginados.isEmpty || !mounted,
        alterarFonte: _alterarFonte,
        alterarTema: _alterarTema,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TableCalendar<ResumoSolicitacao>(
                  locale: 'pt_BR',
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DataHora.hoje().valor,
                  selectedDayPredicate: (day) => isSameDay(dataSelecionada?.valor, day),
                  rangeStartDay: null,
                  rangeEndDay: null,
                  calendarFormat: CalendarFormat.month,
                  rangeSelectionMode: RangeSelectionMode.disabled,
                  eventLoader: (day) => obterEventos(day),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendTextStyle: textStyle,
                    todayTextStyle: textStyleBold,
                    todayDecoration: BoxDecoration(
                      color: Color(tema.base200).withOpacity(.2),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: textStyle,
                    markerDecoration: BoxDecoration(
                      color: Color(tema.accent),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(tema.base200),
                      shape: BoxShape.circle,
                    ),
                    disabledTextStyle: textStyleDisabled,
                    defaultTextStyle: textStyle,
                    defaultDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) => _selecionarData(selectedDay),
                  headerStyle: HeaderStyle(
                    titleTextStyle: textStyleBold,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(Icons.chevron_left, color: Color(tema.baseContent)),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Color(tema.baseContent)),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: textStyleBold,
                    weekendStyle: textStyleBold,
                  ),
                ),
                SizedBox(width: tema.espacamento * 4),
                SizedBox(
                  height: 800,
                  child: dataSelecionada == null
                      ? const SizedBox()
                      : Column(
                          children: [
                            TextoWidget(
                              texto: 'Solicitações',
                              tema: tema,
                              weight: FontWeight.w500,
                              tamanho: tema.tamanhoFonteG,
                            ),
                            SizedBox(height: tema.espacamento * 2),
                            solicitacoesSelecionadas.isEmpty
                                ? TextoWidget(
                                    texto: 'Nenhuma solicitação para esta data',
                                    tema: tema,
                                    weight: FontWeight.w500,
                                    tamanho: tema.tamanhoFonteM,
                                  )
                                : Expanded(
                                    child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: Responsive.larguraP(context) ? 1 : 2,
                                        crossAxisSpacing: tema.espacamento * 2,
                                        mainAxisSpacing: tema.espacamento * 2,
                                        childAspectRatio: 1.5,
                                        mainAxisExtent: 205,
                                      ),
                                      itemCount: solicitacoesSelecionadas.length,
                                      itemBuilder: (context, index) {
                                        final solicitacao = solicitacoesSelecionadas[index];
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: tema.espacamento * 2),
                                          child: CardSolicitacaoWidget(
                                            tema: tema,
                                            solicitacao: solicitacao,
                                            aoVisualizar: (int) {},
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ResumoSolicitacao>  obterEventos(DateTime data) => solicitacaoComponent.itensPaginados
      .where((solicitacao) =>
  isSameDay(solicitacao.dataEntrega.valor,data) ||
      isSameDay(solicitacao.dataDevolucao?.valor, data))
      .toList();

  List<ResumoSolicitacao> get solicitacoesSelecionadas => solicitacaoComponent.itensPaginados
      .where((solicitacao) =>
          isSameDay(solicitacao.dataEntrega.valor, dataSelecionada?.valor) ||
          isSameDay(solicitacao.dataDevolucao?.valor, dataSelecionada?.valor))
      .toList();

  void _selecionarData(DateTime data) {
    setState(() => dataSelecionada = DataHora.criar(data));
  }

  TextStyle get textStyleDisabled => TextStyle(
        color: Color(tema.baseContent).withOpacity(.2),
        fontSize: tema.tamanhoFonteM,
        fontFamily: tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyle => TextStyle(
        color: Color(tema.baseContent),
        fontSize: tema.tamanhoFonteM,
        fontFamily: tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyleSelected => TextStyle(
        color: kCorFonte,
        fontSize: tema.tamanhoFonteM,
        fontFamily: tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyleBold => TextStyle(
        color: Color(tema.baseContent),
        fontSize: tema.tamanhoFonteM,
        fontWeight: FontWeight.w500,
        fontFamily: tema.familiaDeFontePrimaria,
      );

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }
}
