import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
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
          direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: [
            DicaWidget(
              tema: tema,
              texto: "Selecione os livros que deseja adicionar na solicitação:",
            ),
            Responsive.larguraP(context) ? SizedBox(height: tema.espacamento * 2) : const Spacer(),
            Row(
              children: [
                BotaoPequenoWidget(
                  tema: tema,
                  aoClicar: navegarParaSolicitacao,
                  label: "Salvar",
                  icone: Icon(
                    Icons.add_circle_outline,
                    color: kCorFonte,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: tema.espacamento * 2),
        livros.isEmpty
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
      ],
    );
  }
}
