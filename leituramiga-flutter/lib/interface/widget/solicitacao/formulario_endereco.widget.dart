import 'package:flutter/material.dart';
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

  const FormularioEnderecoWidget({
    super.key,
    required this.tema,
    required this.controllerRua,
    required this.controllerBairro,
    required this.controllerCep,
    required this.controllerNumero,
    required this.controllerComplemento,
    required this.controllerCidade,
    required this.controllerEstado,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TextoWidget(
            texto: "Preencha com o endereço que será feita a entrega!",
            tema: tema,
            align: TextAlign.center,
            cor: Color(tema.baseContent),
          ),
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
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextoWidget(
                      texto: "Estado",
                      tema: tema,
                      cor: Color(tema.baseContent),
                    ),
                    SizedBox(height: tema.espacamento),
                    MenuWidget(
                      tema: tema,
                      escolhas: ["São Paulo"],
                      aoClicar: (valor) {},
                    ),
                  ],
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
            direction: Axis.horizontal,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextoWidget(
                      texto: "Cidade",
                      tema: tema,
                      cor: Color(tema.baseContent),
                    ),
                    SizedBox(height: tema.espacamento),
                    MenuWidget(
                      tema: tema,
                      escolhas: ["Cajamar", "Santana de Parnaíba", "São Paulo"],
                      aoClicar: (valor) {},
                    ),
                  ],
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
                flex: 2,
                child: InputWidget(
                  tema: tema,
                  controller: controllerRua,
                  label: "Rua",
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
                  controller: controllerComplemento,
                  label: "Complemento",
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: Opacity(
                  opacity: 0,
                  child: InputWidget(
                    tema: tema,
                    controller: controllerNumero,
                    label: "Número",
                    tamanho: tema.tamanhoFonteM,
                    onChanged: (valor) {},
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
