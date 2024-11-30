import 'dart:convert';
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leituramiga/domain/super/erro_dominio.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';

class ImagemUsuarioWidget extends StatefulWidget {
  final Tema tema;
  final Function(String) salvarImagem;
  final String? imagemBase64;
  final bool visualizacao;

  const ImagemUsuarioWidget({
    super.key,
    required this.tema,
    required this.salvarImagem,
    this.imagemBase64,
    this.visualizacao = false,
  });

  @override
  State<ImagemUsuarioWidget> createState() => _ImagemUsuarioWidgetState();
}

class _ImagemUsuarioWidgetState extends State<ImagemUsuarioWidget> {
  File? imagem;
  bool possuiImagem = false;
  Uint8List? _imagemBytes;
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.imagemBase64 != null || (widget.imagemBase64?.isNotEmpty ?? false)) {
        setState(() => carregando = true);
        carregarImagemIsolate(widget.imagemBase64!);
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
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Color(widget.tema.neutral).withOpacity(.2),
            border: Border.all(color: Color(widget.tema.neutral).withOpacity(.1)),
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG * 4),
          ),
          child: _imagemBytes == null || (widget.imagemBase64?.isEmpty ?? false) || carregando
              ? const SizedBox()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG * 4),
                  child: Image.memory(
                    _imagemBytes!,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.low,
                  ),
                ),
        ),
        if (_imagemBytes != null && !widget.visualizacao)
          Positioned(
            top: -8,
            right: -8,
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

      String nomeArquivo = imagemTemporaria.name;
      String extensao = nomeArquivo.split('.').last.toLowerCase();

      if (!['png', 'jpeg', 'jpg', 'gif'].contains(extensao)) {
        throw Exception("Formato de arquivo não suportado: $extensao");
      }

      final reader = FileReader();
      reader.readAsArrayBuffer(imagemTemporaria);

      await reader.onLoadEnd.first;

      final bytes = reader.result as Uint8List;

      setState(() {
        imagem = imagemTemporaria;
        possuiImagem = true;
        _imagemBytes = bytes;
      });

      String base64 = 'data:image/$extensao;base64,' + base64Encode(bytes);
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

  Future<void> carregarImagemIsolate(String base64) async {
    return await compute((base64) async {
      final bytes = await converterParaUint8List(base64);
      setState(() {
        _imagemBytes = bytes;
        carregando = false;
      });
    }, base64);
  }

  Future<Uint8List> converterParaUint8List(String base64String) async {
    Uint8List bytes = base64Decode(base64String);
    return bytes;
  }
}

class FalhaAoCarregarImagem extends ErroDominio {
  FalhaAoCarregarImagem(super.mensagem) {
    mensagem = "Falha ao carregar imagem";
  }
}
