import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/icone_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base_com_sombra.widget.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';

class CardUsuarioWidget extends StatelessWidget {
  final Tema tema;
  final String nomeUsuario;
  final String nome;
  final String? nomeInstituicao;
  final String? nomeCidade;
  final String? imagem;
  final int quantidadeLivros;

  const CardUsuarioWidget({
    super.key,
    required this.tema,
    required this.nomeUsuario,
    this.nomeInstituicao,
    this.nomeCidade,
    required this.quantidadeLivros,
    required this.nome,
    this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return CardBaseComSombraWidget(
      tema: tema,
      padding: EdgeInsets.symmetric(
        vertical: tema.espacamento * 2,
        horizontal: tema.espacamento,
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: IconeUsuarioWidget(
              tema: tema,
              tamanho: 69,
              imagem: imagem,
              corLivros: Color(tema.base100),
              textoPerfil: nomeUsuario,
              quantidadeLivros: quantidadeLivros,
            ),
          ),
          SizedBox(width: tema.espacamento * 2),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextoWidget(
                  tema: tema,
                  texto: "@$nomeUsuario",
                  cor: Color(tema.baseContent),
                  weight: FontWeight.w500,
                  tamanho: tema.tamanhoFonteXG,
                ),
                const Spacer(),
                SizedBox(height: tema.espacamento / 2),
                TextoComIconeWidget(
                  tema: tema,
                  nomeSvg: 'academico/academic-cap',
                  tamanhoFonte: tema.tamanhoFonteM,
                  texto: nomeInstituicao ?? 'Não informado',
                ),
                SizedBox(height: tema.espacamento / 2),
                TextoComIconeWidget(
                  tema: tema,
                  tamanhoFonte: tema.tamanhoFonteM,
                  nomeSvg: 'menu/map-pin-fill',
                  texto: nomeCidade ?? 'Não informado',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
