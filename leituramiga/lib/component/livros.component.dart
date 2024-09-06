import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/categoria.repo.dart';
import 'package:leituramiga/repo/instituicao_ensino.repo.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:leituramiga/state/categoria.state.dart';
import 'package:leituramiga/state/endereco.state.dart';
import 'package:leituramiga/state/filtros.state.dart';
import 'package:leituramiga/state/instituicao_ensino.state.dart';
import 'package:leituramiga/state/livro.state.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';
import 'package:leituramiga/state/super/state.dart';
import 'package:leituramiga/usecase/categoria.usecase.dart';
import 'package:leituramiga/usecase/endereco.usecase.dart';
import 'package:leituramiga/usecase/instituicao_ensino.usecase.dart';
import 'package:leituramiga/usecase/livro.usecase.dart';
import 'package:leituramiga/usecase/paginacao_livro.usecase.dart';

import '../repo/endereco.repo.dart';

class LivrosComponent extends State
    with LivroState, PaginacaoState<ResumoLivro>, CategoriaState, InstituicaoEnsinoState, EnderecoState {
  late final LivroUseCase _livroUseCase;
  late final PaginacaoLivroUseCase _paginacaoUseCase;
  late final CategoriaUseCase _categoriaUseCase;
  late final InstituicaoEnsinoUseCase _instituicaoUseCase;
  late final EnderecoUseCase _enderecoUseCase;

  FiltroState get filtroState => FiltroState.instancia;

  void inicializar(LivroRepo livroRepo, CategoriaRepo categoriaRepo, InstituicaoEnsinoRepo instituicaoRepo,
      EnderecoRepo enderecoRepo, Function() atualizar) {
    _livroUseCase = LivroUseCase(livroRepo, this);
    _paginacaoUseCase = PaginacaoLivroUseCase(this, livroRepo);
    _categoriaUseCase = CategoriaUseCase(categoriaRepo, this);
    _instituicaoUseCase = InstituicaoEnsinoUseCase(instituicaoRepo, this);
    _enderecoUseCase = EnderecoUseCase(this, enderecoRepo);
    super.atualizar = atualizar;
  }

  Future<void> obterLivrosIniciais() async {
    executar(
      rotina: () async => await _paginacaoUseCase.obterLivrosIniciais(),
      mensagemErro: "Não foi possível obter os livros",
    );
  }

  Future<void> obterLivro(int numero) async {
    await executar(
      rotina: () async => _livroUseCase.obterLivro(numero),
      mensagemErro: "Não foi possível obter livro",
    );
  }

  Future<void> obterLivrosPaginados() async {
    await executar(
      rotina: () async {
        await _paginacaoUseCase.obterLivrosPaginados(
          numeroMunicipio: filtroState.numeroMunicipio,
          numeroCategoria: filtroState.numeroCategoria,
          numeroInstituicao: filtroState.numeroInstituicao,
          tipo: filtroState.tipo,
          pesquisa: pesquisa,
          limite: limite,
        );
      },
      mensagemErro: "Não foi possível obter os livros",
    );
  }

  void selecionarCategoria(Categoria categoria) {
    executar(
      rotina: () => filtroState.selecionarCategoria(categoria),
      mensagemErro: "Erro ao selecionar o filtro de categoria",
    );
  }

  void selecionarMunicipio(Municipio municipio) {
    executar(
      rotina: () => filtroState.selecionarMunicipio(municipio),
      mensagemErro: "Erro ao selecionar o filtro de município",
    );
  }

  void selecionarTipoSolicitacao(TipoSolicitacao tipo) {
    executar(
      rotina: () => filtroState.selecionarTipo(tipo),
      mensagemErro: "Erro ao selecionar o filtro de tipo",
    );
  }

  void selecionarInstituicao(InstituicaoDeEnsino instituicao) {
    executar(
      rotina: () => filtroState.selecionarInstituicao(instituicao),
      mensagemErro: "Erro ao selecionar o filtro de instituição",
    );
  }

  Future<void> obterCategorias() async {
    await executar(
      rotina: () async => await _categoriaUseCase.obterCategorias(),
      mensagemErro: "Não foi possível obter as categorias",
    );
  }

  Future<void> obterInstituicoes() async {
    await executar(
      rotina: () async => await _instituicaoUseCase.obterInstituicoes(),
      mensagemErro: "Não foi possível obter as instituições",
    );
  }

  void selecionarEstado(UF uf) {
     executar(
    rotina: () async => filtroState.selecionarEstado(uf),
    mensagemErro: "Não foi possível obter as instituições",
    );
  }

  Future<void> obterMunicipios() async {
    await executar(
      rotina: () async => await _enderecoUseCase.obterMunicipios(),
      mensagemErro: "Não foi possível obter os municípios",
    );
  }
}
