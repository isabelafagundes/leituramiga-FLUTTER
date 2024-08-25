import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class CardComentarioWidget extends StatelessWidget {
  final Tema tema;
  final String nomeUsuario;
  final String comentario;

  const CardComentarioWidget({
    super.key,
    required this.tema,
    required this.nomeUsuario,
    required this.comentario,
  });

  @override
  Widget build(BuildContext context) {
    return CardBaseWidget(
      tema: tema,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tema.espacamento * 2,
          horizontal: tema.espacamento,
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tema.borderRadiusXG),
                    color: Color(tema.accent),
                  ),
                ),
                TextoWidget(
                  texto: "@$nomeUsuario",
                  tema: tema,
                  tamanho: tema.tamanhoFonteP + 2,
                ),
              ],
            ),
            SizedBox(width: tema.espacamento * 2),
            Container(
              width: 2,
              height: 100,
              color: Color(tema.accent),
            ),
            SizedBox(width: tema.espacamento * 2),
            Expanded(
              child: TextoWidget(
                texto: comentario,
                tema: tema,
                maxLines: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
