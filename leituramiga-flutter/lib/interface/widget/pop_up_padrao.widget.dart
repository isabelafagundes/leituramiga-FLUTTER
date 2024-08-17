import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';

class PopUpPadraoWidget extends StatelessWidget {
  final Tema tema;
  final double? largura;
  final double? altura;
  final Widget conteudo;

  const PopUpPadraoWidget({
    super.key,
    required this.tema,
    this.largura,
    this.altura,
    required this.conteudo,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.larguraM(context)
        ? Scaffold(
            backgroundColor: Color(tema.base100),
            body: conteudo,
          )
        : AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(tema.borderRadiusG),
              ),
            ),
            backgroundColor: Color(tema.base200),
            contentPadding: EdgeInsets.all(tema.espacamento),
            content: conteudo,
          );
  }
}
