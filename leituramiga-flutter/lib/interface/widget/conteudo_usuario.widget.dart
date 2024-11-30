import 'package:flutter/material.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/icone_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';

class ConteudoUsuarioWidget extends StatelessWidget {
  final Usuario usuario;
  final Tema tema;
  final Widget? widgetInferior;

  const ConteudoUsuarioWidget({
    super.key,
    required this.usuario,
    required this.tema,
    this.widgetInferior,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Responsive.largura(context)),
      child: Flex(
        direction: !Responsive.larguraP(context) ? Axis.horizontal : Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: Responsive.larguraP(context) ? 80 : 100,
              child: IconeUsuarioWidget(
                tema: tema,
                tamanho: Responsive.larguraP(context) ? 80 : 100,
                corPerfil: kCorPessego.withOpacity(.5),
                corLivros: Color(tema.base200),
                textoPerfil: usuario.nome,
                quantidadeLivros: usuario.numeroDeLivros,
              ),
            ),
          ),
          SizedBox(
            width: tema.espacamento * 4,
            height: Responsive.larguraP(context) ? tema.espacamento * 2 : tema.espacamento * 4,
          ),
          Flexible(
            flex: Responsive.larguraP(context) ? 1 : 4,
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: tema.espacamento),
                  Row(
                    children: [
                      Expanded(
                        child: TextoWidget(
                          tema: tema,
                          texto: usuario.nome,
                          cor: Color(tema.baseContent),
                          weight: FontWeight.w500,
                          tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteXG : tema.tamanhoFonteM * 2,
                        ),
                      ),
                      SizedBox(width: tema.espacamento * 2),
                      widgetInferior ?? Container(),
                    ],
                  ),
                  TextoWidget(
                    tema: tema,
                    texto: "@${usuario.nomeUsuario}" ?? "",
                    cor: Color(tema.baseContent),
                    tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteG : tema.tamanhoFonteXG,
                  ),
                  SizedBox(height: tema.espacamento * 2),
                  TextoWidget(
                    tema: tema,
                    texto: usuario.descricao == null || usuario.descricao!.isEmpty
                        ? "Olá, estou usando o LeiturAmiga!"
                        : usuario.descricao!,
                    cor: Color(tema.baseContent),
                    tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteM + 2,
                  ),
                  SizedBox(height: tema.espacamento * 2),
                  TextoComIconeWidget(
                    tema: tema,
                    nomeSvg: 'academico/academic-cap',
                    tamanhoFonte: Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteM + 2,
                    texto: usuario.instituicaoDeEnsino?.nome.toString() ?? "Não informado.",
                  ),
                  SizedBox(height: tema.espacamento / 2),
                  TextoComIconeWidget(
                    tema: tema,
                    nomeSvg: 'menu/map-pin-fill',
                    tamanhoFonte: Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteM + 2,
                    texto: usuario.nomeMunicipio ?? "Não informado.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
