import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/imagem.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioLivroWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerNome;
  final TextEditingController controllerAutor;
  final TextEditingController controllerDescricao;
  final TextEditingController controllerEstadoFisico;
  final Function(String) salvarImagem;
  final Function(Categoria) selecionarCategoria;
  final Map<int, Categoria> categoriasPorId;
  final int? numeroCategoria;

  const FormularioLivroWidget({
    super.key,
    required this.tema,
    required this.controllerNome,
    required this.controllerAutor,
    required this.controllerDescricao,
    required this.controllerEstadoFisico,
    required this.salvarImagem,
    required this.selecionarCategoria,
    required this.categoriasPorId,
    required this.numeroCategoria,
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
              ImagemWidget(
                tema: tema,
                salvarImagem: (imagem64) => print(imagem64),
              ),
              SizedBox(height: tema.espacamento*2),
              DicaWidget(
                tema: tema,
                texto: "Preencha com as informações do seu livro",
              ),
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
                controller: controllerAutor,
                label: "Autor",
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: controllerDescricao,
                label: "Descrição",
                expandir: true,
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
                alturaCampo: 90,
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: controllerEstadoFisico,
                label: "Estado físico",
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento * 3),
              TextoWidget(
                texto: "Categorias",
                tema: tema,
                weight: FontWeight.w500,
                cor: Color(tema.baseContent),
              ),
              SizedBox(height: tema.espacamento),
              CarrosselCategoriaWidget(
                tema: tema,
                selecionarCategoria: selecionarCategoria,
                categoriasPorId: categoriasPorId,
                categoriaSelecionada: numeroCategoria,
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
