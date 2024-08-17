import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/menu_lateral.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_notificacoes.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto_com_switcher.widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BotoesMenuLateralWidget extends StatelessWidget {
  final Tema tema;
  final Function() aoEntrar;
  final Function() aoSair;
  final bool exibindoMenu;
  final bool exibirSeta;
  final MenuLateral itemSelecionado;
  final Function(MenuLateral) selecionarItem;
  final Function() expandirMenu;
  final Function() alterarTema;
  final Function() alterarFonte;

  const BotoesMenuLateralWidget({
    super.key,
    required this.tema,
    required this.aoEntrar,
    required this.aoSair,
    required this.exibindoMenu,
    required this.exibirSeta,
    required this.expandirMenu,
    required this.itemSelecionado,
    required this.alterarTema,
    required this.alterarFonte,
    required this.selecionarItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
          padding: EdgeInsets.symmetric(
            vertical: tema.espacamento,
            horizontal: tema.espacamento / 2,
          ),
          decoration: const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: tema.espacamento),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(exibindoMenu)
                Expanded(
                  child: TextoWidget(
                    texto: "LeiturAmiga",
                    tema: tema,
                    cor: Color(tema.accent),
                    fontFamily: tema.familiaDeFonteSecundaria,
                    weight: FontWeight.w500,
                    tamanho: tema.tamanhoFonteG,
                  ).animate(onComplete: (controller) => controller.repeat()).shimmer(
                        duration: const Duration(seconds: 1),
                        delay: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                      ),
                ),
                if(exibindoMenu)
                SizedBox(width: tema.espacamento),
                FittedBox(
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(tema.neutral).withOpacity(.1)),
                      gradient: LinearGradient(
                        colors: [kCorPessego, Color(tema.accent)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(tema.borderRadiusXG),
                    ),
                    child: SvgWidget(
                      cor: Color(tema.base200),
                      altura: 24,
                      nomeSvg: "menu/book-open",
                    ),
                  ).animate(onComplete: (controller) => controller.repeat()).shimmer(
                    duration: const Duration(seconds: 1),
                    delay: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: tema.espacamento*2),
        ListView.builder(
          itemCount: MenuLateral.values.length,
          shrinkWrap: true,
          itemBuilder: (context, indice) {
            MenuLateral item = MenuLateral.values[indice];
            bool ativado = itemSelecionado == item;
            return Padding(
              padding: EdgeInsets.only(bottom: tema.espacamento),
              child: BotaoMenuWidget(
                tema: tema,
                textoLabel: exibindoMenu ? item.descricao : null,
                nomeSvg: ativado ? item.iconeAtivado : item.iconeDesativado,
                executar: () {
                  selecionarItem(item);
                  if (item.descricao != "Solicitações") {
                    Rota.navegar(context, item.rota);
                  } else {
                    _exibirPopUp(context);
                  }
                },
                ativado: ativado,
              ),
            );
          },
        ),
        const Spacer(),
        TextoComSwitcherWidget(
          tema: tema,
          exibirLabel: exibindoMenu,
          label: "Fonte:",
          primeiroIcone: Center(
            child: TextoWidget(
              texto: "A",
              tema: tema,
              cor: Color(tema.baseContent),
              tamanho: 12,
              weight: FontWeight.w600,
            ),
          ),
          segundoIcone: Center(
            child: TextoWidget(
              texto: "a",
              tema: tema,
              cor: Color(tema.base100),
              tamanho: 12,
              weight: FontWeight.w600,
            ),
          ),
          aoAlterar: alterarFonte,
        ),
        SizedBox(height: tema.espacamento * 2),
        TextoComSwitcherWidget(
          tema: tema,
          exibirLabel: exibindoMenu,
          label: "Tema:",
          segundoIcone: Padding(
            padding: const EdgeInsets.all(2),
            child: SvgWidget(
              nomeSvg: "tema/moon",
              cor: Color(tema.base200),
            ),
          ),
          primeiroIcone: Padding(
            padding: const EdgeInsets.all(2),
            child: SvgWidget(
              nomeSvg: "tema/sun",
              cor: Color(tema.baseContent),
            ),
          ),
          aoAlterar: alterarTema,
        ),
        SizedBox(height: tema.espacamento * 2),
        BotaoMenuWidget(
          tema: tema,
          iconeAEsquerda: false,
          textoLabel: exibindoMenu ? "Sair" : null,
          nomeSvg: "logout",
          executar: () => Rota.navegar(context, Rota.AUTENTICACAO),
          ativado: false,
        ),
      ],
    );
  }

  void _exibirPopUp(BuildContext context) async {
    bool navegarParaSolicitacoes = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUpPadraoWidget(
          tema: tema,
          conteudo: ConteudoNotificacoesWidget(
            tema: tema,
            aoVisualizarSolicitacao: () {
              Navigator.pop(context, true);
            },
          ),
        );
      },
    );
    selecionarItem(navegarParaSolicitacoes ? MenuLateral.SOLICITACOES : MenuLateral.PAGINA_PRINCIPAL);
    Rota.navegar(context, navegarParaSolicitacoes ? Rota.CRIAR_SOLICITACAO : Rota.HOME);
  }
}
