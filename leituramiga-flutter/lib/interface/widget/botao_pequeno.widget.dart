import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class BotaoPequenoWidget extends StatefulWidget {
  final Tema tema;
  final Function() aoClicar;
  final Color? corFundo;
  final Color? corFonte;
  final String label;
  final Widget? icone;
  final EdgeInsets? padding;

  const BotaoPequenoWidget({
    super.key,
    required this.tema,
    required this.aoClicar,
    this.corFundo,
    this.corFonte,
    required this.label,
    this.icone,
    this.padding,
  });

  @override
  State<BotaoPequenoWidget> createState() => _BotaoPequenoWidgetState();
}

class _BotaoPequenoWidgetState extends State<BotaoPequenoWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.aoClicar,
        child: Container(
          height: 35,
          padding: widget.padding ?? EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 3),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(widget.tema.neutral).withOpacity(.1),
                offset: const Offset(0, 2),
                blurRadius: 2,
              ),
            ],
            color: widget.corFundo ?? Color(widget.tema.accent),
            border: Border.all(color: Color(widget.tema.neutral).withOpacity(.1)),
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.icone != null) ...[
                  widget.icone ?? const SizedBox(),
                  SizedBox(width: widget.tema.espacamento),
                ],
                TextoWidget(
                  tema: widget.tema,
                  weight: FontWeight.w500,
                  cor: widget.corFonte ?? kCorFonte,
                  texto: widget.label,
                  tamanho: widget.tema.tamanhoFonteM + 2,
                ),
              ],
            ),
          ),
        )
            .animate(
                target: _hover ? 1 : 0,
                onComplete: (controller) {
                  if (_hover) controller.repeat();
                })
            .shimmer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            ),
      ),
    );
  }
}
