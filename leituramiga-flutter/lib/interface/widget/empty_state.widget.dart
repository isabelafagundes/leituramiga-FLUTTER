import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class EmptyStateWidget extends StatelessWidget {
  final Tema tema;

  const EmptyStateWidget({super.key, required this.tema});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgWidget(
            nomeSvg: "empty_state",
            cor: Color(tema.accent),
            altura: Responsive.larguraP(context) ? 120 : 160,
          ),
          SizedBox(height: tema.espacamento),
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: TextoWidget(
              tema: tema,
              align: TextAlign.center,
              texto: "Poxa, não encontramos nada por aqui! :(",
              tamanho: tema.tamanhoFonteXG,
              weight: FontWeight.w500,
            ),
          ),
          SizedBox(height: tema.espacamento * 2),
        ],
      ),
    );
  }
}
