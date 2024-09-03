import 'package:flutter/material.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoResumoSolicitacaoWidget extends StatelessWidget {
  final Tema tema;
  final Solicitacao solicitacao;

  const ConteudoResumoSolicitacaoWidget({super.key, required this.tema, required this.solicitacao});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(tema.espacamento * 2),
      width: Responsive.largura(context) <= 600 ? Responsive.largura(context) : 600,
      height: Responsive.largura(context) <= 600 ? Responsive.altura(context) : null,
      child: Column(
        children: [
          Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Axis.vertical,
            children: [
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
                          texto: "Solicitação em andamento com ",
                          tema: tema,
                        ),
                        TextoWidget(
                          texto: "@${solicitacao.nomeUsuario}",
                          tema: tema,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: tema.espacamento / 2),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextoWidget(
                              texto: "Data entrega ",
                              weight: FontWeight.w500,
                              tema: tema,
                            ),
                            TextoWidget(
                              texto: solicitacao.dataEntrega.formatar("dd/MM/yyyy"),
                              tema: tema,
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (solicitacao.dataDevolucao != null)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextoWidget(
                                texto: "Data devolução",
                                weight: FontWeight.w500,
                                tema: tema,
                              ),
                              TextoWidget(
                                texto: solicitacao.dataDevolucao?.formatar("dd/MM/yyyy") ?? '',
                                tema: tema,
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: tema.espacamento / 2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextoWidget(
                          texto: "Endereço",
                          weight: FontWeight.w500,
                          tema: tema,
                        ),
                        TextoWidget(
                          texto: solicitacao.endereco!.enderecoFormatado,
                          tema: tema,
                        ),
                        SizedBox(height: tema.espacamento / 2),
                        TextoWidget(
                          texto: "Informações adicionais",
                          weight: FontWeight.w500,
                          tema: tema,
                        ),
                        TextoWidget(
                          texto: solicitacao.informacoesAdicionais.isEmpty? "Sem informações adicionais" : solicitacao.informacoesAdicionais,
                          tema: tema,
                        ),
                        SizedBox(height: tema.espacamento / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextoWidget(
                                  texto: "Forma de entrega",
                                  weight: FontWeight.w500,
                                  tema: tema,
                                ),
                                TextoWidget(
                                  texto: solicitacao.formaEntrega.descricao,
                                  tema: tema,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextoWidget(
                                  texto: "Tipo solicitação",
                                  weight: FontWeight.w500,
                                  tema: tema,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: tema.espacamento,
                                    vertical: tema.espacamento / 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _obterCor(),
                                    borderRadius: BorderRadius.circular(tema.borderRadiusM),
                                    border: Border.all(color: Color(tema.neutral).withOpacity(.2)),
                                  ),
                                  child: TextoWidget(
                                    texto: solicitacao.tipoSolicitacao.descricao,
                                    tema: tema,
                                    weight: FontWeight.w500,
                                    cor: kCorFonte,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: tema.espacamento),
                        Divider(color: Color(tema.accent)),
                        SizedBox(height: tema.espacamento),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: tema.espacamento * 2),
                      child: CardBaseWidget(
                        tema: tema,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextoWidget(
                                texto: "Nome livro",
                                tamanho: tema.tamanhoFonteM,
                                weight: FontWeight.w500,
                                tema: tema,
                              ),
                              TextoWidget(
                                texto: "Nome e sobrenome do autor",
                                tema: tema,
                                tamanho: tema.tamanhoFonteP,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: tema.espacamento),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: tema.espacamento),
          Divider(color: Color(tema.accent)),
          SizedBox(height: tema.espacamento),
          Flex(
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (solicitacao.tipoSolicitacao != TipoSolicitacao.TROCA)
                BotaoWidget(
                  tema: tema,
                  corTexto: kCorFonte,
                  texto: "Aceitar",
                  aoClicar: () {},
                  icone: Icon(
                    Icons.done,
                    color: kCorFonte,
                  ),
                  corFundo: Color(tema.success),
                ),
              if (solicitacao.tipoSolicitacao == TipoSolicitacao.TROCA)
                BotaoWidget(
                  tema: tema,
                  corTexto: kCorFonte,
                  texto: "Escolher livros",
                  aoClicar: () {},
                  icone: Icon(
                    Icons.bookmark_add_outlined,
                    color: kCorFonte,
                  ),
                  corFundo: Color(tema.accent),
                ),
              SizedBox(height: tema.espacamento * 2, width: tema.espacamento * 2),
              BotaoWidget(
                tema: tema,
                corTexto: kCorFonte,
                texto: "Recusar",
                aoClicar: () {},
                icone: Icon(
                  Icons.close,
                  color: kCorFonte,
                ),
                corFundo: Color(tema.error),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color _obterCor() {
    return switch (solicitacao.tipoSolicitacao) {
      TipoSolicitacao.EMPRESTIMO => kCorVerde,
      TipoSolicitacao.DOACAO => kCorAzul,
      TipoSolicitacao.TROCA => kCorPessego,
    };
  }
}
