import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';

class CardLivroWidget extends StatelessWidget {
  final Tema tema;
  final String nomeLivro;
  final String descricao;
  final String nomeUsuario;
  final String nomeCategoria;
  final String? nomeInstituicao;
  final String? nomeCidade;
  final Function() aoClicar;

  const CardLivroWidget({
    super.key,
    required this.tema,
    required this.nomeLivro,
    required this.descricao,
    required this.nomeUsuario,
    this.nomeInstituicao,
    this.nomeCidade,
    required this.nomeCategoria,
    required this.aoClicar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: aoClicar,
      child: Container(
        decoration: false
            ? BoxDecoration(
                border: Border.all(color: Color(tema.accent), width: 3),
                borderRadius: BorderRadius.circular(tema.borderRadiusM),
              )
            : null,
        child: CardBaseWidget(
          bordaColorida: true,
          tema: tema,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(tema.neutral).withOpacity(.1),
                        borderRadius: BorderRadius.circular(tema.tamanhoFonteP),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      left: 4,
                      child: ChipWidget(
                        tema: tema,
                        texto: nomeCategoria,
                        cor: kCorPessego,
                        corTexto: const Color(0xff464A52),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: tema.espacamento),
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (false)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Color(tema.accent),
                          ),
                        ],
                      ),
                    TextoWidget(
                      tema: tema,
                      texto: nomeLivro,
                      cor: Color(tema.baseContent),
                      weight: FontWeight.w500,
                      tamanho: tema.tamanhoFonteG,
                    ),
                    const Spacer(),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: TextoWidget(
                        texto: descricao,
                        tema: tema,
                        cor: Color(tema.baseContent),
                        weight: FontWeight.w400,
                        maxLines: 3,
                        align: TextAlign.justify,
                        tamanho: tema.tamanhoFonteM,
                      ),
                    ),
                    const Spacer(),
                    TextoComIconeWidget(
                      tema: tema,
                      nomeSvg: 'usuario/user',
                      texto: nomeUsuario,
                    ),
                    if (nomeInstituicao != null) ...[
                      SizedBox(height: tema.espacamento / 2),
                      TextoComIconeWidget(
                        tema: tema,
                        nomeSvg: 'academico/academic-cap',
                        texto: nomeInstituicao!,
                      ),
                    ],
                    if (nomeCidade != null) ...[
                      SizedBox(height: tema.espacamento / 2),
                      TextoComIconeWidget(
                        tema: tema,
                        nomeSvg: 'menu/map-pin-fill',
                        texto: nomeCidade!,
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
