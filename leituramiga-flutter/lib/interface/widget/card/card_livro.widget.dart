import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';

class CardLivroWidget extends StatefulWidget {
  final Tema tema;
  final String nomeLivro;
  final String descricao;
  final String nomeUsuario;
  final String nomeCategoria;
  final String? nomeInstituicao;
  final String? nomeCidade;
  final Function() aoClicar;
  final Function()? aoClicarSelecao;
  final bool ativado;
  final bool selecao;
  final String? imagem;

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
    this.ativado = false,
    this.selecao = false,
    this.aoClicarSelecao,
    required this.imagem,
  });

  @override
  State<CardLivroWidget> createState() => _CardLivroWidgetState();
}

class _CardLivroWidgetState extends State<CardLivroWidget> {
  Uint8List? _imagemBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarImagem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.aoClicar,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: widget.ativado
                  ? BoxDecoration(
                      color: Color(widget.tema.base200),
                      border: Border.all(color: Color(widget.tema.accent), width: 3),
                      borderRadius: BorderRadius.circular(widget.tema.borderRadiusM),
                    )
                  : null,
              child: CardBaseWidget(
                bordaColorida: !widget.ativado,
                tema: widget.tema,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Stack(
                        children: [
                          Container(
                            child: _obterImagem,
                          ),
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: ChipWidget(
                              tema: widget.tema,
                              texto: widget.nomeCategoria,
                              cor: kCorPessego,
                              comSombra: false,
                              corTexto: const Color(0xff464A52),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: widget.tema.espacamento),
                    Flexible(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextoWidget(
                                  tema: widget.tema,
                                  texto: widget.nomeLivro,
                                  cor: Color(widget.tema.baseContent),
                                  weight: FontWeight.w500,
                                  tamanho: widget.tema.tamanhoFonteXG,
                                ),
                              ),
                              if (widget.ativado)
                                Icon(
                                  Icons.check_circle,
                                  color: Color(widget.tema.accent),
                                ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            child: TextoWidget(
                              texto: widget.descricao,
                              tema: widget.tema,
                              cor: Color(widget.tema.baseContent),
                              weight: FontWeight.w400,
                              maxLines: 3,
                              align: TextAlign.justify,
                              tamanho: widget.tema.tamanhoFonteM,
                            ),
                          ),
                          const Spacer(),
                          TextoComIconeWidget(
                            tema: widget.tema,
                            nomeSvg: 'usuario/user',
                            texto: widget.nomeUsuario,
                            tamanhoFonte: widget.tema.tamanhoFonteM,
                          ),
                          SizedBox(height: widget.tema.espacamento / 2),
                          TextoComIconeWidget(
                            tema: widget.tema,
                            nomeSvg: 'academico/academic-cap',
                            texto: widget.nomeInstituicao ?? 'Não informado',
                            tamanhoFonte: widget.tema.tamanhoFonteM,
                          ),
                          SizedBox(height: widget.tema.espacamento / 2),
                          TextoComIconeWidget(
                            tema: widget.tema,
                            nomeSvg: 'menu/map-pin-fill',
                            tamanhoFonte: widget.tema.tamanhoFonteM,
                            texto: widget.nomeCidade ?? 'Não informado',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.selecao)
            Positioned(
              top: 0,
              left: 0,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.aoClicarSelecao,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(widget.tema.neutral).withOpacity(.1), width: 1),
                      color: !widget.ativado ? Color(widget.tema.accent) : Color(widget.tema.base200),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Icon(
                        widget.ativado ? Icons.close : Icons.add,
                        color: widget.ativado ? Color(widget.tema.accent) : Color(widget.tema.base200),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget get _obterImagem {
    if (widget.imagem == null) {
      return Container(
        decoration: BoxDecoration(
          color: Color(widget.tema.neutral).withOpacity(.3),
          borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteP),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported,
                  color: Color(widget.tema.base200),
                  size: widget.tema.tamanhoFonteXG * 2,
                ),
              ],
            ),
          ],
        ),
      );
    }

    if (_imagemBytes == null) return Container();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteM),
        color: Color(widget.tema.neutral).withOpacity(.3),
        image: DecorationImage(
          image: MemoryImage(_imagemBytes!),
          fit: BoxFit.fitHeight,
          filterQuality: FilterQuality.low,
        ),
      ),
    );
  }

  void _carregarImagem() {
    if (widget.imagem == null) {
      return;
    }

    final decodedBytes = base64Decode(widget.imagem!);

    setState(() => _imagemBytes = decodedBytes);
  }
}
