import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/tooltip.widget.dart';

class BotaoMenuWidget extends StatefulWidget {
  final Tema tema;
  final Function() executar;
  final bool ativado;
  final String? textoLabel;
  final String nomeSvg;
  final Color? corFundo;
  final Widget? icone;
  final bool iconeAEsquerda;
  final String? fontFamily;
  final FontWeight? weight;
  final double? tamanhoFonte;
  final bool semLabel;

  const BotaoMenuWidget({
    super.key,
    required this.tema,
    required this.executar,
    required this.ativado,
    this.textoLabel,
    required this.nomeSvg,
    this.icone,
    this.iconeAEsquerda = true,
    this.corFundo,
    this.fontFamily,
    this.weight,
    this.tamanhoFonte,
     this.semLabel=false,
  });

  @override
  State<BotaoMenuWidget> createState() => _BotaoMenuWidgetState();
}

class _BotaoMenuWidgetState extends State<BotaoMenuWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.executar(),
        child: TooltipWidget(
          tema: widget.tema,
          desativado: !widget.semLabel,
          texto: widget.textoLabel!,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 2),
            padding: EdgeInsets.symmetric(
              vertical: widget.tema.espacamento,
              horizontal: widget.tema.espacamento / 2,
            ),
            decoration: BoxDecoration(
              color: widget.ativado || _hover ? widget.corFundo ?? Color(widget.tema.accent) : Color(widget.tema.base200),
              borderRadius: BorderRadius.circular(widget.tema.borderRadiusP),
              border: widget.ativado || _hover
                  ? Border.all(
                      color: Color(widget.tema.neutral).withOpacity(.1),
                      width: 1,
                    )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.tema.espacamento),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.iconeAEsquerda)
                    widget.icone ??
                        SvgWidget(
                          nomeSvg: widget.nomeSvg,
                          altura: 22,
                          cor: widget.ativado || _hover
                              ? Color(widget.tema.base200)
                              : widget.corFundo ?? Color(widget.tema.baseContent),
                        ),
                  if (!widget.semLabel) ...[
                    if (widget.iconeAEsquerda) SizedBox(width: widget.tema.espacamento),
                    Expanded(
                      child: TextoWidget(
                        texto: widget.textoLabel!,
                        tema: widget.tema,
                        fontFamily: widget.fontFamily ?? widget.tema.familiaDeFontePrimaria,
                        weight: widget.weight ?? FontWeight.w400,
                        tamanho: widget.tamanhoFonte ?? widget.tema.tamanhoFonteM,
                        cor: widget.ativado || _hover
                            ? Color(widget.tema.base200)
                            : widget.corFundo ?? Color(widget.tema.baseContent),
                      ),
                    ),
                    if (!widget.iconeAEsquerda) SizedBox(width: widget.tema.espacamento),
                  ],
                  if (!widget.iconeAEsquerda)
                    widget.icone ??
                        SvgWidget(
                          nomeSvg: widget.nomeSvg,
                          altura: 22,
                          cor: widget.ativado || _hover
                              ? Color(widget.tema.base200)
                              : widget.corFundo ?? Color(widget.tema.baseContent),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
