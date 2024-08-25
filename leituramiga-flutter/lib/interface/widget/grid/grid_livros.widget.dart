import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_livro.widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GridLivroWidget extends StatelessWidget {
  final Tema tema;
  final Function(int numero) aoClicarLivro;
  final List<ResumoLivro> livros;

  const GridLivroWidget({
    super.key,
    required this.tema,
    required this.aoClicarLivro,
    required this.livros,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _obterQuantidadePorLinha(context),
        mainAxisExtent: 220,
        mainAxisSpacing: tema.espacamento * 2,
        crossAxisSpacing: tema.espacamento * 2,
      ),
      itemBuilder: (ccontext, indice) {
        ResumoLivro livro = livros[indice];
        return  CardLivroWidget(
          tema: tema,
          aoClicar: () => aoClicarLivro(livro.numero),
          nomeCategoria: livro.nomeCategoria,
          nomeUsuario: livro.nomeUsuario,
          nomeCidade: livro.nomeMunicipio,
          nomeInstituicao: livro.nomeInstituicao,
          nomeLivro: livro.nomeLivro,
          descricao: livro.descricao,
        );
      },
      itemCount: livros.length,
    ).animate().fade();
  }

  int _obterQuantidadePorLinha(BuildContext context) {
    double largura = MediaQuery
        .of(context)
        .size
        .width;
    if (largura > 1500) return 4;
    if (largura > 1200) return 3;
    if (largura > 800) return 2;
    return 1;
  }
}
