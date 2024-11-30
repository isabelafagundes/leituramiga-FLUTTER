import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/icone_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class CardComentarioWidget extends StatelessWidget {
  final Tema tema;
  final String nomeUsuario;
  final String comentario;
  final String dataComentario;
  final String? imagem;

  const CardComentarioWidget({
    super.key,
    required this.tema,
    required this.nomeUsuario,
    required this.comentario,
    this.imagem,
    required this.dataComentario,
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
                IconeUsuarioWidget(
                  tema: tema,
                  corLivros: Color(tema.base200),
                  textoPerfil: nomeUsuario,
                  imagem: imagem,
                  quantidadeLivros: null,
                ),
              ],
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
                    tamanho: tema.tamanhoFonteM + 2,
                  ),
                  SizedBox(height: tema.espacamento),
                  Expanded(
                    child: TextoWidget(
                      align: TextAlign.justify,
                      texto: comentario,
                      tema: tema,
                      tamanho: tema.tamanhoFonteM,
                      maxLines: 4,
                    ),
                  ),
                  SizedBox(height: tema.espacamento),
                  TextoWidget(
                    texto: "Data: $dataComentario",
                    tema: tema,
                    tamanho: tema.tamanhoFonteM,
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
