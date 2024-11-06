import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioUsuarioWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerNome;
  final TextEditingController controllerEmail;
  final TextEditingController controllerSenha;
  final TextEditingController controllerUsuario;
  final TextEditingController controllerTelefone;
  final TextEditingController controllerConfirmacaoSenha;
  final TextEditingController controllerInstituicao;
  final List<String> instituicoes;
  final Function(String) aoSelecionarInstituicao;
  final Function() aoCadastrar;
  final Function() atualizar;
  final Widget? botaoInferior;

  FormularioUsuarioWidget({
    super.key,
    required this.tema,
    required this.controllerNome,
    required this.controllerEmail,
    required this.controllerSenha,
    required this.controllerUsuario,
    required this.controllerConfirmacaoSenha,
    required this.aoCadastrar,
    this.botaoInferior,
    required this.controllerTelefone,
    required this.controllerInstituicao,
    required this.instituicoes,
    required this.aoSelecionarInstituicao,
    required this.atualizar,
  });

  final MaskTextInputFormatter _mascaraTelefone = MaskTextInputFormatter(mask: "(##) #########");

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextoWidget(
          texto: "Insira informações básicas da sua conta!",
          tema: tema,
          align: TextAlign.center,
          cor: Color(tema.baseContent),
        ),
        Flexible(
          child: InputWidget(
            tema: tema,
            controller: controllerNome,
            label: "Nome",
            formatters: [LengthLimitingTextInputFormatter(40)],
            tamanho: tema.tamanhoFonteM,
            onChanged: (valor) {},
          ),
        ),
        SizedBox(
          height: tema.espacamento * 2,
          width: tema.espacamento * 2,
        ),
        Flexible(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerUsuario,
                  label: "Usuário",
                  formatters: [LengthLimitingTextInputFormatter(30)],
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
              ),
              Flexible(
                child: InputWidget(
                  tema: tema,
                  obrigatorio: false,
                  controller: controllerTelefone,
                  label: "Número de telefone",
                  formatters: [_mascaraTelefone],
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: tema.espacamento * 2),
        Flexible(
          child: InputWidget(
            tema: tema,
            controller: controllerEmail,
            label: "Email",
            formatters: [LengthLimitingTextInputFormatter(260)],
            tamanho: tema.tamanhoFonteM,
            onChanged: (valor) {},
          ),
        ),
        SizedBox(height: tema.espacamento * 2),
        Flexible(
          child: SizedBox(
            height: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextoWidget(
                  texto: "Instiuição de ensino",
                  tema: tema,
                  cor: Color(tema.baseContent),
                ),
                SizedBox(height: tema.espacamento / 2),
                Expanded(
                  child: MenuWidget(
                    tema: tema,
                    controller: controllerInstituicao,
                    atualizar: atualizar,
                    valorSelecionado: controllerInstituicao.text.isEmpty ? null : controllerInstituicao.text,
                    escolhas: instituicoes,
                    aoClicar: aoSelecionarInstituicao,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: tema.espacamento * 4),
        if (botaoInferior is! SizedBox)
          Flexible(
            child: botaoInferior ??
                BotaoWidget(
                  tema: tema,
                  texto: 'Próximo',
                  nomeIcone: "seta/arrow-long-right",
                  aoClicar: aoCadastrar,
                ),
          ),
        SizedBox(height: tema.espacamento * 2),
      ],
    );
  }

  List<Widget> get _obterChildren {
    return [
      Flexible(
        child: InputWidget(
          tema: tema,
          controller: controllerSenha,
          label: "Senha",
          senha: true,
          tamanho: tema.tamanhoFonteM,
          onChanged: (valor) {},
        ),
      ),
      SizedBox(
        height: tema.espacamento * 2,
        width: tema.espacamento * 2,
      ),
      Flexible(
        child: InputWidget(
          tema: tema,
          controller: controllerConfirmacaoSenha,
          label: "Confirmar senha",
          senha: true,
          tamanho: tema.tamanhoFonteM,
          onChanged: (valor) {},
        ),
      ),
    ];
  }
}
