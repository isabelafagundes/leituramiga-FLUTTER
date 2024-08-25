import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/domain/notificacao.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/notificacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.service.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_resumo_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoNotificacoesWidget extends StatefulWidget {
  final Tema tema;
  final Function() aoVisualizarSolicitacao;

  const ConteudoNotificacoesWidget({
    super.key,
    required this.tema,
    required this.aoVisualizarSolicitacao,
  });

  @override
  State<ConteudoNotificacoesWidget> createState() => _ConteudoNotificacoesWidgetState();
}

class _ConteudoNotificacoesWidgetState extends State<ConteudoNotificacoesWidget> {
  bool _exibindoEmAndamento = false;
  bool _visualizarSolicitacao = false;
  SolicitacaoComponent solicitacaoComponent = SolicitacaoComponent();

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (solicitacaoComponent.carregando) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return _visualizarSolicitacao
        ? ConteudoResumoSolicitacaoWidget(tema: widget.tema)
        : Container(
            width: Responsive.largura(context) <= 600 ? Responsive.largura(context) : 600,
            height: Responsive.largura(context) <= 600 ? Responsive.altura(context) : Responsive.altura(context) - 40,
            padding: EdgeInsets.all(widget.tema.espacamento * 2),
            child: Column(
              children: [
                Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Responsive.larguraM(context)
                              ? Row(
                                  children: [
                                    BotaoRedondoWidget(
                                      tema: widget.tema,
                                      nomeSvg: 'seta/chevron-left',
                                      aoClicar: () => Navigator.pop(context),
                                    ),
                                    const Spacer(),
                                    TextoWidget(
                                      texto: "Solicitações",
                                      tamanho: widget.tema.tamanhoFonteXG,
                                      weight: FontWeight.w500,
                                      tema: widget.tema,
                                    ),
                                    const Spacer(),
                                    Opacity(
                                      opacity: 0,
                                      child: IgnorePointer(
                                        child: BotaoRedondoWidget(
                                          tema: widget.tema,
                                          nomeSvg: 'filtro',
                                          icone: Icon(
                                            Icons.edit,
                                            color: Color(widget.tema.baseContent),
                                          ),
                                          aoClicar: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : TextoWidget(
                                  texto: "Solicitações",
                                  tamanho: widget.tema.tamanhoFonteXG,
                                  weight: FontWeight.w500,
                                  tema: widget.tema,
                                ),
                          SizedBox(height: widget.tema.espacamento * 2),
                          Center(
                            child: DuasEscolhasWidget(
                              tema: widget.tema,
                              aoClicarPrimeiraEscolha: () => setState(() => _exibindoEmAndamento = false),
                              aoClicarSegundaEscolha: () => setState(() => _exibindoEmAndamento = true),
                              escolhas: const ["Notificações", "Em andamento"],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.tema.espacamento * 2),
                Expanded(
                  child: SizedBox(
                    width: 600,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _exibindoEmAndamento
                          ? solicitacaoComponent.solicitacoes.length
                          : solicitacaoComponent.notificacoes.length,
                      itemBuilder: (context, index) {
                        Notificacao notificacao = solicitacaoComponent.notificacoes[index];
                        ResumoSolicitacao resumoSolicitacao = solicitacaoComponent.solicitacoes[index];
                        if (!_exibindoEmAndamento) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: widget.tema.espacamento * 2,
                              bottom: widget.tema.espacamento * 2,
                            ),
                            child: CardNotificacaoWidget(
                              tema: widget.tema,
                              aoRecusar: () => solicitacaoComponent.recusarSolicitacao(
                                  _autenticacaoState.usuario!.numero!, "Motivo"),
                              aoVisualizar: () => setState(() => _visualizarSolicitacao = true),
                              notificacao: notificacao,
                            ),
                          );
                        }
                        if (_exibindoEmAndamento) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: widget.tema.espacamento * 2,
                              bottom: widget.tema.espacamento * 2,
                            ),
                            child: CardSolicitacaoWidget(
                              tema: widget.tema,
                              solicitacao: resumoSolicitacao,
                              aoVisualizar: () => setState(() => _visualizarSolicitacao = true),
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
