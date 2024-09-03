import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/imagem.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';

class FormularioLivroWidget extends StatelessWidget {
  final Tema tema;

  const FormularioLivroWidget({super.key, required this.tema});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            children: [
              ImagemWidget(
                tema: tema,
                salvarImagem: (imagem64) => print(imagem64),
              ),
              SizedBox(height: tema.espacamento),
              SizedBox(height: tema.espacamento / 2),
              if (Responsive.larguraM(context))
                SizedBox(
                  width: 200,
                  child: Divider(
                    color: Color(tema.accent),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: tema.espacamento * 5),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputWidget(
                tema: tema,
                controller: TextEditingController(),
                label: "Nome do livro",
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: TextEditingController(),
                label: "Autor",
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: TextEditingController(),
                label: "Descrição",
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: TextEditingController(),
                label: "Estado físico",
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento * 4),
              BotaoWidget(
                tema: tema,
                texto: 'Criar livro',
                icone: Icon(
                  Icons.check,
                  color: Color(tema.base200),
                  size: tema.espacamento + 10,
                ),
                aoClicar: () => Rota.navegar(context, Rota.PERFIL),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
