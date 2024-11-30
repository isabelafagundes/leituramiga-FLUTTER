import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

Color obterCorUsuario(int numero) {
  final cores = [
    kCorPessego,
    kCorAzul,
    kCorVerde,
    kCorRoxa,
    kCorRosa,
  ];

  return cores[numero % cores.length];
}

class IconeUsuarioWidget extends StatefulWidget {
  final Tema tema;
  final double tamanho;
  final String? imagem;
  final Color? corPerfil;
  final Color? corLivros;
  final String textoPerfil;
  final int? quantidadeLivros;
  final double? tamanhoFonteLivro;

  const IconeUsuarioWidget({
    super.key,
    required this.tema,
    this.tamanho = 60,
    this.corPerfil,
    required this.corLivros,
    required this.textoPerfil,
    required this.quantidadeLivros,
    this.imagem,
    this.tamanhoFonteLivro,
  });

  @override
  State<IconeUsuarioWidget> createState() => _IconeUsuarioWidgetState();
}

class _IconeUsuarioWidgetState extends State<IconeUsuarioWidget> {
  Uint8List? _imagemBytes;
  bool _carregando = false;
  Widget _imagem = Container();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.imagem != null || (widget.imagem?.isNotEmpty ?? false)) await carregarImagemIsolate(widget.imagem!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.tamanho,
          height: widget.tamanho,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG * 4),
            color: widget.corPerfil ?? obterCorUsuario(widget.textoPerfil.length),
          ),
          child: widget.imagem != null
              ? _imagem
              : Center(
                  child: TextoWidget(
                    tamanho: widget.tema.tamanhoFonteXG * 1.4,
                    weight: FontWeight.w600,
                    texto: "${widget.textoPerfil.substring(0, 1)}".toUpperCase(),
                    tema: widget.tema,
                  ),
                ),
        ),
        if (widget.quantidadeLivros != null) ...[
          SizedBox(height: widget.tema.espacamento),
          Container(
            padding: EdgeInsets.symmetric(vertical: widget.tema.espacamento / 3),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(widget.tema.neutral).withOpacity(.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
              color: widget.corLivros ?? Color(widget.tema.base200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextoWidget(
                  tema: widget.tema,
                  texto: widget.quantidadeLivros.toString(),
                  weight: FontWeight.w500,
                  tamanho: widget.tamanhoFonteLivro ?? widget.tema.tamanhoFonteP + 2,
                  cor: Color(widget.tema.baseContent),
                ),
                SizedBox(width: widget.tema.espacamento),
                SvgWidget(
                  nomeSvg: "menu/book-open",
                  cor: Color(widget.tema.accent),
                  altura: widget.tamanhoFonteLivro ?? 13,
                )
              ],
            ),
          ),
        ]
      ],
    );
  }

  Future<void> carregarImagemIsolate(String base64) async {
    setState(() => _carregando = true);
    return await compute((base64) async => _carregarImagem(), base64);
  }

  void _carregarImagem() {
    if (widget.imagem == null) {
      return;
    }

    final decodedBytes = base64Decode(widget.imagem!);

    setState(() {
      _imagemBytes = decodedBytes;
      _imagem = _obterImagem;
      _carregando = false;
    });
  }

  Widget get _obterImagem {
    if (widget.imagem == null) {
      return Container(
        height: widget.tamanho,
        width: widget.tamanho,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteXG * 4),
          color: Color(widget.tema.neutral).withOpacity(.3),
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
                  size: widget.tema.tamanhoFonteXG,
                ),
              ],
            ),
          ],
        ),
      );
    }
    if (_imagemBytes == null) return Container();

    return Container(
      height: widget.tamanho,
      width: widget.tamanho,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.tema.tamanhoFonteXG * 4),
        color: Color(widget.tema.neutral).withOpacity(.3),
        image: DecorationImage(
          image: MemoryImage(_imagemBytes!),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.low,
        ),
      ),
    );
  }
}
