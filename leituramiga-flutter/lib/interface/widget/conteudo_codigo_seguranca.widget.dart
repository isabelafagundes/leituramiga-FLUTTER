import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoCodigoSegurancaWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerEmail;
  final TextEditingController controllerCodigoSeguranca;
  final Function() atualizarPagina;
  final Function() validarCodigoSeguranca;
  final Function() enviarNovoCodigo;

  const ConteudoCodigoSegurancaWidget({
    super.key,
    required this.tema,
    required this.controllerEmail,
    required this.controllerCodigoSeguranca,
    required this.atualizarPagina,
    required this.validarCodigoSeguranca,
    required this.enviarNovoCodigo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SvgWidget(
          nomeSvg: "codigo_verificacao",
          altura: 220,
        ),
        SizedBox(height: tema.espacamento * 4),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            TextoWidget(
              texto: "Informe o código de segurança enviado no email ",
              tema: tema,
              align: TextAlign.center,
              cor: Color(tema.baseContent),
            ),
            TextoWidget(
              texto: " ${controllerEmail.text}",
              tema: tema,
              align: TextAlign.center,
              weight: FontWeight.w500,
              cor: Color(tema.baseContent),
            ),
          ],
        ),
        SizedBox(height: tema.espacamento),
        SizedBox(
          width: 300,
          child: InputWidget(
            tema: tema,
            tipoInput: const TextInputType.numberWithOptions(decimal: false),
            controller: controllerCodigoSeguranca,
            alturaCampo: 30,
            formatters: [LengthLimitingTextInputFormatter(5)],
            onChanged: (texto) {},
          ),
        ),
        SizedBox(height: tema.espacamento),
        GestureDetector(
          onTap: enviarNovoCodigo,
          child: TextoWidget(
            texto: "Enviar novo código",
            tema: tema,
            weight: FontWeight.w500,
            decoration: TextDecoration.underline,
            align: TextAlign.center,
            tamanho: tema.tamanhoFonteM,
            cor: Color(tema.baseContent),
          ),
        ),
        SizedBox(height: tema.espacamento * 4),
        BotaoWidget(
          tema: tema,
          texto: 'Próximo',
          nomeIcone: "seta/arrow-long-right",
          aoClicar: validarCodigoSeguranca,
        ),
        SizedBox(height: tema.espacamento * 2),
        BotaoWidget(
          tema: tema,
          texto: 'Voltar',
          corFundo: Color(tema.base100),
          corTexto: Color(tema.baseContent),
          nomeIcone: "seta/arrow-long-left",
          aoClicar: () => atualizarPagina(),
        ),
      ],
    );
  }
}
