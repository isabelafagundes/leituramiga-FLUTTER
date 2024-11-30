import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/empty_state.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

import 'svg/svg.widget.dart';

class ConteudoSelecaoLivrosWidget extends StatelessWidget {
  final Tema tema;
  final Function(ResumoLivro) aoSelecionarLivro;
  final bool Function(ResumoLivro) verificarSelecao;
  final Function(ResumoLivro) aoClicarLivro;
  final Function()? aceitarSolicitacao;
  final Function()? validarSelecao;
  final List<ResumoLivro> livros;
  final Function() navegarParaSolicitacao;
  final String textoPopUp;
  final bool exibirBotao;

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
    this.exibirBotao = true,
    this.validarSelecao,
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
            if (exibirBotao) ...[
              SizedBox(height: tema.espacamento),
              BotaoWidget(
                tema: tema,
                texto: "Selecionar livros",
                icone: Icon(
                  Icons.check,
                  color: Color(tema.base200),
                ),
                aoClicar: () async {
                  await notificarCasoErro(() async {
                    if (validarSelecao != null) validarSelecao!();

                    bool? navegarParaSolicitacoes = await showDialog(
                      context: context,
                      builder: (BuildContext context) => _obterPopUpPadrao(context),
                    );
                    if (navegarParaSolicitacoes == null) return;
                    if (navegarParaSolicitacoes) return navegarParaSolicitacao();
                  });
                },
              ),
            ]
          ],
        ),
        SizedBox(height: tema.espacamento * 2),
        Expanded(
          child: livros.isEmpty
              ? Column(
                  children: [EmptyStateWidget(tema: tema)],
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
        height: Responsive.larguraP(context) ? Responsive.altura(context) : 320,
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
                    Icons.check,
                    color: Color(tema.base200),
                  ),
                  texto: "Adicionar",
                  aoClicar: () {
                    if (aceitarSolicitacao != null) aceitarSolicitacao!();
                    Navigator.of(context).pop(true);
                  },
                ),
                SizedBox(height: tema.espacamento * 2),
                BotaoWidget(
                  tema: tema,
                  icone: SvgWidget(
                    nomeSvg: 'seta/arrow-long-left',
                    cor: Color(tema.baseContent),
                  ),
                  texto: "Voltar",
                  corFundo: Color(tema.error),
                  aoClicar: () => Navigator.of(context).pop(false),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
