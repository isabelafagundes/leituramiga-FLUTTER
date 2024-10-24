import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';

class BotaoNotificacaoWidget extends StatelessWidget {
  final Function() aoClicar;
  final Tema tema;
  final bool modoMinimizado;
  final bool modoMobile;
  final int numeroNotificacoes;

  const BotaoNotificacaoWidget({
    super.key,
    required this.aoClicar,
    required this.numeroNotificacoes,
    required this.tema,
    required this.modoMinimizado,
    this.modoMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        modoMobile
            ? BotaoRedondoWidget(
                tema: tema,
                aoClicar: aoClicar,
                corFundo: numeroNotificacoes == 0 ? Color(tema.base200) : Color(tema.accent),
                corIcone: numeroNotificacoes == 0 ? Color(tema.baseContent) : kCorFonte,
                nomeSvg: numeroNotificacoes > 0 ? "bell-alert" : "bell",
                tamanhoIcone: 35,
              )
            : BotaoPequenoWidget(
                tema: tema,
                aoClicar: aoClicar,
                padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
                corFonte: numeroNotificacoes == 0 ? Color(tema.baseContent) : kCorFonte,
                corFundo: numeroNotificacoes == 0 ? Color(tema.base200) : Color(tema.accent),
                icone: SvgWidget(
                  nomeSvg: numeroNotificacoes > 0 ? "bell-alert" : "bell",
                  cor: numeroNotificacoes > 0 ? kCorFonte : Color(tema.baseContent),
                ),
                label: modoMinimizado ? "" : "Notificações",
              ),
        if (numeroNotificacoes > 0)
          Positioned(
            top: -12,
            right: -8,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(tema.accent), width: .5),
                color: Color(tema.base100),
                shape: BoxShape.circle,
              ),
              child: Text(
                numeroNotificacoes.toString(),
                style: TextStyle(
                  color: Color(tema.accent),
                  fontSize: tema.tamanhoFonteM,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
