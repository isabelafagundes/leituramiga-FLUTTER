import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/debouncer.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class MenuWidget extends StatefulWidget {
  final Tema tema;
  final List<String> escolhas;
  final Function(String) aoClicar;
  final TextEditingController controller;
  final String? valorSelecionado;
  final Function() atualizar;
  final bool readOnly;

  const MenuWidget({
    super.key,
    required this.aoClicar,
    required this.tema,
    required this.escolhas,
    this.valorSelecionado,
    required this.atualizar,
    required this.controller,
    this.readOnly = false,
  });

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final GlobalKey _key = GlobalKey();
  FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  int _indiceHover = -1;
  bool _visivel = false;
  String _label = 'Selecione';
  List<String> _escolhasFiltradas = [];
  bool _carregando = false;
  Debouncer _debouncer = Debouncer(milisegundos: 500);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _label = widget.valorSelecionado ?? "Selecione";
      widget.controller.text = _label;
      _escolhasFiltradas = widget.escolhas;
      widget.controller.addListener(() => atualizar());
      atualizar();
    });
  }

  void atualizar() {
    widget.atualizar();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry != null && _overlayEntry!.mounted) return _removerOverlay();
          _visivel = !_visivel;

          _escolhasFiltradas = widget.escolhas;
          atualizar();
          RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
          Offset containerPosition = renderBox.localToGlobal(Offset.zero);
          _exibirOverlay(context, containerPosition, renderBox);
          widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length),
          );
        },
        child: Opacity(
          opacity: widget.readOnly ? 0.8 : 1,
          child: Container(
            key: _key,
            height: 50,
            decoration: BoxDecoration(
              color: Color(widget.tema.base200),
              border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
              borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
              boxShadow: widget.readOnly
                  ? []
                  : [
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
                IgnorePointer(
                  child: Container(
                    height: 50,
                    constraints: BoxConstraints(maxWidth: 150),
                    child: TextFormField(
                      focusNode: _focusNode,
                      cursorColor: _visivel ? Color(widget.tema.accent) : Colors.transparent,
                      controller: widget.controller,
                      onChanged: (texto) async => _debouncer.executar(() => _filtrarEscolhas(texto)),
                      readOnly: !_visivel,
                      autofocus: !_visivel,
                      style: TextStyle(
                        color: Color(widget.tema.baseContent),
                        fontSize: widget.tema.tamanhoFonteM,
                        fontFamily: widget.tema.familiaDeFontePrimaria,
                      ),
                      decoration: InputDecoration(
                        hintText: "Selecione",
                        hintStyle: TextStyle(
                          color: Color(widget.tema.neutral),
                          fontSize: widget.tema.tamanhoFonteM,
                          fontFamily: widget.tema.familiaDeFontePrimaria,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Icon(
                  _visivel ? Icons.expand_less : Icons.expand_more,
                  color: widget.readOnly ? Colors.transparent : Color(widget.tema.baseContent),
                  size: 24,
                )
              ],
            ),
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
                    constraints: const BoxConstraints(maxHeight: 350),
                    padding: EdgeInsets.symmetric(vertical: widget.tema.espacamento + 2),
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
                    child: _carregando
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(widget.tema.accent)),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _escolhasFiltradas.length,
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
                                  widget.controller.text = _escolhasFiltradas[index];
                                  _label = _escolhasFiltradas[index];
                                  _indiceHover = -1;
                                  widget.aoClicar(widget.controller.text);
                                  _escolhasFiltradas = widget.escolhas;
                                  atualizar();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: TextoWidget(
                                    tema: widget.tema,
                                    align: TextAlign.center,
                                    texto: _escolhasFiltradas[index],
                                    tamanho: widget.tema.tamanhoFonteM + 2,
                                  ),
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
    _focusNode.requestFocus();
  }

  Future<void> _filtrarEscolhas(String texto) async {
    setState(() => _carregando = true);

    List<String> escolhasFiltradas = texto.isEmpty || texto == "Selecione"
        ? widget.escolhas
        : widget.escolhas.where((element) => element.toLowerCase().contains(texto.toLowerCase())).toList();

    setState(() {
      _escolhasFiltradas = escolhasFiltradas;
      _carregando = false;
      _visivel = true;
    });

    _overlayEntry?.markNeedsBuild();
  }

  void _removerOverlay() {
    if (widget.controller.text != _label) widget.controller.text = 'Selecione';
    _focusNode.unfocus();
    if (_overlayEntry != null && _overlayEntry!.mounted) _overlayEntry!.remove();
    _visivel = false;
    atualizar();
  }
}
