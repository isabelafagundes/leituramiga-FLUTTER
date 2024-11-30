import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class DicaWidget extends StatelessWidget {
  final Tema tema;
  final String texto;
  final double? tamanhoFonte;
  final double? tamanhoIcone;
  final double? largura;

  const DicaWidget({
    super.key,
    required this.tema,
    required this.texto,
    this.tamanhoFonte,
    this.tamanhoIcone,
    this.largura,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: largura != null ? BoxConstraints(maxWidth: largura!) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgWidget(
            nomeSvg: "lamp",
            cor: Colors.orangeAccent,
            altura: tamanhoIcone ?? 20,
          ),
          SizedBox(width: tema.espacamento),
          largura != null
              ? Expanded(
                  child: TextoWidget(
                    texto: texto,
                    tema: tema,
                    maxLines: 5,
                    align: TextAlign.center,
                    tamanho: tamanhoFonte ?? tema.tamanhoFonteM,
                  ),
                )
              : TextoWidget(
                  texto: texto,
                  tema: tema,
                  maxLines: 5,
                  align: TextAlign.center,
                  tamanho: tamanhoFonte ?? tema.tamanhoFonteM,
                ),
        ],
      ),
    );
  }
}
