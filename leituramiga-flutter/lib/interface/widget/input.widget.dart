import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class InputWidget extends StatefulWidget {
  final Tema tema;
  final String? label;
  final String? placeholder;
  final Widget? suffixIcon;
  final bool senha;
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function()? onTap;
  final List<TextInputFormatter>? formatters;
  final double? tamanho;
  final TextInputType? tipoInput;
  final bool readOnly;
  final double alturaCampo;
  final bool expandir;

  const InputWidget({
    super.key,
    required this.tema,
    this.label,
    this.suffixIcon,
    this.senha = false,
    required this.controller,
    this.placeholder,
    required this.onChanged,
    this.formatters,
    this.tamanho,
    this.tipoInput,
    this.readOnly = false,
    this.onTap,
    this.alturaCampo = 45,
    this.expandir = false,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _exibirSenha = false;

  @override
  void initState() {
    super.initState();
    _exibirSenha = widget.senha;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.alturaCampo+20,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            TextoWidget(
              tema: widget.tema,
              texto: widget.label!,
              tamanho: widget.tamanho ?? 12,
              cor: Color(widget.tema.baseContent),
            ),
          SizedBox(height: widget.tema.espacamento / 2),
          Flexible(
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(widget.tema.accent).withOpacity(.3),
                borderRadius: BorderRadius.circular(widget.tema.borderRadiusG),
                boxShadow: [
                  BoxShadow(
                    color: Color(widget.tema.neutral).withOpacity(.15),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                border: Border.all(
                  color: Color(widget.tema.neutral).withOpacity(.2),
                ),
              ),
              child: Container(
             height: widget.alturaCampo,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.tema.borderRadiusG),
                  boxShadow: [
                    BoxShadow(
                      color: Color(widget.tema.base200),
                      spreadRadius: 5,
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    )
                  ],
                ),
                child: TextFormField(
                  onTap: widget.onTap,
                  readOnly: widget.readOnly,
                  expands: widget.expandir,
                  maxLines: widget.expandir ? null : 1,
                  textAlignVertical: TextAlignVertical.top,
                  minLines: widget.expandir ? null : 1,
                  keyboardType: widget.tipoInput ?? TextInputType.text,
                  onChanged: widget.onChanged,
                  cursorColor: Color(widget.tema.accent),
                  controller: widget.controller,
                  style: TextStyle(
                    fontFamily: widget.tema.familiaDeFontePrimaria,
                    fontSize: widget.tema.tamanhoFonteM,
                    color: Color(widget.tema.baseContent),
                  ),
                  obscureText: _exibirSenha,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: widget.tema.espacamento,
                      horizontal: widget.tema.espacamento * 2,
                    ),
                    prefixIcon: widget.suffixIcon,
                    suffixIcon: widget.senha ? _obterBotaoSenha : null,
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                      fontFamily: widget.tema.familiaDeFontePrimaria,
                      fontSize: widget.tema.tamanhoFonteM - 2,
                      fontWeight: FontWeight.w400,
                      color: Color(widget.tema.baseContent).withOpacity(.5),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  inputFormatters: widget.formatters ?? [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _obterBotaoSenha {
    return !_exibirSenha
        ? IconButton(
            padding: const EdgeInsets.all(4),
            onPressed: () => setState(() => _exibirSenha = true),
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: Color(widget.tema.baseContent),
            ),
          )
        : IconButton(
            padding: const EdgeInsets.all(4),
            onPressed: () => setState(() => _exibirSenha = false),
            icon: Icon(
              Icons.remove_red_eye,
              color: Color(widget.tema.baseContent),
            ),
          );
  }
}
