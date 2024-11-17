import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class IconeUsuarioWidget extends StatelessWidget {
  final Tema tema;
  final double tamanho;
  final Color? corPerfil;
  final Color? corLivros;
  final String textoPerfil;
  final int? quantidadeLivros;

  const IconeUsuarioWidget({
    super.key,
    required this.tema,
    this.tamanho = 60,
    this.corPerfil,
    required this.corLivros,
    required this.textoPerfil,
    required this.quantidadeLivros,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: tamanho,
          height: tamanho,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(tema.borderRadiusXG * 2),
            color: corPerfil ?? obterCorAleatoria(),
          ),
          child: Center(
            child: TextoWidget(
              tamanho: tema.tamanhoFonteXG * 1.4,
              weight: FontWeight.w600,
              texto: "${textoPerfil.substring(0, 1)}",
              tema: tema,
            ),
          ),
        ),
        SizedBox(height: tema.espacamento),
        if (quantidadeLivros != null)
          Container(
            padding: EdgeInsets.symmetric(vertical: tema.espacamento / 3),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(tema.neutral).withOpacity(.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(tema.borderRadiusXG),
              color: corLivros ?? Color(tema.base200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextoWidget(
                  tema: tema,
                  texto: quantidadeLivros.toString(),
                  weight: FontWeight.w500,
                  tamanho: tamanho <= 60 ? tema.tamanhoFonteP + 2 : tema.tamanhoFonteM,
                  cor: Color(tema.baseContent),
                ),
                SizedBox(width: tema.espacamento),
                SvgWidget(
                  nomeSvg: "menu/book-open",
                  cor: Color(tema.accent),
                  altura: tamanho <= 60 ? 13 : 16,
                )
              ],
            ),
          ),
      ],
    );
  }
}
