import 'package:flutter/material.dart';
import 'package:leituramiga/domain/notificacao.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class CardNotificacaoWidget extends StatefulWidget {
  final Tema tema;
  final Function(int) aoVisualizar;
  final Function(int) aoRecusar;
  final Notificacao notificacao;

  const CardNotificacaoWidget({
    required this.tema,
    super.key,
    required this.aoVisualizar,
    required this.notificacao,
    required this.aoRecusar,
  });

  @override
  State<CardNotificacaoWidget> createState() => _CardNotificacaoWidgetState();
}

class _CardNotificacaoWidgetState extends State<CardNotificacaoWidget> {
  @override
  Widget build(BuildContext context) {
    return CardBaseWidget(
      tema: widget.tema,
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
          SizedBox(width: widget.tema.espacamento * 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: Responsive.largura(context) - 200),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    TextoWidget(
                      texto: "Você recebeu uma solicitação de ",
                      tema: widget.tema,
                    ),
                    TextoWidget(
                      texto: widget.notificacao.nomeUsuario,
                      tema: widget.tema,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.tema.espacamento),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BotaoPequenoWidget(
                    tema: widget.tema,
                    corFonte: kCorFonte,
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.tema.espacamento * 1.5,
                      vertical: widget.tema.espacamento / 1.5,
                    ),
                    icone: Icon(Icons.remove_red_eye, color: kCorFonte),
                    aoClicar: () => widget.aoVisualizar(widget.notificacao.numeroSolicitacao),
                    label: "Visualizar",
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
