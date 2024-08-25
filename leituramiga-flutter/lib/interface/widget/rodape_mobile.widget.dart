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
      height: 84,
      width: Responsive.largura(context),
      padding: EdgeInsets.symmetric(horizontal: widget.tema.espacamento * 4),
      color: Color(widget.tema.base200),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BotaoMenuWidget(
                tema: widget.tema,
                textoLabel: "",
                semLabel: true,
                executar: () => widget.selecionarItem(MenuLateral.PAGINA_PRINCIPAL),
                ativado: widget.itemSelecionado == MenuLateral.PAGINA_PRINCIPAL,
                nomeSvg: widget.itemSelecionado == MenuLateral.PAGINA_PRINCIPAL
                    ? MenuLateral.PAGINA_PRINCIPAL.iconeAtivado
                    : MenuLateral.PAGINA_PRINCIPAL.iconeDesativado,
              ),
              SizedBox(height: widget.tema.espacamento / 2),
              TextoWidget(
                texto: MenuLateral.PAGINA_PRINCIPAL.descricao,
                tema: widget.tema,
              ),
            ],
          ),
          SizedBox(width: widget.tema.espacamento *4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BotaoMenuWidget(
                tema: widget.tema,
                textoLabel: "",
                semLabel: true,
                executar: () => widget.selecionarItem(MenuLateral.SOLICITACOES),
                ativado: widget.itemSelecionado == MenuLateral.SOLICITACOES,
                nomeSvg: widget.itemSelecionado == MenuLateral.SOLICITACOES
                    ? MenuLateral.SOLICITACOES.iconeAtivado
                    : MenuLateral.SOLICITACOES.iconeDesativado,
              ),
              SizedBox(height: widget.tema.espacamento / 2),
              TextoWidget(
                texto: MenuLateral.SOLICITACOES.descricao,
                tema: widget.tema,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _exibirPopUp(BuildContext context) async {
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
    Rota.navegar(context, navegarParaSolicitacoes ? Rota.CRIAR_SOLICITACAO : Rota.HOME);
  }
}
