import 'package:flutter/material.dart';
import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_comentario.widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GridComentarioWidget extends StatelessWidget {
  final Tema tema;
  final Function() aoClicarComentario;
  final Map<int, ComentarioPerfil> comentariosPorId;

  const GridComentarioWidget({
    super.key,
    required this.tema,
    required this.aoClicarComentario,
    required this.comentariosPorId,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _obterQuantidadePorLinha(context),
        mainAxisExtent: 120,
        mainAxisSpacing: tema.espacamento * 2,
        crossAxisSpacing: tema.espacamento * 2,
      ),
      itemBuilder: (ccontext, indice) {
        ComentarioPerfil comentario = comentariosPorId.values.elementAt(indice);
        return CardComentarioWidget(
          tema: tema,
          nomeUsuario: comentario.nomeUsuarioCriador,
          comentario: comentario.comentario,
        );
      },
      itemCount: comentariosPorId.length,
    ).animate().fade();
  }

  int _obterQuantidadePorLinha(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    if (largura > 1500) return 4;
    if (largura > 1200) return 3;
    if (largura > 800) return 2;
    return 1;
  }
}
