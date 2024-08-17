import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
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

  @override
  Widget build(BuildContext context) {
    return _visualizarSolicitacao
        ? ConteudoResumoSolicitacaoWidget(tema: widget.tema)
        : Container(
            width: Responsive.larguraP(context) ? Responsive.largura(context) : 600,
            height: Responsive.larguraP(context) ? Responsive.altura(context) :  Responsive.altura(context)-40,
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
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (!_exibindoEmAndamento) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: widget.tema.espacamento * 2,
                                bottom: widget.tema.espacamento * 2,
                              ),
                              child: CardNotificacaoWidget(
                                tema: widget.tema,
                                aoVisualizar: () => setState(() => _visualizarSolicitacao = true),
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
                                aoVisualizar: () => setState(() => _visualizarSolicitacao = true),
                              ),
                            );
                          }
                        }),
                  ),
                )
              ],
            ),
          );
  }
}
