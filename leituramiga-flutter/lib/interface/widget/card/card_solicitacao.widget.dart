import 'package:flutter/material.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/icone_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
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
    return GestureDetector(
      onTap: () => widget.aoVisualizar(widget.solicitacao.numero!),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.tema.borderRadiusG),
              border: Border.all(color: Color(widget.tema.neutral).withOpacity(.1)),
              boxShadow: [
                BoxShadow(
                  color: Color(widget.tema.neutral).withOpacity(.1),
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
                    borda: Border.all(color: Colors.transparent),
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.tema.espacamento,
                    ),
                    tema: widget.tema,
                    child: Flex(
                      mainAxisSize: MainAxisSize.min,
                      direction: Axis.horizontal,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconeUsuarioWidget(
                              tema: widget.tema,
                              corLivros: Colors.transparent,
                              textoPerfil: widget.solicitacao.nomeUsuario,
                              corPerfil: obterCorAleatoria(),
                              tamanho: Responsive.larguraP(context) ? 55 : 60,
                              quantidadeLivros: null,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: widget.tema.espacamento * 2,
                        ),
                        Flexible(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Responsive.larguraP(context)
                                    ? widget.tema.espacamento * 3.5
                                    : widget.tema.espacamento,
                              ),
                              TextoWidget(
                                texto: "Solicitação criada por:",
                                tema: widget.tema,
                                weight: FontWeight.w500,
                              ),
                              TextoWidget(
                                texto: widget.solicitacao.nomeUsuario == widget.usuarioPerfil
                                    ? "Você"
                                    : widget.solicitacao.nomeUsuario,
                                tema: widget.tema,
                              ),
                              SizedBox(height: widget.tema.espacamento / 2),
                              TextoWidget(
                                texto: "Data:",
                                weight: FontWeight.w500,
                                tema: widget.tema,
                              ),
                              Row(
                                children: [
                                  if (widget.solicitacao.dataEntrega != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextoWidget(
                                          texto: widget.solicitacao.dataEntrega!.formatar("dd/MM/yyyy"),
                                          tema: widget.tema,
                                        ),
                                      ],
                                    ),
                                  SizedBox(width: widget.tema.espacamento / 4),
                                  if (widget.solicitacao.dataDevolucao != null &&
                                      widget.solicitacao.dataEntrega != null) ...[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        TextoWidget(
                                          texto: ' - ',
                                          tema: widget.tema,
                                        ),
                                      ],
                                    ),
                                  ],
                                  SizedBox(width: widget.tema.espacamento / 4),
                                  if (widget.solicitacao.dataDevolucao != null) ...[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
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
                                    texto: "Endereço:",
                                    weight: FontWeight.w500,
                                    tema: widget.tema,
                                  ),
                                  TextoWidget(
                                    texto: widget.solicitacao.endereco?.enderecoFormatadoCensurado ?? "",
                                    tema: widget.tema,
                                  ),
                                ],
                              ),
                              SizedBox(height: widget.tema.espacamento),
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
          ),
        ],
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
