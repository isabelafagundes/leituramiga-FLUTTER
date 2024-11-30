import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_livro.widget.dart';
import 'package:projeto_leituramiga/interface/widget/empty_state.widget.dart';

class GridLivroWidget extends StatelessWidget {
  final Tema tema;
  final Function(ResumoLivro) aoClicarLivro;
  final Function(ResumoLivro)? aoSelecionarLivro;
  final bool Function(ResumoLivro)? verificarSelecao;
  final List<ResumoLivro> livros;
  final bool selecao;
  final bool comScroll;

  const GridLivroWidget({
    super.key,
    required this.tema,
    required this.aoClicarLivro,
    required this.livros,
    this.verificarSelecao,
    this.selecao = false,
    this.comScroll = true,
    this.aoSelecionarLivro,
  });

  @override
  Widget build(BuildContext context) {
    return livros.isEmpty
        ? Container(
            height: Responsive.altura(context) * .5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmptyStateWidget(tema: tema),
              ],
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: comScroll ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _obterQuantidadePorLinha(context),
              mainAxisExtent: 220,
              mainAxisSpacing: tema.espacamento * 2,
              crossAxisSpacing: tema.espacamento * 2,
            ),
            itemBuilder: (ccontext, indice) {
              ResumoLivro livro = livros[indice];
              return CardLivroWidget(
                tema: tema,
                imagem: livro.imagem,
                aoClicar: () => aoClicarLivro(livro),
                aoClicarSelecao: aoSelecionarLivro == null ? null : () => aoSelecionarLivro!(livro),
                nomeCategoria: livro.nomeCategoria,
                nomeUsuario: livro.nomeUsuario,
                nomeCidade: livro.nomeMunicipio,
                ativado: verificarSelecao == null ? false : verificarSelecao!(livro),
                nomeInstituicao: livro.nomeInstituicao,
                nomeLivro: livro.nomeLivro,
                descricao: livro.descricao,
                selecao: selecao,
              );
            },
            itemCount: livros.length,
          );
  }

  int _obterQuantidadePorLinha(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    if (largura > 1400) return 3;
    if (largura > 800) return 2;
    return 1;
  }
}
