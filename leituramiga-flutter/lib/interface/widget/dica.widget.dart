import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class DicaWidget extends StatelessWidget {
  final Tema tema;
  final String texto;
  final double? tamanhoFonte;
  final double? tamanhoIcone;

  const DicaWidget({
    super.key,
    required this.tema,
    required this.texto,
    this.tamanhoFonte,
    this.tamanhoIcone,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgWidget(
          nomeSvg: "lamp",
          cor: Colors.yellow,
          altura: tamanhoIcone ?? 20,
        ),
        SizedBox(width: tema.espacamento),
        TextoWidget(
          texto: texto,
          tema: tema,
          maxLines: 5,
          align: TextAlign.center,
          tamanho: tamanhoFonte ?? tema.tamanhoFonteM,
        ),
      ],
    );
  }
}
