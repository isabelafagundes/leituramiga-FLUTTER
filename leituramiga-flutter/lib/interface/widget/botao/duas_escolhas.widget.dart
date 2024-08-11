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
            width: 280,
            height: 35,
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
                      width: 133,
                      height: 26,
                      child: Center(
                        child: TextoWidget(
                          tema: widget.tema,
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
                      width: 133,
                      height: 26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
                      ),
                      child: Center(
                        child: TextoWidget(
                          tema: widget.tema,
                          texto: widget.escolhas[1],
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
            left: chave == 0 ? 5 : 145,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Container(
              width: 130,
              height: 26,
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
