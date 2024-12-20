import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioEnderecoWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerRua;
  final TextEditingController controllerBairro;
  final TextEditingController controllerCep;
  final TextEditingController controllerNumero;
  final TextEditingController controllerComplemento;
  final TextEditingController controllerCidade;
  final TextEditingController controllerEstado;
  final Function(String) aoSelecionarCidade;
  final Function(String) aoSelecionarEstado;
  final List<String> cidades;
  final Function() atualizar;
  final Function()? aoSalvar;
  final List<String> estados;
  final Widget? botaoInferior;
  final String? textoAjuda;

  FormularioEnderecoWidget({
    super.key,
    required this.tema,
    required this.controllerRua,
    required this.controllerBairro,
    required this.controllerCep,
    required this.controllerNumero,
    required this.controllerComplemento,
    required this.controllerCidade,
    required this.controllerEstado,
    required this.aoSelecionarCidade,
    required this.aoSelecionarEstado,
    this.textoAjuda = "Preencha com o endereço que será feita a entrega!",
    required this.cidades,
    required this.estados,
    this.aoSalvar,
    this.botaoInferior,
    required this.atualizar,
  });

  MaskTextInputFormatter _mascaraCEP = MaskTextInputFormatter(
    mask: "#####-###",
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextoWidget(
          texto: textoAjuda ?? "Preencha com o endereço que será feita a entrega!",
          tema: tema,
          align: TextAlign.center,
          cor: Color(tema.baseContent),
        ),
        SizedBox(height: tema.espacamento * 2),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerCep,
                  label: "CEP",
                  alturaCampo: 50,
                  formatters: [_mascaraCEP],
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: SizedBox(
                  height: 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextoWidget(
                        texto: "Estado *",
                        tema: tema,
                        cor: Color(tema.baseContent),
                      ),
                      SizedBox(height: tema.espacamento / 2),
                      Expanded(
                        child: MenuWidget(
                          tema: tema,
                          controller: controllerEstado,
                          atualizar: atualizar,
                          valorSelecionado: controllerEstado.text.isEmpty ? null : controllerEstado.text,
                          escolhas: estados,
                          aoClicar: aoSelecionarEstado,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: tema.espacamento * 2,
          height: tema.espacamento * 2,
        ),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                child: SizedBox(
                  height: 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextoWidget(
                        texto: "Cidade *",
                        tema: tema,
                        cor: Color(tema.baseContent),
                      ),
                      SizedBox(height: tema.espacamento / 2),
                      Expanded(
                        child: MenuWidget(
                          tema: tema,
                          controller: controllerCidade,
                          atualizar: atualizar,
                          valorSelecionado: controllerCidade.text.isEmpty ? null : controllerCidade.text,
                          escolhas: cidades,
                          aoClicar: aoSelecionarCidade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerBairro,
                  label: "Bairro",
                  alturaCampo: 50,
                  formatters: [LengthLimitingTextInputFormatter(119)],
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: tema.espacamento * 2,
          height: tema.espacamento * 2,
        ),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                flex: Responsive.larguraP(context) ? 1 : 2,
                child: InputWidget(
                  tema: tema,
                  controller: controllerRua,
                  label: "Rua",
                  alturaCampo: 50,
                  formatters: [LengthLimitingTextInputFormatter(119)],
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerNumero,
                  label: "Número",
                  alturaCampo: 50,
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: tema.espacamento * 2,
          height: tema.espacamento * 2,
        ),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                child: InputWidget(
                  tema: tema,
                  obrigatorio: false,
                  controller: controllerComplemento,
                  label: "Complemento",
                  alturaCampo: 50,
                  formatters: [LengthLimitingTextInputFormatter(119)],
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              if (!Responsive.larguraP(context))
                SizedBox(
                  width: tema.espacamento * 2,
                  height: tema.espacamento * 2,
                ),
              if (!Responsive.larguraP(context))
                Flexible(
                  child: Opacity(
                    opacity: 0,
                    child: InputWidget(
                      tema: tema,
                      controller: controllerNumero,
                      label: "Número",
                      alturaCampo: 50,
                      formatters: [LengthLimitingTextInputFormatter(10)],
                      tamanho: tema.tamanhoFonteM,
                      onChanged: (valor) {},
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (botaoInferior != null) ...[
          SizedBox(height: tema.espacamento * 4),
          Container(child: botaoInferior!),
        ],
      ],
    );
  }
}
