import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/util/sobreposicao.util.dart';

class LayoutFlexivelWidget extends StatefulWidget {
  final Tema tema;
  final Widget overlayChild;
  final Widget drawerChild;
  final double alturaOverlay;
  final double larguraDrawer;
  final EdgeInsets? padding;
  final bool semAnimacao;
  final bool semClose;
  final Color? cor;
  final bool respostaAoFechar;
  final BorderRadiusGeometry? borderRadius;
  final bool scrollableOverlay;
  final bool scrollableDrawer;
  final bool overlayTela;
  final Widget? Function(BuildContext)? popupAoSair;
  final bool desativarScrolls;
  final Function()? executarAntesDeFechar;
  final bool semLayoutFlexivel;

  const LayoutFlexivelWidget({
    super.key,
    required this.tema,
    required this.overlayChild,
    required this.drawerChild,
    this.padding,
    this.borderRadius,
    this.alturaOverlay = 500,
    this.larguraDrawer = 500,
    this.semAnimacao = false,
    this.semClose = false,
    this.respostaAoFechar = false,
    this.scrollableOverlay = true,
    this.scrollableDrawer = true,
    this.cor,
    this.executarAntesDeFechar,
    this.overlayTela = false,
    this.popupAoSair,
    this.desativarScrolls = false,
    this.semLayoutFlexivel = false,
  });

  @override
  State<LayoutFlexivelWidget> createState() => _LayoutFlexivelWidgetState();
}

class _LayoutFlexivelWidgetState extends State<LayoutFlexivelWidget> {
  bool get isMobile => MediaQuery.of(context).size.width < 800;
  final int velocidadeAnimacao = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.semLayoutFlexivel) return;
      SobreposicaoUtil.definirAtualizar(_atualizar);
      SobreposicaoUtil.alterarVisibilidade(semAnimacao: widget.semAnimacao);
      SobreposicaoUtil.definirDimensoes(largura: widget.larguraDrawer);
    });
  }

  void _atualizar() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.semLayoutFlexivel
        ? _conteudoSemLayout
        : Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: widget.semAnimacao ? 1 : SobreposicaoUtil.opacidade,
                  duration: Duration(milliseconds: widget.semAnimacao ? 0 : velocidadeAnimacao),
                  child: GestureDetector(
                    onTap: () async {
                      if (widget.popupAoSair != null && widget.popupAoSair!(context) != null) {
                        await _exibirPopupAoFechar();
                      } else {
                        await _executarAoFechar();
                      }
                    },
                    child: Container(
                      width: Responsive.largura(context),
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(.2),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: widget.semAnimacao ? 0 : velocidadeAnimacao),
                  right: widget.semAnimacao ? null : _obterPosicaoDireita,
                  bottom: widget.semAnimacao ? null : _obterPosicaoInferior,
                  curve: Curves.easeOut,
                  child: LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) =>
                        isMobile ? _layoutOverlay : _layoutDrawer,
                  ),
                )
              ],
            ),
          );
  }

  Widget get _conteudoSemLayout => isMobile ? widget.overlayChild : widget.drawerChild;

  Widget get _layoutOverlay {
    double alturaTela = Responsive.altura(context);
    bool telaCompleta = alturaTela <= widget.alturaOverlay;
    return Container(
      width: Responsive.largura(context),
      height: telaCompleta || widget.overlayTela ? alturaTela : widget.alturaOverlay,
      clipBehavior: Clip.hardEdge,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 2),
      decoration: BoxDecoration(
        color: widget.cor ?? Color(widget.tema.base100),
        borderRadius: widget.borderRadius ??
            BorderRadius.only(
              topLeft: Radius.circular(telaCompleta ? 0 : 36),
              topRight: Radius.circular(telaCompleta ? 0 : 36),
            ),
      ),
      child: widget.desativarScrolls
          ? widget.overlayChild.animate().fade(
                delay: widget.semAnimacao ? null : Duration(milliseconds: velocidadeAnimacao),
                duration: Duration(milliseconds: velocidadeAnimacao),
                curve: Curves.easeOut,
              )
          : SingleChildScrollView(
              physics: widget.scrollableDrawer ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
              child: Column(
                children: [SafeArea(child: widget.overlayChild)],
              ),
            ).animate().fade(
                delay: widget.semAnimacao ? null : Duration(milliseconds: velocidadeAnimacao),
                duration: Duration(milliseconds: velocidadeAnimacao),
                curve: Curves.easeOut,
              ),
    );
  }

  Widget get _layoutDrawer {
    bool isTablet = Responsive.largura(context) < 900;
    return Container(
      clipBehavior: Clip.hardEdge,
      width: isTablet ? Responsive.largura(context) : widget.larguraDrawer,
      height: MediaQuery.of(context).size.height,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 2),
      decoration: BoxDecoration(
        color: widget.cor ?? Color(widget.tema.base100),
        borderRadius: widget.borderRadius ??
            BorderRadius.only(
              topLeft: Radius.circular(isTablet ? 0 : widget.tema.borderRadiusG),
              bottomLeft: Radius.circular(isTablet ? 0 : widget.tema.borderRadiusG),
            ),
      ),
      child: widget.desativarScrolls
          ? widget.drawerChild.animate().fade(
                delay: widget.semAnimacao ? null : Duration(milliseconds: velocidadeAnimacao),
                duration: Duration(milliseconds: velocidadeAnimacao),
                curve: Curves.easeOut,
              )
          : SingleChildScrollView(
              physics: widget.scrollableDrawer ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SafeArea(
                    child: widget.drawerChild.animate().fade(
                          delay: widget.semAnimacao ? null : Duration(milliseconds: velocidadeAnimacao),
                          duration: Duration(milliseconds: velocidadeAnimacao),
                          curve: Curves.easeOut,
                        ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _executarAoFechar() async {
    if (widget.executarAntesDeFechar != null) {
      widget.executarAntesDeFechar!();
    }
    await SobreposicaoUtil.fechar(context, resposta: widget.respostaAoFechar);
  }

  double get _obterPosicaoDireita {
    if (isMobile) return 0;
    return SobreposicaoUtil.visivel ? 0 : -widget.larguraDrawer;
  }

  double get _obterPosicaoInferior {
    if (!isMobile) return 0;
    return SobreposicaoUtil.visivel ? 0 : -widget.alturaOverlay;
  }

  Future<void> _exibirPopupAoFechar() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => widget.popupAoSair!(context)!,
    );
  }
}
