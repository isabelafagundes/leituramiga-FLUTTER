import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ChipWidget extends StatelessWidget {
  final Tema tema;
  final Color cor;
  final Color? corTexto;
  final String texto;
  final Function()? aoClicar;
  final bool ativado;

  const ChipWidget({
    super.key,
    required this.tema,
    required this.cor,
    required this.texto,
    this.corTexto,
    this.aoClicar,
    this.ativado = false,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: aoClicar,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: ativado ? tema.espacamento + 2 : tema.espacamento + 4,
            vertical: tema.espacamento / 1.5,
          ),
          decoration: BoxDecoration(
            color: !ativado ? cor : Color(tema.base200),
            borderRadius: BorderRadius.circular(tema.borderRadiusXG),
            border: Border.all(color: Color(tema.neutral).withOpacity(.2)),
          ),
          child: Row(
            children: [
              TextoWidget(
                tema: tema,
                texto: texto,
                cor: ativado ? Color(tema.baseContent) : corTexto,
                weight: FontWeight.w500,
                tamanho: tema.tamanhoFonteP + 2,
              ),
              if (ativado) ...[
                SizedBox(width: tema.espacamento / 1.5),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: cor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: tema.tamanhoFonteM + 2,
                    color: corTexto,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
