import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/imagem.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioLivroWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerNome;
  final TextEditingController controllerAutor;
  final TextEditingController controllerDescricao;
  final TextEditingController controllerEstadoFisico;
  final Function(String) salvarImagem;
  final Function(Categoria) selecionarCategoria;
  final Function() criarLivro;
  final Map<int, Categoria> categoriasPorId;
  final int? numeroCategoria;
  final Widget? widgetInferior;
  final String? imagem;
  final Function(TipoSolicitacao) selecionarTipoSolicitacao;
  final List<TipoSolicitacao> tiposSolicitacao;
  final bool edicao;

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
    required this.criarLivro,
    required this.selecionarTipoSolicitacao,
    required this.tiposSolicitacao,
    this.imagem,
    this.edicao = false, this.widgetInferior,
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
                imagemBase64: imagem,
                salvarImagem: salvarImagem,
              ),
              SizedBox(height: tema.espacamento * 2),
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
                controller: controllerNome,
                label: "Nome do livro",
                formatters: [LengthLimitingTextInputFormatter(120)],
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: controllerAutor,
                label: "Autor",
                formatters: [LengthLimitingTextInputFormatter(40)],
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: controllerDescricao,
                label: "Descrição",
                expandir: true,
                formatters: [LengthLimitingTextInputFormatter(260)],
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
                alturaCampo: 90,
              ),
              SizedBox(height: tema.espacamento),
              InputWidget(
                tema: tema,
                controller: controllerEstadoFisico,
                label: "Estado físico",
                formatters: [LengthLimitingTextInputFormatter(160)],
                tamanho: tema.tamanhoFonteM,
                onChanged: (valor) {},
              ),
              SizedBox(height: tema.espacamento * 3),
              TextoWidget(
                texto: "Categorias *",
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
              SizedBox(height: tema.espacamento * 3),
              TextoWidget(
                texto: "Tipo de solicitação *",
                tema: tema,
                weight: FontWeight.w500,
                cor: Color(tema.baseContent),
              ),
              SizedBox(height: tema.espacamento),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ChipWidget(
                      tema: tema,
                      cor: kCorPessego,
                      texto: "Troca",
                      corTexto: kCorFonte,
                      ativado: tiposSolicitacao.contains(TipoSolicitacao.TROCA),
                      aoClicar: () => selecionarTipoSolicitacao(TipoSolicitacao.TROCA),
                    ),
                    SizedBox(width: tema.espacamento),
                    ChipWidget(
                      tema: tema,
                      cor: kCorVerde,
                      texto: "Empréstimo",
                      ativado: tiposSolicitacao.contains(TipoSolicitacao.EMPRESTIMO),
                      corTexto: kCorFonte,
                      aoClicar: () => selecionarTipoSolicitacao(TipoSolicitacao.EMPRESTIMO),
                    ),
                    SizedBox(width: tema.espacamento),
                    ChipWidget(
                      tema: tema,
                      cor: kCorAzul,
                      texto: "Doação",
                      corTexto: kCorFonte,
                      ativado: tiposSolicitacao.contains(TipoSolicitacao.DOACAO),
                      aoClicar: () => selecionarTipoSolicitacao(TipoSolicitacao.DOACAO),
                    ),
                  ],
                ),
              ),
              SizedBox(height: tema.espacamento * 4),
              BotaoWidget(
                tema: tema,
                texto: edicao ? "Salvar livro" : 'Criar livro',
                icone: Icon(
                  Icons.check,
                  color: Color(tema.base200),
                  size: tema.espacamento + 10,
                ),
                aoClicar: criarLivro,
              ),
              SizedBox(height: tema.espacamento * 2),
              widgetInferior ?? SizedBox(),
              SizedBox(height: tema.espacamento * 4),
            ],
          ),
        ),
      ],
    );
  }
}
