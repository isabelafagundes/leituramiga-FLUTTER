import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/menu_lateral.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/botoes_menu_lateral.widget.dart';

class MenuLateralWidget extends StatefulWidget {
  final Tema tema;
  final Function() alterarTema;
  final Function() alterarFonte;

  const MenuLateralWidget({
    super.key,
    required this.tema,
    required this.alterarTema,
    required this.alterarFonte,
  });

  @override
  State<MenuLateralWidget> createState() => _MenuLateralWidgetState();
}

class _MenuLateralWidgetState extends State<MenuLateralWidget> {
  double _larguraExpandida = 250;
  double _larguraMinimizada = 100;
  bool _expandido = false;
  MenuLateral _itemSelecionado = MenuLateral.PAGINA_PRINCIPAL;
  bool _exibirSeta = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      width: _expandido ? _larguraExpandida : _larguraMinimizada,
      padding: EdgeInsets.symmetric(
        vertical: widget.tema.espacamento * 2,
        horizontal: _expandido ? widget.tema.espacamento : 0,
      ),
      decoration: BoxDecoration(
        color: Color(widget.tema.base200),
        border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color(widget.tema.neutral).withOpacity(.15),
            offset: const Offset(0, 3),
            blurRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(widget.tema.borderRadiusM),
      ),
      child: BotoesMenuLateralWidget(
        tema: widget.tema,
        aoEntrar: () => setState(() => _exibirSeta = true),
        aoSair: () => setState(() => _exibirSeta = false),
        exibindoMenu: _expandido,
        exibirSeta: _exibirSeta,
        itemSelecionado: _itemSelecionado,
        expandirMenu: _expandirMenu,
        alterarTema: widget.alterarTema,
        alterarFonte: widget.alterarFonte,
        selecionarItem: (item) => setState(() => _itemSelecionado = item),
      ),
    );
  }

  void _expandirMenu() => setState(() => _expandido = !_expandido);
}
