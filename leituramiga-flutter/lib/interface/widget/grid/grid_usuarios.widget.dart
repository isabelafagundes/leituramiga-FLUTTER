import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_usuario.widget.dart';

class GridUsuariosWidget extends StatelessWidget {
  final Tema tema;
  final Function() aoClicarUsuario;

  const GridUsuariosWidget({
    super.key,
    required this.tema,
    required this.aoClicarUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _obterQuantidadePorLinha(context),
        mainAxisExtent: 140,
        mainAxisSpacing: tema.espacamento * 2,
        crossAxisSpacing: tema.espacamento * 2,
      ),
      itemBuilder: (ccontext, indice) {
        return GestureDetector(
          onTap: aoClicarUsuario,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: CardUsuarioWidget(
              tema: tema,
              nomeUsuario: "@usuario",
              nomeInstituicao: "FATEC Satana de Parnaíba",
              nomeCidade: "Cajamar",
            ),
          ),
        );
      },
      itemCount: 3,
    ).animate().fade();
  }

  int _obterQuantidadePorLinha(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    if (largura > 1500) return 5;
    if (largura > 1200) return 4;
    if (largura > 800) return 3;
    return 1;
  }
}
