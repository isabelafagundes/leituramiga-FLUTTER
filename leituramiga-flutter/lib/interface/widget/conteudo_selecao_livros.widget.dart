import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoSelecaoLivrosWidget extends StatelessWidget {
  final Tema tema;
  final Function(ResumoLivro) aoSelecionarLivro;
  final bool Function(ResumoLivro) verificarSelecao;
  final Function(ResumoLivro) aoClicarLivro;
  final Function()? aceitarSolicitacao;
  final List<ResumoLivro> livros;
  final Function() navegarParaSolicitacao;
  final String textoPopUp;

  const ConteudoSelecaoLivrosWidget({
    super.key,
    required this.tema,
    required this.aoSelecionarLivro,
    required this.verificarSelecao,
    required this.livros,
    required this.navegarParaSolicitacao,
    required this.aoClicarLivro,
    required this.textoPopUp,
    this.aceitarSolicitacao,
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
              texto: "Selecionar livros",
              icone: Icon(
                Icons.check,
                color: kCorFonte,
              ),
              aoClicar: () async {
                bool? navegarParaSolicitacoes = await showDialog(
                  context: context,
                  builder: (BuildContext context) => _obterPopUpPadrao(context),
                );
                if (navegarParaSolicitacoes == null) return;
                if (navegarParaSolicitacoes) return navegarParaSolicitacao();
              },
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
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridLivroWidget(
                    tema: tema,
                    aoClicarLivro: aoClicarLivro,
                    aoSelecionarLivro: aoSelecionarLivro,
                    livros: livros,
                    selecao: true,
                    verificarSelecao: verificarSelecao,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _obterPopUpPadrao(BuildContext context) {
    return PopUpPadraoWidget(
      tema: tema,
      conteudo: Container(
        height: 320,
        child: Column(
          children: [
            SizedBox(height: tema.espacamento * 4),
            Icon(
              Icons.warning_rounded,
              color: Color(tema.baseContent),
              size: 80,
            ),
            SizedBox(height: tema.espacamento * 3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
              child: TextoWidget(
                tema: tema,
                texto: textoPopUp,
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BotaoWidget(
                  tema: tema,
                  icone: Icon(
                    Icons.close,
                    color: kCorFonte,
                  ),
                  texto: "Cancelar",
                  corFundo: Color(tema.error),
                  aoClicar: () => Navigator.of(context).pop(false),
                ),
                SizedBox(height: tema.espacamento * 2),
                BotaoWidget(
                  tema: tema,
                  icone: Icon(
                    Icons.check,
                    color: kCorFonte,
                  ),
                  texto: "Adicionar",
                  aoClicar: () {
                    if (aceitarSolicitacao != null) aceitarSolicitacao!();
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
