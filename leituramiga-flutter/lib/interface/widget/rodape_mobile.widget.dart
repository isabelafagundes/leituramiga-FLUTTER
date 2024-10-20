import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/menu_lateral.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_notificacoes.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class RodapeMobileWidget extends StatefulWidget {
  final Tema tema;
  final MenuLateral itemSelecionado;
  final Function(MenuLateral) selecionarItem;

  const RodapeMobileWidget(
      {super.key, required this.tema, required this.itemSelecionado, required this.selecionarItem});

  @override
  State<RodapeMobileWidget> createState() => _RodapeMobileWidgetState();
}

class _RodapeMobileWidgetState extends State<RodapeMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: Responsive.largura(context),
      decoration: BoxDecoration(
        color: Color(widget.tema.base200),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(widget.tema.borderRadiusXG),
          topRight: Radius.circular(widget.tema.borderRadiusXG),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(widget.tema.neutral).withOpacity(.2),
            offset: Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 4),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                FittedBox(
                  child: BotaoMenuWidget(
                    tema: widget.tema,
                    textoLabel: "",
                    semLabel: true,
                    executar: () {
                      widget.selecionarItem(MenuLateral.PAGINA_PRINCIPAL);
                      Rota.navegar(context, MenuLateral.PAGINA_PRINCIPAL.rota);
                    },
                    ativado: widget.itemSelecionado == MenuLateral.PAGINA_PRINCIPAL,
                    nomeSvg: widget.itemSelecionado == MenuLateral.PAGINA_PRINCIPAL
                        ? MenuLateral.PAGINA_PRINCIPAL.iconeAtivado
                        : MenuLateral.PAGINA_PRINCIPAL.iconeDesativado,
                  ),
                ),
                SizedBox(height: widget.tema.espacamento / 2),
                TextoWidget(
                  texto: MenuLateral.PAGINA_PRINCIPAL.descricao,
                  tema: widget.tema,
                  align: TextAlign.center,
                ),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(width: Responsive.larguraP(context) ? widget.tema.espacamento * 2 : widget.tema.espacamento * 4),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                FittedBox(
                  child: BotaoMenuWidget(
                    tema: widget.tema,
                    textoLabel: "",
                    semLabel: true,
                    executar: () {
                      widget.selecionarItem(MenuLateral.SOLICITACOES);
                      _exibirPopUp(context);
                    },
                    ativado: widget.itemSelecionado == MenuLateral.SOLICITACOES,
                    nomeSvg: widget.itemSelecionado == MenuLateral.SOLICITACOES
                        ? MenuLateral.SOLICITACOES.iconeAtivado
                        : MenuLateral.SOLICITACOES.iconeDesativado,
                  ),
                ),
                SizedBox(height: widget.tema.espacamento / 2),
                Expanded(
                  child: TextoWidget(
                    texto: MenuLateral.SOLICITACOES.descricao,
                    align: TextAlign.center,
                    tema: widget.tema,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(width: Responsive.larguraP(context) ? widget.tema.espacamento * 2 : widget.tema.espacamento * 4),
          // Flexible(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       const Spacer(),
          //       FittedBox(
          //         child: BotaoMenuWidget(
          //           tema: widget.tema,
          //           textoLabel: "",
          //           semLabel: true,
          //           executar: () => widget.selecionarItem(MenuLateral.SUPORTE),
          //           ativado: widget.itemSelecionado == MenuLateral.SUPORTE,
          //           nomeSvg: widget.itemSelecionado == MenuLateral.SUPORTE
          //               ? MenuLateral.SUPORTE.iconeAtivado
          //               : MenuLateral.SUPORTE.iconeDesativado,
          //         ),
          //       ),
          //       SizedBox(height: widget.tema.espacamento / 2),
          //       Expanded(
          //         child: TextoWidget(
          //           align: TextAlign.center,
          //           texto: MenuLateral.SUPORTE.descricao,
          //           tema: widget.tema,
          //         ),
          //       ),
          //       const Spacer(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void _exibirPopUp(BuildContext context) async {
    Rota.navegar(context, Rota.HOME);
    bool navegarParaSolicitacoes = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUpPadraoWidget(
          tema: widget.tema,
          conteudo: ConteudoNotificacoesWidget(
            tema: widget.tema,
            aoVisualizarSolicitacao: () {
              Navigator.pop(context, true);
            },
          ),
        );
      },
    );
    widget.selecionarItem(navegarParaSolicitacoes ? MenuLateral.SOLICITACOES : MenuLateral.PAGINA_PRINCIPAL);
    Rota.navegar(context, navegarParaSolicitacoes ? Rota.SUPORTE : Rota.HOME);
  }
}
