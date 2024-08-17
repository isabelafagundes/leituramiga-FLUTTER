import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BotaoRedondoWidget extends StatefulWidget {
  final Tema tema;
  final Function() aoClicar;
  final String nomeSvg;
  final Widget? icone;
  final Color? corIcone;
  final Color? corFundo;
  final EdgeInsets? padding;

  const BotaoRedondoWidget({
    super.key,
    required this.tema,
    required this.aoClicar,
    required this.nomeSvg,
    this.corIcone,
    this.corFundo,
    this.icone,
    this.padding,
  });

  @override
  State<BotaoRedondoWidget> createState() => _BotaoRedondoWidgetState();
}

class _BotaoRedondoWidgetState extends State<BotaoRedondoWidget> {
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
          padding: widget.padding ?? const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
            border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
            color: widget.corFundo ?? Color(widget.tema.base200),
            boxShadow: [
              BoxShadow(
                color: Color(widget.tema.neutral).withOpacity(.15),
                offset: const Offset(0, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: widget.icone ??
              SvgWidget(
                nomeSvg: widget.nomeSvg,
                altura: 16,
                cor: widget.corIcone ?? Color(widget.tema.baseContent),
              ),
        ),
      ).animate(target: _hover ? 1 : 0, onComplete: (controller) {
        if(_hover) controller.repeat();
      }).shimmer(
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      ),
    );
  }
}
