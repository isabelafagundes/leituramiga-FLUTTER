import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';

class TextoWidget extends StatelessWidget {
  final Tema tema;
  final String texto;
  final double? tamanho;
  final Color? cor;
  final String? fontFamily;
  final FontWeight? weight;
  final int? maxLines;
  final TextAlign? align;
  final TextDecoration? decoration;

  const TextoWidget({
    super.key,
    required this.texto,
    this.tamanho,
    this.cor,
    this.fontFamily,
    this.weight,
    this.maxLines,
    this.align,
    required this.tema,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: align ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 2,
      style: TextStyle(
        fontWeight: weight ?? FontWeight.w400,
        decoration: decoration,
        fontSize: tamanho ?? tema.tamanhoFonteM,
        fontFamily: fontFamily ?? 'Montserrat',
        color: cor ?? Color(tema.baseContent),
      ),
    );
  }
}
