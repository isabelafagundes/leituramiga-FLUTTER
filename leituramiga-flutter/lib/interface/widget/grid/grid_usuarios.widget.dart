import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/empty_state.widget.dart';

class GridUsuariosWidget extends StatelessWidget {
  final Tema tema;
  final Function(String) aoClicarUsuario;
  final List<ResumoUsuario> usuarios;

  const GridUsuariosWidget({
    super.key,
    required this.tema,
    required this.aoClicarUsuario,
    required this.usuarios,
  });

  @override
  Widget build(BuildContext context) {
    return usuarios.isEmpty
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
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _obterQuantidadePorLinha(context),
              mainAxisExtent: 140,
              mainAxisSpacing: tema.espacamento * 2,
              crossAxisSpacing: tema.espacamento * 2,
            ),
            itemBuilder: (ccontext, indice) {
              ResumoUsuario usuario = usuarios[indice];
              return GestureDetector(
                onTap: () => aoClicarUsuario(usuario.nomeUsuario),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CardUsuarioWidget(
                    tema: tema,
                    nome: usuario.nome,
                    imagem: usuario.imagem,
                    nomeUsuario: usuario.nomeUsuario,
                    nomeInstituicao: usuario.nomeInstituicao,
                    nomeCidade: usuario.nomeMunicipio,
                    quantidadeLivros: usuario.quantidadeLivros,
                  ),
                ),
              );
            },
            itemCount: usuarios.length,
          );
  }

  int _obterQuantidadePorLinha(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    if (largura > 1400) return 4;
    if (largura > 1200) return 3;
    if (largura > 800) return 2;
    return 1;
  }
}
