import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';

class BotaoRedondoWidget extends StatelessWidget {
  final Tema tema;
  final Function() aoClicar;
  final String nomeSvg;
  final Widget? icone;
  final Color? corIcone;
  final Color? corFundo;

  const BotaoRedondoWidget({
    super.key,
    required this.tema,
    required this.aoClicar,
    required this.nomeSvg,
    this.corIcone,
    this.corFundo,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: aoClicar,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(tema.borderRadiusXG),
            border: Border.all(color: Color(tema.neutral).withOpacity(.2)),
            color: corFundo ?? Color(tema.base200),
            boxShadow: [
              BoxShadow(
                color: Color(tema.neutral).withOpacity(.15),
                offset: const Offset(0, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: icone ??
              SvgWidget(
                nomeSvg: nomeSvg,
                altura: 16,
                cor: corIcone ?? Color(tema.baseContent),
              ),
        ),
      ),
    );
  }
}
