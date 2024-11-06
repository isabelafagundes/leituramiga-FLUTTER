import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class LogoWidget extends StatelessWidget {
  final Tema tema;
  final double? tamanho;

  const LogoWidget({super.key, required this.tema, this.tamanho});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextoWidget(
            texto: "LeiturAmiga",
            tema: tema,
            cor: Color(tema.accent),
            fontFamily: tema.familiaDeFonteSecundaria,
            weight: FontWeight.w500,
            tamanho: tamanho?? tema.tamanhoFonteG,
          ).animate(onComplete: (controller) => controller.repeat()).shimmer(
                duration: const Duration(seconds: 1),
                delay: const Duration(seconds: 1),
                curve: Curves.easeOut,
              ),
        ),
        SizedBox(width: tema.espacamento / 2),
        FittedBox(
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(color: Color(tema.neutral).withOpacity(.1)),
              gradient: LinearGradient(
                colors: [kCorPessego, kCorPessego],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(tema.borderRadiusXG),
            ),
            child: SvgWidget(
              cor: Color(tema.base200),
              altura: 24,
              nomeSvg: "menu/book-open",
            ),
          ).animate(onComplete: (controller) => controller.repeat()).shimmer(
                duration: const Duration(seconds: 1),
                delay: const Duration(seconds: 1),
                curve: Curves.easeOut,
              ),
        ),
      ],
    );
  }
}
