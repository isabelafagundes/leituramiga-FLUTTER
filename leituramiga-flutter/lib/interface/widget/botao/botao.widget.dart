import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class BotaoWidget extends StatelessWidget {
  final Tema tema;
  final String texto;
  final String? nomeIcone;
  final Widget? icone;
  final Function() aoClicar;
  final Color? corFundo;

  const BotaoWidget({
    super.key,
    required this.tema,
    required this.texto,
    this.nomeIcone,
    this.icone,
    required this.aoClicar,
    this.corFundo,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: aoClicar,
        child: Container(
          width: 260,
          height: 45,
          padding: EdgeInsets.symmetric(
            horizontal: tema.espacamento,
            vertical: tema.espacamento / 3,
          ),
          decoration: BoxDecoration(
            color: corFundo ?? Color(tema.accent),
            borderRadius: BorderRadius.circular(tema.borderRadiusXG),
            border: Border.all(color: Color(tema.neutral).withOpacity(.3)),
            boxShadow: [
              BoxShadow(
                color: Color(tema.neutral).withOpacity(.1),
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
                TextoWidget(
                  tema: tema,
                  texto: texto,
                  tamanho: tema.tamanhoFonteM,
                  weight: FontWeight.w500,
                  cor: Color(tema.base200),
                ),
                SizedBox(width: tema.espacamento),
                icone ??
                    SvgWidget(
                      nomeSvg: nomeIcone,
                      cor: Color(tema.base200),
                      largura: 18,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
