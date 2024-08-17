import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/menu_lateral.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/botoes_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/rodape_mobile.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoMenuLateralWidget extends StatefulWidget {
  final Widget child;
  final Tema tema;
  final Function() alterarTema;
  final Function() alterarFonte;
  final Widget? widgetNoCabecalho;

  const ConteudoMenuLateralWidget({
    super.key,
    required this.child,
    required this.tema,
    required this.alterarTema,
    required this.alterarFonte,
    this.widgetNoCabecalho,
  });

  @override
  State<ConteudoMenuLateralWidget> createState() => _ConteudoMenuLateralWidgetState();
}

class _ConteudoMenuLateralWidgetState extends State<ConteudoMenuLateralWidget> {
  bool exibindoMenu = false;
  bool ativarAnimacao = false;
  MenuLateral _itemSelecionado = MenuLateral.PAGINA_PRINCIPAL;

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
                  alterarTema: widget.alterarTema,
                  alterarFonte: widget.alterarFonte,
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
                          const Spacer(),
                          Column(
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
                      ),
                    ),
                    SizedBox(height: widget.tema.espacamento * 2),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: Responsive.larguraM(context) ? const EdgeInsets.only(bottom: 84) : EdgeInsets.zero,
                        child: widget.child,
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
                    alterarTema: widget.alterarTema,
                    alterarFonte: widget.alterarFonte,
                    selecionarItem: (item) => setState(() => _itemSelecionado = item),
                  ),
                ),
              ],
            ),
          ),
        if (Responsive.larguraM(context))
          Positioned(
            bottom: 0,
            child: RodapeMobileWidget(
              tema: widget.tema,
              itemSelecionado: _itemSelecionado,
              selecionarItem: (item) => setState(() => _itemSelecionado = item),
            ),
          ),
      ],
    );
  }
}
