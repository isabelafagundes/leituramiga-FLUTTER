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
  bool _carregando = false;
  String? _imagemUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await carregarImagem(widget.imagem);
    });
  }

  bool _ehUrl(String valor) {
    return valor.startsWith('http://') || valor.startsWith('https://');
  }

  Future<void> carregarImagem(String? valor) async {
    if (valor == null || valor.trim().isEmpty) return;

    setState(() {
      _carregando = true;
      _imagemBytes = null;
      _imagemUrl = null;
    });

    try {
      final valorTratado = valor.trim();

      if (_ehUrl(valorTratado)) {
        setState(() {
          _imagemUrl = valorTratado;
          _carregando = false;
        });
        return;
      }

      final bytes = await _converterParaUint8List(valorTratado);

      setState(() {
        _imagemBytes = bytes;
        _carregando = false;
      });
    } catch (_) {
      setState(() {
        _imagemBytes = null;
        _imagemUrl = null;
        _carregando = false;
      });
    }
  }

  Future<Uint8List> _converterParaUint8List(String valor) async {
    String base64String = valor.trim();

    if (base64String.startsWith('data:image')) {
      final partes = base64String.split(',');
      if (partes.length > 1) {
        base64String = partes.last;
      }
    }

    return base64Decode(base64String);
  }

  Widget get _placeholderImagem {
    return Container(
      decoration: BoxDecoration(
        color: Color(widget.tema.neutral).withOpacity(.1),
        borderRadius: BorderRadius.circular(widget.tema.borderRadiusM),
      ),
      child: Center(
        child: Icon(
          Icons.image,
          color: Color(widget.tema.baseContent),
          size: 28,
        ),
      ),
    );
  }

  Widget get _imagemWidget {
    if (widget.imagem == null || widget.imagem!.trim().isEmpty) {
      return _placeholderImagem;
    }

    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_imagemUrl != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteM),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteM),
          child: Image.network(
            _imagemUrl!,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.low,
            width: double.infinity,
            height: double.infinity,
            frameBuilder: (context, child, __, ___) {
              return Container(
                color: Color(widget.tema.neutral).withOpacity(.1),
                child: child,
              );
            },
            errorBuilder: (_, __, ___) {
              return _placeholderImagem;
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
    }

    if (_imagemBytes != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteM),
          color: Color(widget.tema.neutral).withOpacity(.05),
          image: DecorationImage(
            image: MemoryImage(_imagemBytes!),
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.low,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(widget.tema.neutral).withOpacity(.3),
        borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteP),
      ),
      child: Center(
        child: Icon(
          Icons.image_not_supported,
          color: Color(widget.tema.base200),
          size: widget.tema.tamanhoFonteXG * 2,
        ),
      ),
    );
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
                      border: Border.all(
                        color: Color(widget.tema.accent),
                        width: 3,
                      ),
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
                          _imagemWidget,
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: ChipWidget(
                              tema: widget.tema,
                              texto: widget.nomeCategoria,
                              padding: EdgeInsets.symmetric(
                                vertical: widget.tema.espacamento / 2,
                                horizontal: widget.tema.espacamento,
                              ),
                              tamanhoFonte: widget.tema.tamanhoFonteM - 2,
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
                          TextoWidget(
                            texto: widget.descricao,
                            tema: widget.tema,
                            cor: Color(widget.tema.baseContent),
                            weight: FontWeight.w400,
                            maxLines: 3,
                            tamanho: widget.tema.tamanhoFonteM,
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
                      border: Border.all(
                        color: Color(widget.tema.neutral).withOpacity(.1),
                        width: 1,
                      ),
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
}
