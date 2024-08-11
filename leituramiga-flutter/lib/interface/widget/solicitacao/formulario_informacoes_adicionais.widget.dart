import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/home.page.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioInformacoesAdicionaisWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerInformacoes;
  final Function() aoClicarProximo;

  const FormularioInformacoesAdicionaisWidget({
    super.key,
    required this.tema,
    required this.controllerInformacoes,
    required this.aoClicarProximo,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            children: [
              TextoWidget(
                texto: "Clique no '+' para selecionar os livros que deseja solicitar desse usuário:",
                tema: tema,
                align: TextAlign.center,
                cor: Color(tema.baseContent),
                tamanho: tema.tamanhoFonteM,
              ),
              SizedBox(height: tema.espacamento),
              CardBaseWidget(
                tema: tema,
                padding: EdgeInsets.symmetric(
                  vertical: tema.espacamento,
                  horizontal: tema.espacamento,
                ),
                child: Container(
                  constraints: BoxConstraints(maxHeight: Responsive.larguraP(context) ? 250 : 400),
                  child: Column(
                    children: [
                      SizedBox(height: tema.espacamento/2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextoWidget(
                            texto: "Livros da solictação",
                            tema: tema,
                            cor: Color(tema.baseContent),
                            tamanho: tema.tamanhoFonteM,
                            weight: FontWeight.w500,
                          ),
                          const Spacer(),
                          BotaoRedondoWidget(
                            tema: tema,
                            nomeSvg: '',
                            icone: Icon(
                              Icons.add,
                              color: Color(tema.accent),
                            ),
                            aoClicar: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: tema.espacamento),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CardBaseWidget(
                                  tema: tema,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextoWidget(
                                          texto: "Nome livro",
                                          tamanho: tema.tamanhoFonteM,
                                          weight: FontWeight.w500,
                                          tema: tema,
                                        ),
                                        TextoWidget(
                                          texto: "Nome e sobrenome do autor",
                                          tema: tema,
                                          tamanho: tema.tamanhoFonteP,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: tema.espacamento),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (Responsive.larguraP(context)) ...[
          SizedBox(height: tema.espacamento * 2),
          Divider(
            color: Color(tema.accent),
          ),
          SizedBox(height: tema.espacamento * 2),
        ],
        if (!Responsive.larguraP(context)) SizedBox(width: tema.espacamento * 4),
        Flexible(
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerInformacoes,
                  label: "Informações adicionais",
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(height: tema.espacamento * 2),
              Flexible(
                child: Flex(
                  mainAxisSize: MainAxisSize.min,
                  direction: Responsive.larguraPP(context) ? Axis.vertical : Axis.horizontal,
                  children: [
                    Flexible(
                      child: InputWidget(
                        tema: tema,
                        controller: controllerInformacoes,
                        label: "Data entrega",
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
                        controller: controllerInformacoes,
                        label: "Data devolução",
                        tamanho: tema.tamanhoFonteM,
                        onChanged: (valor) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: tema.espacamento * 3),
              Flexible(
                child: BotaoWidget(
                  tema: tema,
                  texto: 'Próximo',
                  nomeIcone: "seta/arrow-long-right",
                  aoClicar: aoClicarProximo,
                ),
              ),
              SizedBox(height: tema.espacamento * 4),
            ],
          ),
        ),
      ],
    );
  }
}
