import 'package:flutter/material.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/state/filtros.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/layout_flexivel.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class LayoutFiltroWidget extends StatefulWidget {
  final Tema tema;
  final bool usuario;
  final Function() aplicarFiltros;
  final Function() limparFiltros;
  final Map<int, Categoria> categoriasPorId;
  final Map<int, Municipio> municipiosPorId;
  final Map<int, InstituicaoDeEnsino> instituicoesPorId;
  final Function(Categoria) selecionarCategoria;
  final Function(InstituicaoDeEnsino) selecionarInstituicao;
  final Function(TipoSolicitacao) selecionarTipoSolicitacao;
  final Function(Municipio) selecionarMunicipio;
  final Function(UF) selecionarEstado;
  final int? categoriaSelecionada;
  final bool carrergando;

  const LayoutFiltroWidget({
    super.key,
    required this.tema,
    required this.usuario,
    required this.aplicarFiltros,
    required this.categoriasPorId,
    required this.selecionarCategoria,
    required this.selecionarInstituicao,
    required this.selecionarTipoSolicitacao,
    required this.selecionarMunicipio,
    required this.municipiosPorId,
    required this.instituicoesPorId,
    this.categoriaSelecionada,
    required this.carrergando,
    required this.selecionarEstado,
    required this.limparFiltros,
  });

  @override
  State<LayoutFiltroWidget> createState() => _LayoutFiltroWidgetState();
}

class _LayoutFiltroWidgetState extends State<LayoutFiltroWidget> {
  FiltroState get _filtroState => FiltroState.instancia;

  @override
  Widget build(BuildContext context) {
    return LayoutFlexivelWidget(
      tema: widget.tema,
      alturaOverlay: 700,
      overlayChild: obterConteudo(context),
      drawerChild: obterConteudo(context),
    );
  }

  Widget obterConteudo(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(vertical: widget.tema.espacamento * 2),
        width: 550,
        height: Responsive.largura(context) < 600 ? 700 : Responsive.altura(context),
        child: Column(
          children: widget.carrergando
              ? [
                  Center(
                    child: CircularProgressIndicator(
                      color: Color(widget.tema.baseContent),
                    ),
                  )
                ]
              : [
                  Row(
                    children: [
                      TextoWidget(
                        texto: "Filtros",
                        tema: widget.tema,
                        tamanho: widget.tema.tamanhoFonteG,
                        weight: FontWeight.w400,
                        cor: Color(widget.tema.baseContent),
                      ),
                      SizedBox(width: widget.tema.espacamento),
                      SvgWidget(
                        nomeSvg: 'filtro',
                        cor: Color(widget.tema.baseContent),
                      )
                    ],
                  ),
                  if (!widget.usuario) ...[
                    TextoWidget(
                      texto: "Categorias",
                      tema: widget.tema,
                      cor: Color(widget.tema.baseContent),
                    ),
                    SizedBox(height: widget.tema.espacamento),
                    CarrosselCategoriaWidget(
                      tema: widget.tema,
                      selecionarCategoria: (categoria) => setState(() => widget.selecionarCategoria(categoria)),
                      categoriasPorId: widget.categoriasPorId,
                      categoriaSelecionada: _filtroState.numeroCategoria,
                    ),
                    SizedBox(height: widget.tema.espacamento * 2),
                    TextoWidget(
                      texto: "Tipo de solicitação",
                      tema: widget.tema,
                      cor: Color(widget.tema.baseContent),
                    ),
                    SizedBox(height: widget.tema.espacamento),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ChipWidget(
                          tema: widget.tema,
                          cor: kCorPessego,
                          texto: "Troca",
                          ativado: _filtroState.tipo == TipoSolicitacao.TROCA,
                          aoClicar: () => setState(() => widget.selecionarTipoSolicitacao(TipoSolicitacao.TROCA)),
                          corTexto: const Color(0xff464A52),
                        ),
                        SizedBox(width: widget.tema.espacamento * 2),
                        ChipWidget(
                          tema: widget.tema,
                          cor: kCorVerde,
                          aoClicar: () => setState(() => widget.selecionarTipoSolicitacao(TipoSolicitacao.EMPRESTIMO)),
                          texto: "Empréstimo",
                          ativado: _filtroState.tipo == TipoSolicitacao.EMPRESTIMO,
                          corTexto: const Color(0xff464A52),
                        ),
                        SizedBox(width: widget.tema.espacamento * 2),
                        ChipWidget(
                          aoClicar: () => setState(() => widget.selecionarTipoSolicitacao(TipoSolicitacao.DOACAO)),
                          tema: widget.tema,
                          cor: kCorAzul,
                          ativado: _filtroState.tipo == TipoSolicitacao.DOACAO,
                          texto: "Doação",
                          corTexto: const Color(0xff464A52),
                        ),
                      ],
                    ),
                    SizedBox(height: widget.tema.espacamento * 2),
                  ],
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextoWidget(
                        texto: "Estado",
                        tema: widget.tema,
                        cor: Color(widget.tema.baseContent),
                      ),
                      SizedBox(height: widget.tema.espacamento),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: MenuWidget(
                          tema: widget.tema,
                          valorSelecionado: FiltroState.instancia.estado?.descricao,
                          escolhas: UF.values.map((e) => e.descricao.toString()).toList(),
                          aoClicar: (estado) async {
                            await widget.selecionarEstado(UF.deDescricao(estado));
                            print('Estado selecionado: ${_filtroState.municipios.length}');
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: widget.tema.espacamento * 2),
                  TextoWidget(
                    texto: "Cidade",
                    tema: widget.tema,
                    cor: Color(widget.tema.baseContent),
                  ),
                  SizedBox(height: widget.tema.espacamento),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: MenuWidget(
                      tema: widget.tema,
                      valorSelecionado: _filtroState.municipios
                          .where((element) => element.numero == FiltroState.instancia.numeroMunicipio)
                          .firstOrNull
                          ?.nome,
                      escolhas: _filtroState.municipios.map((e) => e.nome).toList(),
                      aoClicar: (nomeCidade) => setState(() {
                        widget.selecionarMunicipio(
                          _filtroState.municipios.firstWhere((element) => element.nome == nomeCidade),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: widget.tema.espacamento * 2),
                  TextoWidget(
                    texto: "Intituições de ensino",
                    tema: widget.tema,
                    cor: Color(widget.tema.baseContent),
                  ),
                  SizedBox(height: widget.tema.espacamento),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: MenuWidget(
                      tema: widget.tema,
                      escolhas: widget.instituicoesPorId.values.map((e) => e.nome).toList(),
                      aoClicar: (nomeInstituicao) => setState(() {
                        widget.selecionarInstituicao(
                          widget.instituicoesPorId.values.firstWhere((element) => element.nome == nomeInstituicao),
                        );
                      }),
                    ),
                  ),
                  const Spacer(),
                  if (_filtroState.temFiltros)
                    BotaoWidget(
                      tema: widget.tema,
                      corFundo: Color(widget.tema.base200),
                      corTexto: Color(widget.tema.baseContent),
                      texto: 'Limpar filtros',
                      icone: SvgWidget(
                        nomeSvg: 'limpar_icon',
                        cor: Color(widget.tema.baseContent),
                      ),
                      aoClicar: () {
                        widget.limparFiltros();

                        setState(() {});
                      },
                    ),
                  SizedBox(height: widget.tema.espacamento * 2),
                  BotaoWidget(
                    tema: widget.tema,
                    texto: 'Aplicar filtros',
                    icone: Icon(
                      Icons.done,
                      color: Color(widget.tema.base200),
                    ),
                    aoClicar: widget.aplicarFiltros,
                  ),
                  SizedBox(height: widget.tema.espacamento * 4),
                ],
        ),
      );
}
