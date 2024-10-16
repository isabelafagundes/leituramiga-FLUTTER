import 'package:flutter/material.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class CardSolicitacaoWidget extends StatefulWidget {
  final Tema tema;
  final Function(int) aoVisualizar;
  final ResumoSolicitacao solicitacao;
  final String usuarioPerfil;

  const CardSolicitacaoWidget({
    required this.tema,
    super.key,
    required this.aoVisualizar,
    required this.solicitacao,
    required this.usuarioPerfil,
  });

  @override
  State<CardSolicitacaoWidget> createState() => _CardSolicitacaoWidgetState();
}

class _CardSolicitacaoWidgetState extends State<CardSolicitacaoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.tema.borderRadiusG),
        border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
        boxShadow: [
          BoxShadow(
            color: Color(widget.tema.neutral).withOpacity(.2),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.tema.borderRadiusG),
        child: Stack(
          children: [
            CardBaseWidget(
              tema: widget.tema,
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.tema.borderRadiusM),
                            color: Color(widget.tema.accent),
                          ),
                        ),
                        SizedBox(width: widget.tema.espacamento * 2),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
                            color: Color(widget.tema.neutral).withOpacity(.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: widget.tema.espacamento * 2),
                  Flexible(
                    flex: Responsive.larguraM(context) ? 3 : 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextoWidget(
                              texto: widget.solicitacao.nomeUsuario == widget.usuarioPerfil
                                  ? "Criada por você "
                                  : "Solicitação com ",
                              tema: widget.tema,
                            ),
                            TextoWidget(
                              texto: widget.solicitacao.nomeUsuario == widget.usuarioPerfil
                                  ? ""
                                  : widget.solicitacao.nomeUsuario,
                              tema: widget.tema,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(height: widget.tema.espacamento / 2),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextoWidget(
                                  texto: "Data entrega ",
                                  weight: FontWeight.w500,
                                  tema: widget.tema,
                                ),
                                TextoWidget(
                                  texto: widget.solicitacao.dataEntrega.formatar("dd/MM/yyyy"),
                                  tema: widget.tema,
                                ),
                              ],
                            ),
                            if (widget.solicitacao.dataDevolucao != null) ...[
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextoWidget(
                                    texto: "Data devolução",
                                    weight: FontWeight.w500,
                                    tema: widget.tema,
                                  ),
                                  TextoWidget(
                                    texto: widget.solicitacao.dataDevolucao?.formatar("dd/MM/yyyy") ?? '',
                                    tema: widget.tema,
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                        SizedBox(height: widget.tema.espacamento / 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextoWidget(
                              texto: "Endereço",
                              weight: FontWeight.w500,
                              tema: widget.tema,
                            ),
                            TextoWidget(
                              texto: widget.solicitacao.endereco.enderecoFormatado,
                              tema: widget.tema,
                            ),
                          ],
                        ),
                        SizedBox(height: widget.tema.espacamento),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BotaoPequenoWidget(
                              tema: widget.tema,
                              corFonte: kCorFonte,
                              aoClicar: () => widget.aoVisualizar(widget.solicitacao.numero!),
                              label: "Visualizar",
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: -4,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.tema.espacamento * 2.5,
                  vertical: widget.tema.espacamento / 1.5,
                ),
                decoration: BoxDecoration(
                  color: _obterCor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.tema.borderRadiusG),
                    bottomLeft: Radius.circular(widget.tema.borderRadiusG),
                  ),
                  border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
                ),
                child: TextoWidget(
                  texto: widget.solicitacao.tipo.descricao,
                  tema: widget.tema,
                  weight: FontWeight.w500,
                  cor: kCorFonte,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _obterCor() {
    return switch (widget.solicitacao.tipo) {
      TipoSolicitacao.EMPRESTIMO => kCorVerde,
      TipoSolicitacao.DOACAO => kCorAzul,
      TipoSolicitacao.TROCA => kCorPessego,
    };
  }
}
