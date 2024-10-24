import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/debouncer.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';

class BarraPesquisaWidget extends StatefulWidget {
  final Tema tema;
  final Function(String) aoPesquisar;
  final TextEditingController controller;
  final String placeholder;

  const BarraPesquisaWidget({
    super.key,
    required this.tema,
    required this.aoPesquisar,
    required this.controller,
    this.placeholder = "Pesquise",
  });

  @override
  State<BarraPesquisaWidget> createState() => _BarraPesquisaWidgetState();
}

class _BarraPesquisaWidgetState extends State<BarraPesquisaWidget> {
  final Debouncer _debouncer = Debouncer(milisegundos: 500);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints:  BoxConstraints(maxWidth: Responsive.largura(context) < 500 ? 300: 350),
      child: Column(
        children: [
          InputWidget(
            alturaCampo: 35,
            tema: widget.tema,
            onChanged: (valor) => _debouncer.executar(() => widget.aoPesquisar(valor)),
            controller: widget.controller,
            label: null,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(6),
              child: SvgWidget(
                nomeSvg: "magnifying-glass",
                cor: Color(widget.tema.baseContent),
                altura: 16,
              ),
            ),
            placeholder: widget.placeholder,
          ),
        ],
      ),
    );
  }
}
