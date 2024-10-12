import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class EtapasWidget extends StatelessWidget {
  final Tema tema;
  final Color? corFundo;
  final int etapaSelecionada;

  const EtapasWidget({
    super.key,
    required this.tema,
    required this.etapaSelecionada,
    this.corFundo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 3,
            color: corFundo ?? Color(tema.base100),
          ),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(tema.borderRadiusM),
                  color: etapaSelecionada == 1 ? Color(tema.accent) : corFundo ?? Color(tema.base100),
                ),
                child: Center(
                  child: TextoWidget(
                    texto: "1",
                    tema: tema,
                    weight: FontWeight.bold,
                    cor: etapaSelecionada == 1 ? const Color(0xff2b2b2b) : Color(tema.baseContent),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(tema.borderRadiusM),
                  color: etapaSelecionada == 2 ? Color(tema.accent) : corFundo ?? Color(tema.base100),
                ),
                child: Center(
                  child: TextoWidget(
                    tema: tema,
                    texto: "2",
                    weight: FontWeight.bold,
                    cor: etapaSelecionada == 2 ? const Color(0xff2b2b2b) : Color(tema.baseContent),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(tema.borderRadiusM),
                  color: etapaSelecionada == 3 ? Color(tema.accent) : corFundo ?? Color(tema.base100),
                ),
                child: Center(
                  child: TextoWidget(
                    tema: tema,
                    texto: "3",
                    weight: FontWeight.bold,
                    cor: etapaSelecionada == 3 ? const Color(0xff2b2b2b) : Color(tema.baseContent),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
