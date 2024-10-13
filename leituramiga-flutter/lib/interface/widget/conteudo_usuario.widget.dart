import 'package:flutter/material.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
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
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(tema.borderRadiusXG * 2),
                      color: [kCorAzul, kCorPessego, kCorVerde, Color(tema.accent)][usuario.numeroDeLivros % 4]
                          .withOpacity(.5),
                    ),
                    child: Center(
                      child: TextoWidget(
                        tamanho: tema.tamanhoFonteXG * 1.4,
                        weight: FontWeight.w600,
                        texto: "${usuario.nome.substring(0, 1)}",
                        tema: tema,
                      ),
                    ),
                  ),
                  SizedBox(height: tema.espacamento),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: tema.espacamento / 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(tema.borderRadiusXG),
                      color: Color(tema.base200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextoWidget(
                          tema: tema,
                          texto: usuario.numeroDeLivros.toString(),
                          tamanho: tema.tamanhoFonteM,
                          cor: Color(tema.baseContent),
                        ),
                        SizedBox(width: tema.espacamento),
                        SvgWidget(
                          nomeSvg: "menu/book-open",
                          cor: Color(tema.accent),
                          altura: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: tema.espacamento * 4,
            height: tema.espacamento * 4,
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
                      TextoWidget(
                        tema: tema,
                        texto: usuario.nome,
                        cor: Color(tema.baseContent),
                        weight: FontWeight.w500,
                        tamanho: tema.tamanhoFonteM * 2,
                      ),
                      SizedBox(width: tema.espacamento * 2),
                      widgetInferior ?? Container(),
                    ],
                  ),
                  TextoWidget(
                    tema: tema,
                    texto: "@${usuario.nomeUsuario}" ?? "",
                    cor: Color(tema.baseContent),
                    tamanho: tema.tamanhoFonteXG,
                  ),
                  SizedBox(height: tema.espacamento * 2),
                  TextoWidget(
                    tema: tema,
                    texto: usuario.descricao == null || usuario.descricao!.isEmpty
                        ? "Olá, estou usando o LeiturAmiga!"
                        : usuario.descricao!,
                    cor: Color(tema.baseContent),
                    tamanho: tema.tamanhoFonteM + 2,
                  ),
                  SizedBox(height: tema.espacamento * 2),
                  TextoComIconeWidget(
                    tema: tema,
                    nomeSvg: 'academico/academic-cap',
                    tamanhoFonte: tema.tamanhoFonteM + 2,
                    texto: usuario.instituicaoDeEnsino?.nome.toString() ?? "Não informado.",
                  ),
                  SizedBox(height: tema.espacamento / 2),
                  TextoComIconeWidget(
                    tema: tema,
                    nomeSvg: 'menu/map-pin-fill',
                    tamanhoFonte: tema.tamanhoFonteM + 2,
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
