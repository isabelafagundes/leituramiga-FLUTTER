import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';

class UsuarioPaginacaoUseCase {
  final PaginacaoState<ResumoUsuario> _state;
  final UsuarioRepo _repo;

  const UsuarioPaginacaoUseCase(this._state, this._repo);

  Future<void> obterUsuariosIniciais() async {
    _state.reiniciar();
    List<ResumoUsuario> pagina = await _repo.obterUsuarios();
    _state.paginar(pagina);
  }

  Future<void> obterUsuariosPorPesquisa(String pesquisa) async {
    _state.reiniciar();
    _state.pesquisa = pesquisa;
    _state.pesquisou = true;
    List<ResumoUsuario> pagina = await _repo.obterUsuarios(pesquisa: pesquisa);
    _state.paginar(pagina);
  }

  Future<void> obterUsuariosPaginados({
    int limite = 18,
    String? pesquisa,
    int? numeroMunicipio,
    int? numeroInstituicao,
    bool reiniciar = false,
  }) async {
    if (reiniciar) _state.reiniciar();
    List<ResumoUsuario> pagina = await _repo.obterUsuarios(
      numeroPagina: _state.pagina,
      limite: _state.limite,
      numeroMunicipio: numeroMunicipio,
      numeroInstituicao: numeroInstituicao,
      pesquisa: pesquisa,
    );
    _state.paginar(pagina, limite, pesquisa ?? "");
  }
}
