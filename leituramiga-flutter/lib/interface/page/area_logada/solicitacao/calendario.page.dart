import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:table_calendar/table_calendar.dart';

@RoutePage()
class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  SolicitacaoComponent solicitacaoComponent = SolicitacaoComponent();

  TemaState get _temaState => TemaState.instancia;
  DataHora? dataSelecionada = DataHora.hoje();

  Tema get tema => _temaState.temaSelecionado!;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  @override
  void initState() {
    super.initState();
    solicitacaoComponent.inicializar(
      AppModule.solicitacaoRepo,
      AppModule.solicitacaoService,
      AppModule.notificacaoRepo,
      atualizar,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await solicitacaoComponent.obterNotificacoes(_autenticacaoState.usuario!.email.endereco);
      await solicitacaoComponent.obterSolicitacoesIniciais(_autenticacaoState.usuario!.email.endereco);
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
        atualizar: atualizar,
        carregando: solicitacaoComponent.carregando || !mounted,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DicaWidget(
                  tema: tema,
                  texto: "Clique em uma data para visualizar as solicitações.",
                ),
                SizedBox(height: tema.espacamento * 2),
                Container(
                  width: Responsive.largura(context) < 1000 ? Responsive.largura(context) : 1000,
                  height: 400,
                  child: TableCalendar<ResumoSolicitacao>(
                    locale: 'pt_BR',
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: dataSelecionada?.valor ?? DataHora.hoje().valor,
                    selectedDayPredicate: (day) => isSameDay(dataSelecionada?.valor, day),
                    rangeStartDay: null,
                    rangeEndDay: null,
                    calendarFormat: CalendarFormat.month,
                    rangeSelectionMode: RangeSelectionMode.disabled,
                    eventLoader: obterEventos,
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
                        color: Color(tema.accent),
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
                      weekdayStyle: TextStyle(
                        color: Color(tema.baseContent),
                        fontSize: tema.tamanhoFonteM,
                        fontWeight: FontWeight.w500,
                        fontFamily: tema.familiaDeFontePrimaria,
                      ),
                      weekendStyle: TextStyle(
                        color: Color(tema.baseContent),
                        fontSize: tema.tamanhoFonteM,
                        fontWeight: FontWeight.w500,
                        fontFamily: tema.familiaDeFontePrimaria,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: tema.espacamento * 4),
                SizedBox(
                  height: 800,
                  child: Column(
                    children: [
                      TextoWidget(
                        texto: 'Solicitações',
                        tema: tema,
                        weight: FontWeight.w500,
                        tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteG : tema.tamanhoFonteXG + 4,
                      ),
                      SizedBox(height: tema.espacamento * 2),
                      solicitacoesSelecionadas.isEmpty
                          ? TextoWidget(
                              texto: 'Nenhuma solicitação para esta data.',
                              tema: tema,
                              tamanho: tema.tamanhoFonteM,
                            )
                          : Expanded(
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: _obterQuantidadeColunas(context),
                                  crossAxisSpacing: tema.espacamento * 2,
                                  mainAxisSpacing: tema.espacamento * 2,
                                  childAspectRatio: 1.5,
                                  mainAxisExtent: 166,
                                ),
                                itemCount: solicitacoesSelecionadas.length,
                                itemBuilder: (context, index) {
                                  final solicitacao = solicitacoesSelecionadas[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: tema.espacamento * 2),
                                    child: CardSolicitacaoWidget(
                                      tema: tema,
                                      solicitacao: solicitacao,
                                      aoVisualizar: (numero) {
                                        Rota.navegarComArgumentos(
                                          context,
                                          DetalhesSolicitacaoRoute(
                                            numeroSolicitacao: numero,
                                          ),
                                        );
                                      },
                                      usuarioPerfil: '',
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

  int _obterQuantidadeColunas(BuildContext context) {
    if (Responsive.largura(context) > 1400) return 3;
    if (Responsive.largura(context) > 900) return 2;
    return 1;
  }

  List<ResumoSolicitacao> obterEventos(DateTime data) => solicitacaoComponent.itensPaginados
      .where((solicitacao) =>
          isSameDay(solicitacao.dataEntrega?.valor, data) || isSameDay(solicitacao.dataDevolucao?.valor, data))
      .toList();

  List<ResumoSolicitacao> get solicitacoesSelecionadas => solicitacaoComponent.itensPaginados
      .where((solicitacao) =>
          isSameDay(solicitacao.dataEntrega?.valor, dataSelecionada?.valor) ||
          isSameDay(solicitacao.dataDevolucao?.valor, dataSelecionada?.valor))
      .toList();

  void _selecionarData(DateTime data) {
    setState(() => dataSelecionada = DataHora.criar(data));
  }

  TextStyle get textStyleDisabled => TextStyle(
        color: Color(tema.baseContent).withOpacity(.2),
        fontSize: tema.tamanhoFonteM + 2,
        fontFamily: tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyle => TextStyle(
        color: Color(tema.baseContent),
        fontSize: tema.tamanhoFonteM + 2,
        fontFamily: tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyleSelected => TextStyle(
        color: kCorFonte,
        fontSize: tema.tamanhoFonteM + 2,
        fontFamily: tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyleBold => TextStyle(
        color: Color(tema.baseContent),
        fontSize: tema.tamanhoFonteM + 2,
        fontWeight: FontWeight.w500,
        fontFamily: tema.familiaDeFontePrimaria,
      );
}
