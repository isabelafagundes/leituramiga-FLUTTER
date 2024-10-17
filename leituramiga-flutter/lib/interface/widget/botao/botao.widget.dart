import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class BotaoWidget extends StatefulWidget {
  final Tema tema;
  final String texto;
  final String? nomeIcone;
  final Widget? icone;
  final Function() aoClicar;
  final Color? corFundo;
  final Color? corTexto;
  final double? largura;
  final double? altura;

  const BotaoWidget({
    super.key,
    required this.tema,
    required this.texto,
    this.nomeIcone,
    this.icone,
    required this.aoClicar,
    this.corFundo,
    this.corTexto,
    this.largura,
    this.altura,
  });

  @override
  State<BotaoWidget> createState() => _BotaoWidgetState();
}

class _BotaoWidgetState extends State<BotaoWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.aoClicar,
        child: Container(
          width: widget.largura ?? 280,
          height: widget.altura ?? 50,
          padding: EdgeInsets.symmetric(
            horizontal: widget.tema.espacamento,
            vertical: widget.tema.espacamento / 3,
          ),
          decoration: BoxDecoration(
            color: widget.corFundo ?? Color(widget.tema.accent),
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
            border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
            boxShadow: [
              BoxShadow(
                color: Color(widget.tema.neutral).withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 2,
              )
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: widget.icone ??
                      SvgWidget(
                        nomeSvg: widget.nomeIcone,
                        cor: widget.corTexto ?? Color(widget.tema.base200),
                        largura: 16,
                      ),
                ),
                SizedBox(width: widget.tema.espacamento),
                TextoWidget(
                  tema: widget.tema,
                  texto: widget.texto,
                  tamanho: widget.tema.tamanhoFonteM,
                  weight: FontWeight.w500,
                  cor: widget.corTexto ?? Color(widget.tema.base200),
                ),
              ],
            ),
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
    );
  }
}
