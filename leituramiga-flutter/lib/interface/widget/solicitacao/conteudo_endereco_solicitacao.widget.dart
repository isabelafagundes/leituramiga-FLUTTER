import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/switcher/switcher.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoEnderecoSolicitacaoWidget extends StatelessWidget {
  final Tema tema;
  final Function() aoClicarProximo;
  final Function() utilizarEnderecoPerfil;
  final Function(String) aoClicarFrete;
  final TextEditingController controllerRua;
  final TextEditingController controllerBairro;
  final TextEditingController controllerCep;
  final TextEditingController controllerNumero;
  final TextEditingController controllerComplemento;
  final TextEditingController controllerCidade;
  final TextEditingController controllerEstado;
  final TextEditingController controllerFrete;
  final Function(String) aoSelecionarCidade;
  final Function(String) aoSelecionarEstado;
  final Function(String) aoSelecionarFormaEntrega;
  final Function(String) aoSelecionarFrete;
  final List<String> cidades;
  final List<String> estados;
  final bool utilizaEnderecoPerfil;
  final bool semBotaoProximo;
  final String textoAjuda;
  final bool permitirUsarEnderecoPerfil;

  const ConteudoEnderecoSolicitacaoWidget({
    super.key,
    required this.tema,
    required this.aoClicarProximo,
    required this.utilizarEnderecoPerfil,
    required this.aoClicarFrete,
    required this.controllerRua,
    required this.controllerBairro,
    required this.controllerCep,
    required this.controllerNumero,
    required this.controllerComplemento,
    required this.controllerCidade,
    required this.controllerEstado,
    required this.aoSelecionarCidade,
    required this.aoSelecionarEstado,
    required this.cidades,
    required this.estados,
    required this.controllerFrete,
    required this.aoSelecionarFormaEntrega,
    required this.aoSelecionarFrete,
    required this.utilizaEnderecoPerfil,
    this.permitirUsarEnderecoPerfil = true,
    this.textoAjuda = "Preencha com o endereço que será feita a entrega!",
    this.semBotaoProximo = false,
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
              if (permitirUsarEnderecoPerfil) ...[
                Flexible(
                  child: Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Responsive.larguraPP(context) ? Axis.vertical : Axis.horizontal,
                    children: [
                      Flexible(
                        flex: 2,
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
                              valor: utilizaEnderecoPerfil,
                              valorInicial: utilizaEnderecoPerfil,
                              aoClicar: utilizarEnderecoPerfil,
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
              ],
              Flexible(
                child: IgnorePointer(
                  ignoring: utilizaEnderecoPerfil,
                  child: FormularioEnderecoWidget(
                    tema: tema,
                    textoAjuda: textoAjuda,
                    aoSelecionarCidade: aoSelecionarCidade,
                    aoSelecionarEstado: aoSelecionarEstado,
                    cidades: cidades,
                    estados: estados,
                    controllerRua: controllerRua,
                    controllerBairro: controllerBairro,
                    controllerCep: controllerCep,
                    controllerNumero: controllerNumero,
                    controllerComplemento: controllerComplemento,
                    controllerCidade: controllerCidade,
                    controllerEstado: controllerEstado,
                  ),
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
              if (!semBotaoProximo) ...[
                SizedBox(height: tema.espacamento * 4),
                BotaoWidget(
                  tema: tema,
                  texto: 'Próximo',
                  nomeIcone: "seta/arrow-long-right",
                  aoClicar: aoClicarProximo,
                ),
                SizedBox(height: tema.espacamento * 4),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
