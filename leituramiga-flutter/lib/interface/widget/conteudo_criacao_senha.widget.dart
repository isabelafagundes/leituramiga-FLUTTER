import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';

import 'texto/texto.widget.dart';

class ConteudoCriacaoSenhaWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerSenha;
  final TextEditingController controllerConfirmacaoSenha;
  final String mensagemErro;
  final Function() atualizar;
  final Function() navegarParaProximo;
  final Function() navegarParaAnterior;
  final String? titulo;

  const ConteudoCriacaoSenhaWidget({
    super.key,
    required this.tema,
    required this.controllerSenha,
    required this.controllerConfirmacaoSenha,
    required this.mensagemErro,
    required this.navegarParaProximo,
    required this.atualizar,
    required this.navegarParaAnterior,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgWidget(nomeSvg: 'security', altura: 200),
        SizedBox(height: tema.espacamento * 2),
        TextoWidget(
          texto: titulo ?? "Recuperação de senha",
          tema: tema,
          tamanho: tema.tamanhoFonteG,
          align: TextAlign.center,
          weight: FontWeight.w500,
          cor: Color(tema.baseContent),
        ),
        SizedBox(height: tema.espacamento * 2),
        SizedBox(
          width: 300,
          child: InputWidget(
            tema: tema,
            label: "Nova senha",
            tipoInput: const TextInputType.numberWithOptions(decimal: false),
            controller: controllerSenha,
            alturaCampo: 40,
            senha: true,
            formatters: [LengthLimitingTextInputFormatter(30)],
            onChanged: (texto) => atualizar(),
          ),
        ),
        SizedBox(height: tema.espacamento * 2),
        SizedBox(
          width: 300,
          child: InputWidget(
            tema: tema,
            label: "Confirmar nova senha",
            tipoInput: const TextInputType.numberWithOptions(decimal: false),
            controller: controllerConfirmacaoSenha,
            alturaCampo: 40,
            senha: true,
            formatters: [LengthLimitingTextInputFormatter(30)],
            onChanged: (texto) => atualizar(),
          ),
        ),
        SizedBox(height: tema.espacamento * 2),
        if (controllerSenha.text.isNotEmpty || controllerConfirmacaoSenha.text.isNotEmpty)
          TextoWidget(
            texto: mensagemErro,
            weight: FontWeight.w500,
            cor: Color(tema.error),
            tema: tema,
          ),
        SizedBox(height: tema.espacamento * 2),
        BotaoWidget(
          tema: tema,
          texto: 'Próximo',
          nomeIcone: "seta/arrow-long-right",
          aoClicar: navegarParaProximo,
        ),
        SizedBox(height: tema.espacamento * 2),
        BotaoWidget(
          tema: tema,
          texto: 'Voltar',
          corFundo: Color(tema.base100),
          corTexto: Color(tema.baseContent),
          nomeIcone: "seta/arrow-long-left",
          aoClicar: () => navegarParaAnterior(),
        ),
      ],
    );
  }
}
