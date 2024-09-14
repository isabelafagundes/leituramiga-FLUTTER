import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoLivrosSolicitacaoWidget extends StatelessWidget {
  final Tema tema;
  final List<ResumoLivro> usuarioCriador;
  final List<ResumoLivro>? usuarioDoador;

  const ConteudoLivrosSolicitacaoWidget(
      {super.key, required this.tema, required this.usuarioCriador, this.usuarioDoador});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.altura(context) * .8,
      child: SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            _obterTextoComIcone(
              "Livros escolhidos por @nome_usuario",
              Icon(
                Icons.book,
                color: Color(tema.baseContent),
                size: 18,
              ),
            ),
            SizedBox(height: tema.espacamento),
            ListView.builder(
              itemCount: 5,
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
            if (usuarioDoador != null) ...[
              SizedBox(height: tema.espacamento),
              Divider(color: Color(tema.accent)),
              SizedBox(height: tema.espacamento),
              _obterTextoComIcone(
                "Livros escolhidos por @nome_usuario",
                Icon(
                  Icons.book,
                  color: Color(tema.baseContent),
                  size: 18,
                ),
              ),
              SizedBox(height: tema.espacamento),
              ListView.builder(
                itemCount: 5,
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
            ]
          ],
        ),
      ),
    );
  }

  Widget _obterTextoComIcone(String texto, Widget icone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icone,
        SizedBox(width: tema.espacamento),
        TextoWidget(
          texto: texto,
          tema: tema,
          weight: FontWeight.w500,
          tamanho: tema.tamanhoFonteG,
        ),
      ],
    );
  }
}
