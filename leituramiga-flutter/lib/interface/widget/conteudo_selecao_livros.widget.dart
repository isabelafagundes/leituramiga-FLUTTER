import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoSelecaoLivrosWidget extends StatelessWidget {
  final Tema tema;
  final Function(ResumoLivro) aoSelecionarLivro;
  final bool Function(ResumoLivro) verificarSelecao;
  final List<ResumoLivro> livros;
  final Function() navegarParaSolicitacao;

  const ConteudoSelecaoLivrosWidget({
    super.key,
    required this.tema,
    required this.aoSelecionarLivro,
    required this.verificarSelecao,
    required this.livros,
    required this.navegarParaSolicitacao,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            DicaWidget(
              tema: tema,
              texto: "Selecione os livros que deseja adicionar na solicitação:",
            ),
            SizedBox(height: tema.espacamento),
              BotaoWidget(
                tema: tema,
                texto: "Salvar livros",
                icone: Icon(
                  Icons.check,
                  color: kCorFonte,
                ),
                aoClicar: () => navegarParaSolicitacao(),
              ),
          ],
        ),
        SizedBox(height: tema.espacamento * 2),
        Expanded(
          child: livros.isEmpty
              ? Column(
                  children: [
                    TextoWidget(
                      tema: tema,
                      texto: "Nenhum livro selecionado!",
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: tema.espacamento),
                    const SvgWidget(
                      nomeSvg: "empty_state",
                      altura: 80,
                    ),
                  ],
                )
              : GridLivroWidget(
                  tema: tema,
                  aoClicarLivro: aoSelecionarLivro,
                  livros: livros,
                  selecao: true,
                  verificarSelecao: verificarSelecao,
                ),
        ),
      ],
    );
  }
}
