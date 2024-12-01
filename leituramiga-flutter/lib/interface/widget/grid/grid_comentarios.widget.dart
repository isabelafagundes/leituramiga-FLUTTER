import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_comentario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/empty_state.widget.dart';

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
    return comentariosPorId.isEmpty
        ? Container(
            height: Responsive.altura(context) * .5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmptyStateWidget(tema: tema),
              ],
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _obterQuantidadePorLinha(context),
              mainAxisExtent: 145,
              mainAxisSpacing: tema.espacamento * 2,
              crossAxisSpacing: tema.espacamento * 2,
            ),
            itemBuilder: (ccontext, indice) {
              ComentarioPerfil comentario = comentariosPorId.values.elementAt(indice);
              return CardComentarioWidget(
                tema: tema,
                dataComentario: comentario.dataCriacao?.formatar() ?? "",
                imagem: comentario.imagem,
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
    if (largura > 1450) return 3;
    if (largura > 1000) return 2;
    return 1;
  }
}
