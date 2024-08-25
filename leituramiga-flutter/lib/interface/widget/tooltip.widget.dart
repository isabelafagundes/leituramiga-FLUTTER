import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';

class TooltipWidget extends StatelessWidget {
  final Tema tema;
  final String texto;
  final Widget child;
  final bool desativado;

  const TooltipWidget({
    super.key,
    required this.tema,
    required this.texto,
    required this.child,
    this.desativado = false,
  });

  @override
  Widget build(BuildContext context) {
    return desativado
        ? child
        : Tooltip(
            message: texto,
            decoration: BoxDecoration(
              color: Color(tema.base100),
              borderRadius: BorderRadius.circular(tema.borderRadiusM),
              border: Border.all(
                color: Color(tema.neutral).withOpacity(.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(tema.neutral).withOpacity(.1),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                )
              ],
            ),
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: tema.tamanhoFonteM,
              fontFamily: 'Montserrat',
              color: Color(tema.baseContent),
            ),

            child: child,
          );
  }
}
