import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class CardLivrosSolicitacaoWidget extends StatefulWidget {
  final Tema tema;

  const CardLivrosSolicitacaoWidget({super.key, required this.tema});

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
        horizontal: widget.tema.espacamento,
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: Responsive.larguraP(context) ? 250 : 400),
        child: Column(
          children: [
            SizedBox(height: widget.tema.espacamento / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextoWidget(
                  texto: "Livros da solictação",
                  tema: widget.tema,
                  cor: Color(widget.tema.baseContent),
                  tamanho: widget.tema.tamanhoFonteG,
                  weight: FontWeight.w500,
                ),
                const Spacer(),
                BotaoRedondoWidget(
                  tema: widget.tema,
                  nomeSvg: '',
                  icone: Icon(
                    Icons.add,
                    color: Color(widget.tema.accent),
                  ),
                  aoClicar: () {},
                ),
              ],
            ),
            SizedBox(height: widget.tema.espacamento),
            Expanded(
              child: Scrollbar(
                controller: _controller,
                thumbVisibility: true,
                child: ListView.builder(
                  itemCount: 10,
                  controller: _controller,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: widget.tema.espacamento * 2),
                          child: CardBaseWidget(
                            tema: widget.tema,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    color: Color(widget.tema.accent),
                                    onPressed: () {},
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
                                        texto: "Nome livro",
                                        tamanho: widget.tema.tamanhoFonteM,
                                        weight: FontWeight.w500,
                                        tema: widget.tema,
                                      ),
                                      TextoWidget(
                                        texto: "Nome e sobrenome do autor",
                                        tema: widget.tema,
                                        tamanho: widget.tema.tamanhoFonteM - 2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: widget.tema.espacamento),
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
