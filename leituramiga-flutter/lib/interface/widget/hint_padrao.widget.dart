import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';

class HintPadraoWidget extends StatelessWidget {
  final Tema tema;
  final String textoTooltip;
  final double? tamanhoIcone;
  final bool abaixo;
  final Widget? child;
  final bool exibir;

  const HintPadraoWidget({
    super.key,
    required this.textoTooltip,
    this.tamanhoIcone,
    required this.tema,
    this.abaixo = false,
    this.child,
    this.exibir = true,
  });

  @override
  Widget build(BuildContext context) {
    if(!exibir) return Container();
    return Tooltip(
      richMessage: WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: EdgeInsets.all(tema.espacamento * 2),
          decoration: BoxDecoration(
            border: Border.all(color: Color(tema.neutral).withOpacity(.1)),
            color: Color(tema.base200),
            borderRadius: BorderRadius.circular(tema.borderRadiusM),
            boxShadow: [
              BoxShadow(
                color: Color(tema.neutral).withOpacity(.1),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              textoTooltip,
              style: TextStyle(
                color: Color(tema.baseContent),
                fontSize: tema.tamanhoFonteM,
                fontFamily: tema.familiaDeFontePrimaria,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      triggerMode: TooltipTriggerMode.tap,
      preferBelow: abaixo,
      verticalOffset: tema.espacamento * 2,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: child ??
            Icon(
              Icons.help_sharp,
              color: Color(tema.baseContent).withOpacity(.5),
              size: tamanhoIcone ?? 26,
            ),
      ),
    );
  }
}
