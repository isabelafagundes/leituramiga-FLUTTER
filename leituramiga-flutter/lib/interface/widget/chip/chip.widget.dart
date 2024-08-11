import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ChipWidget extends StatelessWidget {
  final Tema tema;
  final Color cor;
  final Color? corTexto;
  final String texto;

  const ChipWidget({
    super.key,
    required this.tema,
    required this.cor,
    required this.texto, this.corTexto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: tema.espacamento,
        vertical: tema.espacamento / 3,
      ),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(tema.borderRadiusXG),
        border: Border.all(color: Color(tema.neutral).withOpacity(.2)),
      ),
      child: TextoWidget(
        tema: tema,
        texto: texto,
        cor: corTexto,
        weight: FontWeight.w500,
        tamanho: tema.tamanhoFonteP + 2,
      ),
    );
  }
}
