import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class CardSolicitacaoWidget extends StatefulWidget {
  final Tema tema;
  final Function() aoVisualizar;

  const CardSolicitacaoWidget({required this.tema, super.key, required this.aoVisualizar});

  @override
  State<CardSolicitacaoWidget> createState() => _CardSolicitacaoWidgetState();
}

class _CardSolicitacaoWidgetState extends State<CardSolicitacaoWidget> {
  @override
  Widget build(BuildContext context) {
    return CardBaseWidget(
      tema: widget.tema,
      child: Flex(
        mainAxisSize: MainAxisSize.min,
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.tema.borderRadiusM),
                    color: Color(widget.tema.accent),
                  ),
                ),
                SizedBox(width: widget.tema.espacamento * 2),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.tema.borderRadiusXG),
                    color: Color(widget.tema.neutral).withOpacity(.1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: widget.tema.espacamento * 2),
          Flexible(
            flex: Responsive.larguraM(context) ? 3 : 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextoWidget(
                      texto: "Solicitação em andamento com ",
                      tema: widget.tema,
                    ),
                    TextoWidget(
                      texto: "@usuario",
                      tema: widget.tema,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: widget.tema.espacamento / 2),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextoWidget(
                          texto: "Data entrega ",
                          weight: FontWeight.w500,
                          tema: widget.tema,
                        ),
                        TextoWidget(
                          texto: "20/12/2024",
                          tema: widget.tema,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextoWidget(
                          texto: "Data devolução",
                          weight: FontWeight.w500,
                          tema: widget.tema,
                        ),
                        TextoWidget(
                          texto: "20/01/2025",
                          tema: widget.tema,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: widget.tema.espacamento / 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextoWidget(
                      texto: "Endereço",
                      weight: FontWeight.w500,
                      tema: widget.tema,
                    ),
                    TextoWidget(
                      texto: "Rua Dona Salvadora, 251, apto. 56, b. 9",
                      tema: widget.tema,
                    ),
                  ],
                ),
                SizedBox(height: widget.tema.espacamento),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BotaoPequenoWidget(
                      tema: widget.tema,
                      corFonte: kCorFonte,
                      aoClicar: widget.aoVisualizar,
                      label: "Visualizar",
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
