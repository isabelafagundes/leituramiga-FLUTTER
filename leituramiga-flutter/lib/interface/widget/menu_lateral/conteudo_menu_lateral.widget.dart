import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/menu_lateral.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/botoes_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/rodape_mobile.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoMenuLateralWidget extends StatefulWidget {
  final Widget child;
  final Tema tema;
  final Function()? voltar;
  final Function()? atualizar;
  final Widget? widgetNoCabecalho;
  final bool carregando;
  final bool exibirPerfil;

  const ConteudoMenuLateralWidget({
    super.key,
    required this.child,
    required this.tema,
    this.widgetNoCabecalho,
    this.carregando = false,
    this.exibirPerfil = false,
    this.voltar,
    this.atualizar,
  });

  @override
  State<ConteudoMenuLateralWidget> createState() => _ConteudoMenuLateralWidgetState();
}

class _ConteudoMenuLateralWidgetState extends State<ConteudoMenuLateralWidget> {
  bool exibindoMenu = false;
  bool ativarAnimacao = false;
  MenuLateral _itemSelecionado = MenuLateral.PAGINA_PRINCIPAL;

  TemaState get _temaState => TemaState.instancia;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: widget.tema.espacamento,
            horizontal: widget.tema.espacamento,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!Responsive.larguraM(context)) ...[
                MenuLateralWidget(
                  tema: widget.tema,
                  alterarTema: _alterarTema,
                  alterarFonte: _alterarFonte,
                ),
                SizedBox(width: widget.tema.espacamento * 4),
              ],
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (Responsive.larguraM(context)) ...[
                            BotaoRedondoWidget(
                              tema: widget.tema,
                              nomeSvg: '',
                              icone: Icon(
                                Icons.more_horiz_rounded,
                                color: Color(widget.tema.accent),
                              ),
                              aoClicar: () {
                                setState(() => exibindoMenu = !exibindoMenu);
                                Future.delayed(
                                  const Duration(milliseconds: 100),
                                  () => setState(
                                    () => ativarAnimacao = true,
                                  ),
                                );
                              },
                            ),
                          ],
                          widget.widgetNoCabecalho ?? const SizedBox(),
                          if (widget.exibirPerfil) ...[
                            const Spacer(),
                            SizedBox(
                              height: 60,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextoWidget(
                                    texto: "Olá,",
                                    tema: widget.tema,
                                    cor: Color(widget.tema.baseContent),
                                  ),
                                  TextoWidget(
                                    texto: "Isabela!",
                                    tema: widget.tema,
                                    cor: Color(widget.tema.accent),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: widget.tema.espacamento),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => Rota.navegar(context, Rota.PERFIL),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
                                    color: Color(widget.tema.neutral).withOpacity(.1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          if (!widget.exibirPerfil && widget.voltar != null) ...[
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BotaoPequenoWidget(
                                  tema: widget.tema,
                                  padding: EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 2),
                                  corFundo: Color(widget.tema.base200),
                                  aoClicar: () => Rota.navegar(context, Rota.HOME),
                                  label: "Voltar",
                                  corFonte: Color(widget.tema.baseContent),
                                  icone: Icon(
                                    Icons.chevron_left_outlined,
                                    color: Color(widget.tema.baseContent),
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                    if (widget.exibirPerfil) SizedBox(height: widget.tema.espacamento * 2),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: Responsive.larguraM(context) ? const EdgeInsets.only(bottom: 84) : EdgeInsets.zero,
                        child: widget.carregando
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [CircularProgressIndicator()],
                              )
                            : widget.child,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (exibindoMenu)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  exibindoMenu = false;
                  ativarAnimacao = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(.5),
              ),
            ),
          ),
        if (Responsive.larguraM(context) && !exibindoMenu)
          Positioned(
            bottom: 0,
            child: RodapeMobileWidget(
              tema: widget.tema,
              itemSelecionado: _itemSelecionado,
              selecionarItem: (item) => setState(() => _itemSelecionado = item),
            ),
          ),
        if (exibindoMenu)
          AnimatedPositioned(
            left: ativarAnimacao ? 0 : -200,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 250,
                  padding: EdgeInsets.symmetric(vertical: widget.tema.espacamento * 2),
                  height: Responsive.altura(context),
                  decoration: BoxDecoration(
                    color: Color(widget.tema.base200),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(widget.tema.borderRadiusG),
                      bottomRight: Radius.circular(widget.tema.borderRadiusG),
                    ),
                  ),
                  child: BotoesMenuLateralWidget(
                    tema: widget.tema,
                    aoEntrar: () {},
                    aoSair: () {},
                    exibindoMenu: true,
                    exibirSeta: true,
                    itemSelecionado: _itemSelecionado,
                    expandirMenu: () => setState(() {
                      exibindoMenu = false;
                      ativarAnimacao = false;
                    }),
                    alterarTema: _alterarTema,
                    alterarFonte: _alterarFonte,
                    selecionarItem: (item) => setState(() => _itemSelecionado = item),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _alterarTema() async {
    await _temaState.atualizarTemaPeloId(widget.tema.id == 1 ? 2 : 1, () => setState(() {}));
    if (widget.atualizar != null) widget.atualizar!();
  }

  void _alterarFonte() async {
    await _temaState.atualizarFonteSelecionada(() => setState(() {}));
    if (widget.atualizar != null) widget.atualizar!();
  }
}
