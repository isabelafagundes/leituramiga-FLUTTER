import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card_livros_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioInformacoesAdicionaisWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerInformacoes;
  final TextEditingController controllerDataEntrega;
  final TextEditingController controllerDataDevolucao;
  final TextEditingController controllerHoraDevolucao;
  final TextEditingController controllerHoraEntrega;
  final TextEditingController controllerCodigoRastreio;
  final TipoSolicitacao tipoSolicitacao;
  final TextEditingController controllerFormaEntrega;
  final List<LivroSolicitacao> livrosSolicitacao;
  final Function() aoClicarProximo;
  final Function(FormaEntrega) aoClicarFormaEntrega;
  final Function(LivroSolicitacao) removerLivro;
  final Function([bool devolucao]) abrirDatePicker;
  final Function([bool devolucao]) abrirTimePicker;
  final Function() aoClicarAdicionarLivro;
  final bool semSelecaoLivros;
  final Function() atualizar;

  const FormularioInformacoesAdicionaisWidget({
    super.key,
    required this.tema,
    required this.controllerInformacoes,
    required this.aoClicarProximo,
    required this.controllerDataEntrega,
    required this.controllerDataDevolucao,
    required this.tipoSolicitacao,
    required this.aoClicarAdicionarLivro,
    required this.livrosSolicitacao,
    required this.removerLivro,
    required this.abrirDatePicker,
    required this.abrirTimePicker,
    required this.controllerHoraDevolucao,
    required this.controllerHoraEntrega,
    required this.controllerFormaEntrega,
    required this.aoClicarFormaEntrega,
    this.semSelecaoLivros = false,
    required this.controllerCodigoRastreio, required this.atualizar,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!semSelecaoLivros)
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
                CardLivrosSolicitacaoWidget(
                  tema: tema,
                  removerLivro: removerLivro,
                  livrosSolicitacao: livrosSolicitacao,
                  aoClicarAdicionarLivro: aoClicarAdicionarLivro,
                ),
              ],
            ),
          ),
        if (Responsive.larguraP(context) && !semSelecaoLivros) ...[
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
                child: Flex(
                  direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 70,
                        child: IgnorePointer(
                          ignoring: controllerCodigoRastreio.text.isNotEmpty,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextoWidget(
                                texto: "Forma de entrega *",
                                tema: tema,
                                cor: Color(tema.baseContent),
                              ),
                              SizedBox(height: tema.espacamento),
                              Expanded(
                                child: MenuWidget(
                                  tema: tema,
                                  controller: controllerFormaEntrega,
                                  atualizar: atualizar,
                                  valorSelecionado:
                                      controllerFormaEntrega.text.isNotEmpty ? controllerFormaEntrega.text : null,
                                  escolhas: const ["Correios", "Presencial"],
                                  aoClicar: (valor) => aoClicarFormaEntrega(FormaEntrega.deDescricao(valor)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!Responsive.larguraP(context))
                      Flexible(
                        child: IgnorePointer(
                          child: Opacity(
                            opacity: 0,
                            child: SizedBox(
                              height: 70,
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
                                  Expanded(
                                    child: MenuWidget(
                                      tema: tema,
                                      controller: controllerFormaEntrega,
                                      atualizar: atualizar,
                                      valorSelecionado:
                                          controllerFormaEntrega.text.isNotEmpty ? controllerFormaEntrega.text : null,
                                      escolhas: const ["Correios", "Presencial"],
                                      aoClicar: (valor) => aoClicarFormaEntrega(FormaEntrega.deDescricao(valor)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (semSelecaoLivros && controllerFormaEntrega.text == "Correios") ...[
                SizedBox(
                  width: tema.espacamento * 2,
                  height: tema.espacamento * 2,
                ),
                Flexible(
                  child: InputWidget(
                    tema: tema,
                    controller: controllerCodigoRastreio,
                    label: "Código rastreio",
                    tamanho: tema.tamanhoFonteM,
                    obrigatorio: false,
                    formatters: [LengthLimitingTextInputFormatter(119)],
                    onChanged: (valor) {},
                  ),
                ),
              ],
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerInformacoes,
                  label: "Informações adicionais",
                  tamanho: tema.tamanhoFonteM,
                  obrigatorio: false,
                  formatters: [LengthLimitingTextInputFormatter(256)],
                  expandir: true,
                  alturaCampo: 90,
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
                        onTap: abrirDatePicker,
                        readOnly: true,
                        obrigatorio: false,
                        controller: controllerDataEntrega,
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
                        onTap: () => abrirTimePicker(),
                        readOnly: true,
                        obrigatorio: false,
                        controller: controllerHoraEntrega,
                        label: "Hora entrega",
                        tamanho: tema.tamanhoFonteM,
                        onChanged: (valor) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: tema.espacamento * 2),
              if (tipoSolicitacao == TipoSolicitacao.EMPRESTIMO)
                Flexible(
                  child: Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Responsive.larguraPP(context) ? Axis.vertical : Axis.horizontal,
                    children: [
                      Flexible(
                        child: InputWidget(
                          tema: tema,
                          onTap: () => abrirDatePicker(true),
                          readOnly: true,
                          obrigatorio: false,
                          controller: controllerDataDevolucao,
                          label: "Data devolução",
                          tamanho: tema.tamanhoFonteM,
                          onChanged: (valor) {},
                        ),
                      ),
                      if (tipoSolicitacao == TipoSolicitacao.EMPRESTIMO) ...[
                        SizedBox(
                          width: tema.espacamento * 2,
                          height: tema.espacamento * 2,
                        ),
                        Flexible(
                          child: InputWidget(
                            tema: tema,
                            onTap: () => abrirTimePicker(true),
                            readOnly: true,
                            controller: controllerHoraDevolucao,
                            obrigatorio: false,
                            label: "Hora devolução",
                            tamanho: tema.tamanhoFonteM,
                            onChanged: (valor) {},
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              if (!semSelecaoLivros) ...[
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
              ]
            ],
          ),
        ),
        if (semSelecaoLivros)
          Flexible(
            child: IgnorePointer(
              ignoring: semSelecaoLivros,
              child: Opacity(
                opacity: 0,
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
                    CardLivrosSolicitacaoWidget(
                      tema: tema,
                      removerLivro: removerLivro,
                      livrosSolicitacao: livrosSolicitacao,
                      aoClicarAdicionarLivro: aoClicarAdicionarLivro,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
