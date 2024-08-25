import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class MenuWidget extends StatefulWidget {
  final Tema tema;
  final List<String> escolhas;
  final Function(String) aoClicar;

  const MenuWidget({
    super.key,
    required this.aoClicar,
    required this.tema,
    required this.escolhas,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  int _indiceHover = -1;
  bool _visivel = false;
  String _label = 'Selecione';

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry != null && _overlayEntry!.mounted) return _removerOverlay();
          setState(() => _visivel = !_visivel);
          RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
          Offset containerPosition = renderBox.localToGlobal(Offset.zero);
          _exibirOverlay(context, containerPosition, renderBox);
        },
        child: Container(
          key: _key,
          height: 40,
          decoration: BoxDecoration(
            color: Color(widget.tema.base200),
            border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
            borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
            boxShadow: [
              BoxShadow(
                color: Color(widget.tema.neutral).withOpacity(.2),
                offset: const Offset(0, 2),
                blurRadius: 5.0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextoWidget(
                  texto: _label,
                  tamanho: 14,
                  maxLines: 1,
                  tema: widget.tema,
                ),
              ),
              Icon(
                _visivel ? Icons.expand_less : Icons.expand_more,
                color: Color(widget.tema.baseContent),
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _exibirOverlay(BuildContext context, Offset containerPosition, RenderBox render) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removerOverlay,
                child: Container(
                  color: Colors.transparent,
                  height: Responsive.altura(context),
                  width: Responsive.largura(context),
                ),
              ),
            ),
            Positioned(
              top: containerPosition.dy + 58,
              left: containerPosition.dx,
              child: GestureDetector(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: render.size.width,
                    height: 200,
                    padding:  EdgeInsets.symmetric(vertical: widget.tema.espacamento+2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
                      color: Color(widget.tema.base200),
                      boxShadow: [
                        BoxShadow(
                          color: Color(widget.tema.neutral).withOpacity(.2),
                          offset: const Offset(0, 2),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.escolhas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(widget.tema.base200),
                              padding: EdgeInsets.symmetric(vertical: widget.tema.espacamento),
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(widget.tema.borderRadiusM), // Border Radius
                              ),
                              textStyle: TextStyle(
                                fontSize: widget.tema.tamanhoFonteM,
                                fontFamily: widget.tema.familiaDeFontePrimaria,
                              ),
                              overlayColor: Color(widget.tema.accent),
                            ),
                            onPressed: () {
                              _removerOverlay();
                              setState(() {
                                _label = widget.escolhas[index];
                                _indiceHover = -1;
                                widget.aoClicar(_label);
                              });
                            },
                            child: TextoWidget(
                              tema: widget.tema,
                              texto: widget.escolhas[index],
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removerOverlay() {
    if (_overlayEntry != null && _overlayEntry!.mounted) _overlayEntry!.remove();
    setState(() => _visivel = false);
  }
}
