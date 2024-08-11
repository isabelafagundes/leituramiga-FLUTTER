import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class TextoComIconeWidget extends StatelessWidget {
  final Tema tema;
  final String nomeSvg;
  final String texto;
  final Color? cor;
  final double? tamanhoFonte;

  const TextoComIconeWidget({
    super.key,
    required this.tema,
    required this.nomeSvg,
    required this.texto,
    this.cor,
    this.tamanhoFonte,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgWidget(
          nomeSvg: nomeSvg,
          cor: cor ?? Color(tema.baseContent),
          altura: tamanhoFonte?? 16,
        ),
        SizedBox(width: tema.espacamento),
        Expanded(
          child: TextoWidget(
            texto: texto,
            maxLines: 1,
            tema: tema,
            tamanho: tamanhoFonte ?? tema.tamanhoFonteP + 2,
            cor: cor ?? Color(tema.baseContent),
          ),
        ),
      ],
    );
  }
}
