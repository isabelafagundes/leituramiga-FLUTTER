import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/util/sobreposicao.util.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/calendario_range.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/empty_state.widget.dart';
import 'package:projeto_leituramiga/interface/widget/layout_flexivel.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
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
      await solicitacaoComponent.obterHistoricoInicial(_autenticacaoState.usuario!.email.endereco);
    });
  }

  void atualizar() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: ConteudoMenuLateralWidget(
        tema: tema,
        carregando: solicitacaoComponent.carregando,
        voltar: () => Rota.navegar(context, Rota.HOME),
        child: Column(
          children: [
            TextoWidget(
              texto: "Histórico de Solicitações",
              tema: tema,
              weight: FontWeight.w500,
              tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteG + 4 : tema.tamanhoFonteXG + 4,
            ),
            SizedBox(height: tema.espacamento * 2),
            Row(
              children: [
                BotaoPequenoWidget(
                  tema: tema,
                  altura: 40,
                  label:
                      solicitacaoComponent.datasFormatadas.isEmpty ? "Filtrar" : solicitacaoComponent.datasFormatadas,
                  corFonte: Color(tema.baseContent),
                  corFundo: Color(tema.base200),
                  icone: SvgWidget(nomeSvg: 'filtro', cor: Color(tema.baseContent), altura: 16),
                  aoClicar: () =>
                      SobreposicaoUtil.exibir(context, _datePicker, aoFechar: () async => await _selecionarPeriodo()),
                ),
                if (solicitacaoComponent.dataInicio != null) ...[
                  SizedBox(width: tema.espacamento),
                  BotaoRedondoWidget(
                    tema: tema,
                    aoClicar: limparPeriodo,
                    nomeSvg: "limpar_icon",
                    tamanhoIcone: 22,
                  ),
                ]
              ],
            ),
            SizedBox(height: tema.espacamento * 3),
            Expanded(
              child: solicitacaoComponent.itensPaginados.isEmpty
                  ? EmptyStateWidget(tema: tema)
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _obterQuantidadeColunas(context),
                        crossAxisSpacing: tema.espacamento * 2,
                        mainAxisSpacing: tema.espacamento * 2,
                        childAspectRatio: 1.5,
                        mainAxisExtent: 168,
                      ),
                      itemCount: solicitacaoComponent.itensPaginados.length,
                      itemBuilder: (context, index) {
                        final solicitacao = solicitacaoComponent.itensPaginados[index];
                        return CardSolicitacaoWidget(
                          tema: tema,
                          solicitacao: solicitacao,
                          aoVisualizar: (numero) async {
                            Rota.navegarComArgumentos(
                              context,
                              DetalhesSolicitacaoRoute(
                                numeroSolicitacao: numero,
                              ),
                            );
                            Navigator.pop(context, true);
                          },
                          usuarioPerfil: '',
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      tema: tema,
    );
  }

  Widget get _datePicker => LayoutFlexivelWidget(
        tema: tema,
        alturaOverlay: 600,
        overlayChild: _calendario(context),
        drawerChild: _calendario(context),
      );

  Widget _calendario(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: tema.espacamento * 2),
        DicaWidget(
          tema: tema,
          texto: "Selecione o período desejado",
        ),
        SizedBox(height: tema.espacamento),
        CalendarioRangeWidget(
          tema: tema,
          aoSelecionarDataRange: (dataInicio, dataFim) async {
            DataHora dataHoraInicio = DataHora.criar(dataInicio);
            DataHora dataHoraFim = DataHora.criar(dataFim);
            solicitacaoComponent.selecionarDatas(
              dataHoraInicio.formatar('yyyy-MM-dd'),
              dataHoraFim.formatar('yyyy-MM-dd'),
            );
            await SobreposicaoUtil.fechar(context, resposta: true);
          },
        ),
      ],
    );
  }

  Future<void> _selecionarPeriodo() async {
    await notificarCasoErro(() async {
      await solicitacaoComponent.obterHistoricoInicial(_autenticacaoState.usuario!.email.endereco);
    });
  }

  Future<void> limparPeriodo() async {
    await notificarCasoErro(() async {
      solicitacaoComponent.limparDatas();
      await solicitacaoComponent.obterHistoricoInicial(_autenticacaoState.usuario!.email.endereco);
    });
  }

  int _obterQuantidadeColunas(BuildContext context) {
    if (Responsive.largura(context) > 1400) return 3;
    if (Responsive.largura(context) > 900) return 2;
    return 1;
  }
}
