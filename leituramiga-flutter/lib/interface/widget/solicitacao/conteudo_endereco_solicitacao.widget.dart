import 'package:flutter/material.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/switcher/switcher.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoEnderecoSolicitacaoWidget extends StatelessWidget {
  final Tema tema;
  final Function() aoClicarProximo;
  final Function() utilizarEnderecoPerfil;
  final Function(FormaEntrega) aoClicarFormaEntrega;
  final Function(bool) aoClicarFrete;
  final TextEditingController controllerRua;
  final TextEditingController controllerBairro;
  final TextEditingController controllerCep;
  final TextEditingController controllerNumero;
  final TextEditingController controllerComplemento;
  final TextEditingController controllerCidade;
  final TextEditingController controllerEstado;

  const ConteudoEnderecoSolicitacaoWidget({
    super.key,
    required this.tema,
    required this.aoClicarProximo,
    required this.utilizarEnderecoPerfil,
    required this.aoClicarFormaEntrega,
    required this.aoClicarFrete,
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
      direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Row(
                  children: [
                    TextoWidget(
                      texto: "Usar endereço do seu perfil?",
                      tema: tema,
                      cor: Color(tema.baseContent),
                    ),
                    const Spacer(),
                    SwitcherWidget(
                      tema: tema,
                      aoClicar: utilizarEnderecoPerfil,
                    ),
                  ],
                ),
              ),
              SizedBox(height: tema.espacamento * 2),
              Flexible(
                child: Flex(
                  mainAxisSize: MainAxisSize.min,
                  direction: Responsive.larguraPP(context) ? Axis.vertical : Axis.horizontal,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextoWidget(
                            texto: "Forma de entrega",
                            tema: tema,
                            cor: Color(tema.baseContent),
                          ),
                          SizedBox(height: tema.espacamento),
                          MenuWidget(
                            tema: tema,
                            escolhas: const ["Correios", "Presencial"],
                            aoClicar: (valor) => aoClicarFormaEntrega(
                              FormaEntrega.values.firstWhere((e) => e.toString() == valor),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextoWidget(
                            texto: "Você pagará o frete?",
                            tema: tema,
                            cor: Color(tema.baseContent),
                          ),
                          SizedBox(height: tema.espacamento),
                          MenuWidget(
                            tema: tema,
                            escolhas: ["Sim", "Não"],
                            aoClicar: (valor) => aoClicarFrete(valor == "Sim"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: tema.espacamento * 2),
              Divider(
                color: Color(tema.accent),
              ),
              SizedBox(height: tema.espacamento * 2),
              Flexible(
                child: FormularioEnderecoWidget(
                  tema: tema,
                  controllerRua: controllerRua,
                  controllerBairro: controllerBairro,
                  controllerCep: controllerCep,
                  controllerNumero: controllerNumero,
                  controllerComplemento: controllerComplemento,
                  controllerCidade: controllerCidade,
                  controllerEstado: controllerEstado,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!Responsive.larguraP(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgWidget(
                      altura: Responsive.largura(context) * .3,
                      nomeSvg: "endereco",
                    ),
                  ],
                ),
              SizedBox(height: tema.espacamento * 4),
              BotaoWidget(
                tema: tema,
                texto: 'Próximo',
                nomeIcone: "seta/arrow-long-right",
                aoClicar: aoClicarProximo,
              ),
              SizedBox(height: tema.espacamento * 4),
            ],
          ),
        ),
      ],
    );
  }
}
