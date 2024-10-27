import 'package:flutter/material.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class CardLivrosSolicitacaoWidget extends StatefulWidget {
  final Tema tema;
  final Function() aoClicarAdicionarLivro;
  final List<LivroSolicitacao> livrosSolicitacao;
  final Function(LivroSolicitacao) removerLivro;

  const CardLivrosSolicitacaoWidget({
    super.key,
    required this.tema,
    required this.aoClicarAdicionarLivro,
    required this.livrosSolicitacao,
    required this.removerLivro,
  });

  @override
  State<CardLivrosSolicitacaoWidget> createState() => _CardLivrosSolicitacaoWidgetState();
}

class _CardLivrosSolicitacaoWidgetState extends State<CardLivrosSolicitacaoWidget> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CardBaseWidget(
      tema: widget.tema,
      padding: EdgeInsets.symmetric(
        vertical: widget.tema.espacamento,
        horizontal: widget.tema.espacamento * 2,
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: Responsive.larguraP(context) ? 250 : Responsive.altura(context) * .66),
        child: Column(
          children: [
            SizedBox(height: widget.tema.espacamento / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextoWidget(
                  texto: "Livros da solicitação",
                  tema: widget.tema,
                  cor: Color(widget.tema.baseContent),
                  tamanho: Responsive.larguraP(context)?widget.tema.tamanhoFonteM :widget.tema.tamanhoFonteXG + 4,
                  weight: FontWeight.w500,
                ),
                const Spacer(),
                BotaoPequenoWidget(
                  tema: widget.tema,
                  label: "Adicionar livro",
                  tamanhoFonte: widget.tema.tamanhoFonteM,
                  padding: EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 2),
                  icone: Icon(
                    Icons.add,
                    color: Color(widget.tema.base200),
                  ),
                  aoClicar: widget.aoClicarAdicionarLivro,
                ),
              ],
            ),
            SizedBox(height: widget.tema.espacamento * 2),
            Expanded(
              child: widget.livrosSolicitacao.isEmpty
                  ? Opacity(
                      opacity: 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgWidget(
                            nomeSvg: "empty_state",
                            cor: Color(widget.tema.accent),
                            altura: Responsive.larguraP(context) ? 120 : 160,
                          ),
                          SizedBox(height: widget.tema.espacamento),
                          TextoWidget(
                            tema: widget.tema,
                            texto: "Nenhum livro selecionado!",
                            tamanho: widget.tema.tamanhoFonteXG,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(height: widget.tema.espacamento * 2),
                        ],
                      ),
                    )
                  : Scrollbar(
                      controller: _controller,
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: widget.livrosSolicitacao.length,
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          LivroSolicitacao livro = widget.livrosSolicitacao[index];
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: widget.tema.espacamento),
                                child: CardBaseWidget(
                                  tema: widget.tema,
                                  child: Padding(
                                    padding: EdgeInsets.all(widget.tema.espacamento * 1.5),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          color: Color(widget.tema.accent),
                                          onPressed: () => widget.removerLivro(livro),
                                          icon: Icon(
                                            Icons.close,
                                            color: Color(widget.tema.accent),
                                          ),
                                        ),
                                        const Spacer(),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            TextoWidget(
                                              texto: livro.nome,
                                              tamanho: widget.tema.tamanhoFonteXG,
                                              weight: FontWeight.w500,
                                              tema: widget.tema,
                                            ),
                                            SizedBox(height: widget.tema.espacamento),
                                            TextoWidget(
                                              texto: livro.nomeAutor,
                                              tema: widget.tema,
                                              tamanho: widget.tema.tamanhoFonteM + 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: widget.tema.espacamento*2),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
