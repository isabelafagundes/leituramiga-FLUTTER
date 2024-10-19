import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leituramiga/domain/super/erro_dominio.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';

class ImagemWidget extends StatefulWidget {
  final Tema tema;
  final Function(String) salvarImagem;
  final String? imagemBase64;
  final bool visualizacao;

  const ImagemWidget({
    super.key,
    required this.tema,
    required this.salvarImagem,
    this.imagemBase64,
    this.visualizacao = false,
  });

  @override
  State<ImagemWidget> createState() => _ImagemWidgetState();
}

class _ImagemWidgetState extends State<ImagemWidget> {
  File? imagem;
  bool possuiImagem = false;
  Uint8List? _imagemBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.imagemBase64 != null) {
        final bytes = converterParaUint8List(widget.imagemBase64!);
        setState(() => _imagemBytes = bytes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: Responsive.largura(context) <= 1000 ? Responsive.largura(context) : Responsive.largura(context) * .4,
          height: Responsive.largura(context) <= 1000 ? 250 : Responsive.altura(context) * .4,
          decoration: BoxDecoration(
            color: Color(widget.tema.neutral).withOpacity(.2),
            border: Border.all(color: Color(widget.tema.neutral).withOpacity(.1)),
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
          ),
          child: _imagemBytes == null
              ? const SizedBox()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
                  child: Image.memory(
                    _imagemBytes!,
                    fit: BoxFit.fill,
                  ),
                ),
        ),
        if (_imagemBytes != null && !widget.visualizacao)
          Positioned(
            top: 8,
            right: 8,
            child: BotaoRedondoWidget(
              tema: widget.tema,
              aoClicar: _abrirImagePicker,
              nomeSvg: 'camera',
              tamanhoIcone: 24,
            ),
          ),
        if (_imagemBytes == null)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IgnorePointer(
              ignoring: widget.visualizacao,
              child: GestureDetector(
                onTap: _abrirImagePicker,
                child: SvgWidget(
                  nomeSvg: "camera",
                  altura: 40,
                  cor: Color(widget.tema.baseContent),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _abrirImagePicker() async {
    try {
      final input = FileUploadInputElement()..accept = 'image/*';
      input.click();

      await input.onChange.first;

      if (input.files?.isEmpty ?? true) return;

      final imagemTemporaria = input.files!.first;

      final reader = FileReader();
      reader.readAsArrayBuffer(imagemTemporaria);

      await reader.onLoadEnd.first;

      final bytes = reader.result as Uint8List;

      setState(() {
        imagem = imagemTemporaria;
        possuiImagem = true;
        _imagemBytes = bytes;
      });

      String base64 = await converterParaBase64(imagem!);
      widget.salvarImagem(base64);
    } catch (e) {
      print("Erro ao carregar imagem: $e");
      Notificacoes.mostrar("Ocorreu um erro ao carregar a imagem.");
      rethrow;
    }
  }

  Future<String> converterParaBase64(File file) async {
    final reader = FileReader();
    reader.readAsArrayBuffer(file);

    await reader.onLoadEnd.first;

    final data = reader.result as List<int>;
    return base64Encode(data);
  }

  Uint8List converterParaUint8List(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return bytes;
  }
}

class FalhaAoCarregarImagem extends ErroDominio {
  FalhaAoCarregarImagem(super.mensagem) {
    mensagem = "Falha ao carregar imagem";
  }
}
