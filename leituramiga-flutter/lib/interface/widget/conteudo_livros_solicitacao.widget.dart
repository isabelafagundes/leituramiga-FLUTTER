import 'package:flutter/material.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoLivrosSolicitacaoWidget extends StatelessWidget {
  final Tema tema;
  final List<LivroSolicitacao> usuarioCriador;
  final List<LivroSolicitacao>? usuarioDoador;
  final String nomeSolicitante;
  final String nomeReceptor;

  const ConteudoLivrosSolicitacaoWidget({
    super.key,
    required this.tema,
    required this.usuarioCriador,
    this.usuarioDoador,
    required this.nomeSolicitante,
    required this.nomeReceptor,
  });

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
              "Livros escolhidos por $nomeSolicitante",
              Icon(
                Icons.book,
                color: Color(tema.baseContent),
                size: 18,
              ),
              context,
            ),
            SizedBox(height: tema.espacamento),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.larguraP(context) ? 1 : 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: tema.espacamento,
                mainAxisSpacing: tema.espacamento,
                mainAxisExtent: Responsive.larguraP(context) ? 94 : 102,
              ),
              itemCount: usuarioCriador.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CardBaseWidget(
                      tema: tema,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextoWidget(
                              texto: usuarioCriador[index].nome,
                              tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteXG - 2 : tema.tamanhoFonteXG,
                              weight: FontWeight.w500,
                              tema: tema,
                            ),
                            SizedBox(height: tema.espacamento),
                            TextoWidget(
                              texto: usuarioCriador[index].nomeAutor,
                              tema: tema,
                              tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteG,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: tema.espacamento),
                  ],
                );
              },
            ),
            if (usuarioDoador != null && usuarioDoador!.isNotEmpty) ...[
              SizedBox(height: tema.espacamento),
              Divider(color: Color(tema.accent)),
              SizedBox(height: tema.espacamento),
              _obterTextoComIcone(
                "Livros escolhidos por $nomeReceptor",
                Icon(
                  Icons.book,
                  color: Color(tema.baseContent),
                  size: 18,
                ),
                context,
              ),
              SizedBox(height: tema.espacamento),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.larguraP(context) ? 1 : 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: tema.espacamento,
                  mainAxisSpacing: tema.espacamento,
                  mainAxisExtent: Responsive.larguraP(context) ? 94 : 102,
                ),
                itemCount: usuarioDoador?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  LivroSolicitacao livro = usuarioDoador![index];
                  return Column(
                    children: [
                      CardBaseWidget(
                        tema: tema,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextoWidget(
                                texto: livro.nome,
                                tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteG - 2 : tema.tamanhoFonteXG,
                                weight: FontWeight.w500,
                                tema: tema,
                              ),
                              SizedBox(height: tema.espacamento),
                              TextoWidget(
                                texto: livro.nomeAutor,
                                tema: tema,
                                tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteG,
                              ),
                            ],
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

  Widget _obterTextoComIcone(String texto, Widget icone, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icone,
        SizedBox(width: tema.espacamento),
        TextoWidget(
          texto: texto,
          tema: tema,
          weight: FontWeight.w500,
          tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteG : tema.tamanhoFonteXG,
        ),
      ],
    );
  }
}
