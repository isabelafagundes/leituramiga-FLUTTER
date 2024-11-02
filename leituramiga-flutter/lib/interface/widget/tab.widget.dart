import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class TabWidget extends StatelessWidget {
  final Tema tema;
  final List<String> opcoes;
  final Function(int) aoSelecionar;
  final bool Function(String) validarAtivo;

  const TabWidget({
    super.key,
    required this.tema,
    required this.opcoes,
    required this.aoSelecionar,
    required this.validarAtivo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: opcoes.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String opcao = opcoes[index];
          if(opcao.isEmpty) return SizedBox.shrink();
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => aoSelecionar(index),
              child: Container(
                height: 0,
                padding: EdgeInsets.symmetric(horizontal: tema.espacamento / 2),
                child: Column(
                  children: [
                    TextoWidget(
                      texto: opcao,
                      tamanho: tema.tamanhoFonteM,
                      tema: tema,
                    ),
                    SizedBox(height: tema.espacamento),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: validarAtivo(opcao) ?  Color(tema.accent).withOpacity(.2) : Color(tema.accent),
                      height: 2,
                      width: 100,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
