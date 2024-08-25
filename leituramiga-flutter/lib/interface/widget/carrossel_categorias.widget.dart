import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';

class CarrosselCategoriaWidget extends StatefulWidget {
  final Tema tema;
  final Map<int, Categoria> categoriasPorId;
  final Function(Categoria) selecionarCategoria;
  final int? categoriaSelecionada;

  const CarrosselCategoriaWidget({
    super.key,
    required this.tema,
    required this.categoriasPorId,
    required this.selecionarCategoria,
    this.categoriaSelecionada,
  });

  @override
  State<CarrosselCategoriaWidget> createState() => _CarrosselCategoriaWidgetState();
}

class _CarrosselCategoriaWidgetState extends State<CarrosselCategoriaWidget> {
  final ScrollController _controller = ScrollController();
  List<Color> cores = [];

  @override
  void initState() {
    super.initState();
   
    for (int i = 0; i < widget.categoriasPorId.length; i++) {
      cores.add(_obterCorAleatoria());
    }
  }

  @override
  Widget build(BuildContext context) {
    return cores.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 40,
            width: Responsive.largura(context) <= 500 ? Responsive.largura(context) : 500,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 5),
                  child: ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.categoriasPorId.length,
                    itemBuilder: (context, indice) {
                      Categoria categoria = widget.categoriasPorId.values.toList()[indice];
                      return Row(
                        children: [
                          ChipWidget(
                            tema: widget.tema,
                            cor: cores[indice],
                            aoClicar: () => widget.selecionarCategoria(categoria),
                            texto: categoria.descricao,
                            corTexto: const Color(0xff464A52),
                            ativado: widget.categoriaSelecionada == categoria.numero,
                          ),
                          SizedBox(width: widget.tema.espacamento * 2),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  child: IconButton(
                    color: Color(widget.tema.base200),
                    onPressed: () => _controller.animateTo(
                      _controller.offset - 50,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 200),
                    ),
                    icon: Icon(
                      Icons.chevron_left,
                      color: Color(widget.tema.baseContent),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    color: Color(widget.tema.base200),
                    onPressed: () => _controller.animateTo(
                      _controller.offset + 50,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 200),
                    ),
                    icon: Icon(
                      Icons.chevron_right,
                      color: Color(widget.tema.baseContent),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Color _obterCorAleatoria() {
    final Random random = Random();
    double hue = random.nextDouble() * 360; // Matiz: qualquer valor entre 0 e 360
    double saturation = random.nextDouble() * 0.4 + 0.3; // Saturação baixa: entre 0.3 e 0.7

    return HSLColor.fromAHSL(1.0, hue, saturation, .8).toColor();
  }
}
