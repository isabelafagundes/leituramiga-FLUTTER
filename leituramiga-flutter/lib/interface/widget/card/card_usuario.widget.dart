import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base_com_sombra.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';

class CardUsuarioWidget extends StatelessWidget {
  final Tema tema;
  final String nomeUsuario;
  final String? nomeInstituicao;
  final String? nomeCidade;
  final int quantidadeLivros;

  const CardUsuarioWidget({
    super.key,
    required this.tema,
    required this.nomeUsuario,
    this.nomeInstituicao,
    this.nomeCidade,
    required this.quantidadeLivros,
  });

  @override
  Widget build(BuildContext context) {
    return CardBaseComSombraWidget(
      tema: tema,
      padding: EdgeInsets.symmetric(
        vertical: tema.espacamento * 2,
        horizontal: tema.espacamento,
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tema.borderRadiusXG),
                    color: Color(tema.neutral).withOpacity(.1),
                  ),
                ),
                SizedBox(height: tema.espacamento),
                Container(
                  width: 70,
                  padding: EdgeInsets.symmetric(vertical: tema.espacamento / 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tema.borderRadiusXG),
                    color: Color(tema.base100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextoWidget(
                        tema: tema,
                        texto: quantidadeLivros.toString(),
                        tamanho: tema.tamanhoFonteP + 2,
                        cor: Color(tema.baseContent),
                      ),
                      SizedBox(width: tema.espacamento / 2),
                      SvgWidget(
                        nomeSvg: "menu/book-open",
                        cor: Color(tema.accent),
                        altura: 14,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: tema.espacamento * 2),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextoWidget(
                  tema: tema,
                  texto: "@$nomeUsuario",
                  cor: Color(tema.baseContent),
                  weight: FontWeight.w500,
                  tamanho: tema.tamanhoFonteXG,
                ),
                const Spacer(),
                if (nomeInstituicao != null) ...[
                  SizedBox(height: tema.espacamento / 2),
                  TextoComIconeWidget(
                    tema: tema,
                    nomeSvg: 'academico/academic-cap',
                    tamanhoFonte: tema.tamanhoFonteM,
                    texto: nomeInstituicao!,
                  ),
                ],
                if (nomeCidade != null) ...[
                  SizedBox(height: tema.espacamento / 2),
                  TextoComIconeWidget(
                    tema: tema,
                    tamanhoFonte: tema.tamanhoFonteM,
                    nomeSvg: 'menu/map-pin-fill',
                    texto: nomeCidade!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
