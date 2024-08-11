import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioUsuarioWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerNome;
  final TextEditingController controllerEmail;
  final TextEditingController controllerSenha;
  final TextEditingController controllerUsuario;
  final TextEditingController controllerConfirmacaoSenha;
  final Function() aoCadastrar;

  const FormularioUsuarioWidget({
    super.key,
    required this.tema,
    required this.controllerNome,
    required this.controllerEmail,
    required this.controllerSenha,
    required this.controllerUsuario,
    required this.controllerConfirmacaoSenha,
    required this.aoCadastrar,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
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
            controller: controllerUsuario,
            label: "Usuário",
            tamanho: tema.tamanhoFonteM,
            onChanged: (valor) {},
          ),
        ),
        SizedBox(height: tema.espacamento * 2),
        Flexible(
          child: InputWidget(
            tema: tema,
            controller: controllerEmail,
            label: "Email",
            tamanho: tema.tamanhoFonteM,
            onChanged: (valor) {},
          ),
        ),
        SizedBox(height: tema.espacamento * 2),
        Flexible(
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: [
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
            ],
          ),
        ),
        SizedBox(height: tema.espacamento * 4),
        Flexible(
          child: BotaoWidget(
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
}
