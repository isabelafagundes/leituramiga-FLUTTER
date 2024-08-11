import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';

class CardBaseWidget extends StatelessWidget {
  final Tema tema;
  final Color? corFundo;
  final Color? corBorda;
  final Color? corSombra;
  final Border? borda;
  final List<BoxShadow>? sombras;
  final EdgeInsets? padding;
  final Widget child;
  final double? altura;
  final double? largura;
  final bool bordaColorida;
  final BorderRadius? borderRadius;
  final bool cursorDeClick;

  const CardBaseWidget({
    super.key,
    required this.tema,
    this.corFundo,
    this.corBorda,
    this.corSombra,
    this.borda,
    this.sombras,
    this.padding,
    required this.child,
    this.altura,
    this.largura,
    this.bordaColorida = false,
    this.borderRadius,
    this.cursorDeClick = true,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: cursorDeClick ? SystemMouseCursors.click : SystemMouseCursors.alias,
      child: Container(
        height: altura,
        width: bordaColorida && largura != null ? largura! + 6 : largura,
        decoration: BoxDecoration(
          border: borda ?? Border.all(color: Color(tema.neutral).withOpacity(.15)),
          borderRadius: BorderRadius.circular(tema.borderRadiusM),
          boxShadow: [
            BoxShadow(
              color: Color(tema.neutral).withOpacity(.15),
              offset: const Offset(0, 2),
              blurRadius: 2,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(tema.borderRadiusM),
          child: Row(
            children: [
              if (bordaColorida) _obterBordaColorida,
              Expanded(
                child: Container(
                  height: altura,
                  width: largura,
                  padding: padding ??
                      EdgeInsets.symmetric(
                        vertical: tema.espacamento,
                        horizontal: tema.espacamento,
                      ),
                  decoration: BoxDecoration(
                    color: corFundo ?? Color(tema.base200),
                    boxShadow: [
                      BoxShadow(
                        color: Color(tema.neutral).withOpacity(.15),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _obterBordaColorida {
    return SizedBox(
      height: altura,
      child: Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: 4,
              color: kCorPessego,
            ),
          ),
          Flexible(
            child: Container(
              width: 4,
              color: kCorVerde,
            ),
          ),
          Flexible(
            child: Container(
              width: 4,
              color: kCorAzul,
            ),
          ),
        ],
      ),
    );
  }
}
