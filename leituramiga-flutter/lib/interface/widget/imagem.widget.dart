import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
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
  bool carregando = false;
  String? _imagemUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.imagemBase64 != null && widget.imagemBase64!.trim().isNotEmpty) {
        _carregarImagem(widget.imagemBase64!);
      }
    });
  }

  Future<void> _carregarImagem(String valor) async {
    setState(() {
      carregando = true;
      _imagemBytes = null;
      _imagemUrl = null;
    });

    try {
      final valorTratado = valor.trim();

      if (_ehUrl(valorTratado)) {
        setState(() {
          _imagemUrl = valorTratado;
          carregando = false;
        });
        return;
      }

      final bytes = await converterParaUint8List(valorTratado);

      setState(() {
        _imagemBytes = bytes;
        carregando = false;
      });
    } catch (e) {
      setState(() => carregando = false);
      Notificacoes.mostrar("Ocorreu um erro ao carregar a imagem.");
      rethrow;
    }
  }

  bool _ehUrl(String valor) {
    return valor.startsWith('http://') || valor.startsWith('https://');
  }

  bool get _possuiImagem => _imagemBytes != null || _imagemUrl != null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: Responsive.largura(context) <= 1000
              ? Responsive.largura(context)
              : Responsive.largura(context) * .4,
          height: Responsive.largura(context) <= 1000
              ? 250
              : Responsive.altura(context) * .4,
          decoration: BoxDecoration(
            color: Color(widget.tema.neutral).withOpacity(.2),
            border: Border.all(
              color: Color(widget.tema.neutral).withOpacity(.1),
            ),
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
          ),
          child: carregando
              ? const Center(child: CircularProgressIndicator())
              : !_possuiImagem
              ? const SizedBox()
              : ClipRRect(
            borderRadius:
            BorderRadius.circular(widget.tema.borderRadiusXG),
            child: _imagemUrl != null
                ? Image.network(
              _imagemUrl!,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.low,
              errorBuilder: (_, __, ___) {
                return const Center(
                  child: Text('Erro ao carregar imagem'),
                );
              },
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
                : Image.memory(
              _imagemBytes!,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.low,
            ),
          ),
        ),
        if (_possuiImagem && !widget.visualizacao)
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
        if (!_possuiImagem && !carregando)
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

      final nomeArquivo = imagemTemporaria.name;
      final extensao = nomeArquivo.split('.').last.toLowerCase();

      if (!['png', 'jpeg', 'jpg', 'gif'].contains(extensao)) {
        throw Exception("Formato de arquivo não suportado: $extensao");
      }

      final reader = FileReader();
      reader.readAsArrayBuffer(imagemTemporaria);

      await reader.onLoadEnd.first;

      final bytes = Uint8List.fromList(reader.result as List<int>);

      setState(() {
        imagem = imagemTemporaria;
        possuiImagem = true;
        _imagemBytes = bytes;
        _imagemUrl = null;
      });

      final base64 = 'data:image/$extensao;base64,${base64Encode(bytes)}';
      widget.salvarImagem(base64);
    } catch (e) {
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

  Future<Uint8List> converterParaUint8List(String valor) async {
    String base64String = valor.trim();

    if (base64String.startsWith('data:image')) {
      final partes = base64String.split(',');
      if (partes.length > 1) {
        base64String = partes.last;
      }
    }

    return base64Decode(base64String);
  }
}

class FalhaAoCarregarImagem extends ErroDominio {
  FalhaAoCarregarImagem(super.mensagem) {
    mensagem = "Falha ao carregar imagem";
  }
}