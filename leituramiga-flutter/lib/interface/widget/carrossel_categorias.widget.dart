import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';

class CarrosselCategoriaWidget extends StatefulWidget {
  final Tema tema;
  final Map<int, String> categoriasPorId;

  const CarrosselCategoriaWidget({
    super.key,
    required this.tema,
    required this.categoriasPorId,
  });

  @override
  State<CarrosselCategoriaWidget> createState() => _CarrosselCategoriaWidgetState();
}

class _CarrosselCategoriaWidgetState extends State<CarrosselCategoriaWidget> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 400,
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
                String categoria = widget.categoriasPorId.values.toList()[indice];
                return Row(
                  children: [
                    ChipWidget(
                      tema: widget.tema,
                      cor: _obterCorAleatoria(),
                      texto: categoria,
                      corTexto: const Color(0xff464A52),
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
