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

  Future<void> obterUsuariosPaginados({
    int limite = 18,
    String? pesquisa,
    int? numeroMunicipio,
    int? numeroInstituicao,
  }) async {
    List<ResumoUsuario> pagina = await _repo.obterUsuarios(
      _state.pagina,
      _state.limite,
      numeroMunicipio,
      numeroInstituicao,
      pesquisa,
    );
    _state.paginar(pagina, limite, pesquisa ?? "");
  }
}
