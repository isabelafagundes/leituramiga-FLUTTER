import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/state/filtros.state.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';
import 'package:leituramiga/state/usuario.state.dart';
import 'package:leituramiga/state/super/state.dart';
import 'package:leituramiga/usecase/usuario.usecase.dart';
import 'package:leituramiga/usecase/usuario_paginacao.usecase.dart';

class UsuariosComponent extends State with UsuarioState, PaginacaoState<ResumoUsuario> {
  late final UsuarioUseCase _useCase;
  late final UsuarioPaginacaoUseCase _usuarioPaginacaoUseCase;

  FiltroState get filtroState => FiltroState.instancia;

  void inicializar(UsuarioRepo repo, Function() atualizar) {
    _useCase = UsuarioUseCase(repo, this);
    _usuarioPaginacaoUseCase = UsuarioPaginacaoUseCase(this, repo);
    super.atualizar = atualizar;
  }

  Future<void> obterUsuariosIniciais() async {
    await executar(
      rotina: () async => _usuarioPaginacaoUseCase.obterUsuariosIniciais(),
      mensagemErro: "Não foi possível obter os usuários",
    );
  }

  Future<void> obterUsuario(String email) async {
    await executar(
      rotina: () async => _useCase.obterUsuario(email),
      mensagemErro: "Não foi possível obter o usuário",
    );
  }

  Future<void> obterUsuariosPaginados() async {
    executar(
      rotina: () async {
        _usuarioPaginacaoUseCase.obterUsuariosPaginados(
          numeroMunicipio: filtroState.numeroMunicipio,
          numeroInstituicao: filtroState.numeroInstituicao,
          pesquisa: pesquisa,
          limite: limite,
        );
      },
      mensagemErro: "Não foi possível obter os usuários paginado",
    );
  }

  void selecionarMunicipio(Municipio municipio) {
    executar(
      rotina: () => filtroState.selecionarMunicipio(municipio),
      mensagemErro: "Erro ao selecionar o filtro de município",
    );
  }

  void selecionarInstituicao(InstituicaoDeEnsino instituicao) {
    executar(
      rotina: () => filtroState.selecionarInstituicao(instituicao),
      mensagemErro: "Erro ao selecionar o filtro de instituição",
    );
  }
}
