import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
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
          vertical: tema.espacamento,
          horizontal: tema.espacamento,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tema.borderRadiusXG * 2),
                    color: kCorPessego.withOpacity(.5),
                  ),
                  child: Center(
                    child: TextoWidget(
                      tamanho: tema.tamanhoFonteXG * 1.4,
                      weight: FontWeight.w600,
                      texto: "${nomeUsuario.substring(0, 1)}",
                      tema: tema,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: tema.espacamento),
            Container(
              width: 2,
              height: 100,
              color: Color(tema.accent),
            ),
            SizedBox(width: tema.espacamento * 2),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextoWidget(
                    texto: nomeUsuario,
                    tema: tema,
                    weight: FontWeight.w500,
                    tamanho: tema.tamanhoFonteM,
                  ),
                  SizedBox(height: tema.espacamento),
                  Expanded(
                    child: TextoWidget(
                      align: TextAlign.justify,
                      texto: comentario,
                      tema: tema,
                      maxLines: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
