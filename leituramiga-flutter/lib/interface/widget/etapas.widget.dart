import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class EtapasWidget extends StatelessWidget {
  final Tema tema;
  final Color? corFundo;
  final int etapaSelecionada;
  final bool possuiQuatroEtapas;

  const EtapasWidget({
    super.key,
    required this.tema,
    required this.etapaSelecionada,
    this.corFundo,
    this.possuiQuatroEtapas = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: possuiQuatroEtapas ? 200 : 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: possuiQuatroEtapas ? 200 : 150,
            height: 3,
            color: corFundo ?? Color(tema.base100),
          ),
          Row(
            children: [
              _obterWidget(1),
              const Spacer(),
              _obterWidget(2),
              const Spacer(),
              _obterWidget(3),
              if (possuiQuatroEtapas) ...[
                const Spacer(),
                _obterWidget(4),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _obterWidget(int numero) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tema.borderRadiusM),
        color: etapaSelecionada == numero ? Color(tema.accent) : corFundo ?? Color(tema.base100),
      ),
      child: Center(
        child: TextoWidget(
          tema: tema,
          texto: numero.toString(),
          weight: FontWeight.bold,
          cor: etapaSelecionada == numero ? Color(tema.base200) : Color(tema.baseContent),
        ),
      ),
    );
  }
}
