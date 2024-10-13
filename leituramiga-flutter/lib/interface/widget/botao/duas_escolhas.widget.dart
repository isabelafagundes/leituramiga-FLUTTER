import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class DuasEscolhasWidget extends StatefulWidget {
  final Tema tema;
  final List<String> escolhas;
  final Function() aoClicarPrimeiraEscolha;
  final Function() aoClicarSegundaEscolha;

  const DuasEscolhasWidget({
    super.key,
    required this.tema,
    required this.escolhas,
    required this.aoClicarPrimeiraEscolha,
    required this.aoClicarSegundaEscolha,
  });

  @override
  State<DuasEscolhasWidget> createState() => _DuasEscolhasWidgetState();
}

class _DuasEscolhasWidgetState extends State<DuasEscolhasWidget> {
  int chave = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              color: Color(widget.tema.base200),
              borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
              border: Border.all(color: Color(widget.tema.neutral).withOpacity(.2)),
              boxShadow: [
                BoxShadow(
                  color: Color(widget.tema.neutral).withOpacity(.1),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _alterar(0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
                      ),
                      width: 143,
                      height: 31,
                      child: Center(
                        child: TextoWidget(
                          tema: widget.tema,
                          tamanho: widget.tema.tamanhoFonteM + 2,
                          texto: widget.escolhas[0],
                          cor: Color(widget.tema.baseContent),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _alterar(1),
                    child: Container(
                      width: 143,
                      height: 31,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
                      ),
                      child: Center(
                        child: TextoWidget(
                          tema: widget.tema,
                          texto: widget.escolhas[1],
                          tamanho: widget.tema.tamanhoFonteM + 2,
                          cor: Color(widget.tema.baseContent),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            left: chave == 0 ? 5 : 152,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Container(
              width: 143,
              height: 31,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(widget.tema.neutral).withOpacity(.1),
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                color: Color(widget.tema.accent),
                borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
              ),
              child: Center(
                child: TextoWidget(
                  tema: widget.tema,
                  cor: Color(widget.tema.base200),
                  weight: FontWeight.w600,
                  tamanho: widget.tema.tamanhoFonteM + 2,
                  texto: widget.escolhas[chave],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _alterar(int chaveEscolha) {
    chaveEscolha == 0 ? widget.aoClicarPrimeiraEscolha() : widget.aoClicarSegundaEscolha();
    setState(() => chave = chaveEscolha);
  }
}
