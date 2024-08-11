import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_livro.widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GridLivroWidget extends StatelessWidget {
  final Tema tema;
  final Function() aoClicarLivro;

  const GridLivroWidget({
    super.key,
    required this.tema,
    required this.aoClicarLivro,
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
        return CardLivroWidget(
          tema: tema,
          aoClicar: aoClicarLivro,
          nomeCategoria: "Categoria",
          nomeUsuario: "@usuario",
          nomeCidade: "Santana de Parnaíba",
          nomeInstituicao: "FATEC Santana de Parnaíba",
          nomeLivro: "Nome do livro",
          descricao:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque  et malesuada fames ac turpis egestas. Ut a ligula cursus, volutpat lorem.",
        );
      },
      itemCount: 3,
    ).animate().fade();
  }

  int _obterQuantidadePorLinha(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    if (largura > 1500) return 4;
    if (largura > 1200) return 3;
    if (largura > 800) return 2;
    return 1;
  }
}
