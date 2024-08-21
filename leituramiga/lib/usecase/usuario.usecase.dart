import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/state/usuario.state.dart';

class UsuarioUseCase {
  final UsuarioRepo _repo;
  final UsuarioState _state;

  const UsuarioUseCase(this._repo, this._state);

  Future<void> obterUsuario(int numero) async {
    Usuario usuario = await _repo.obterUsuario(numero);
    _state.usuarioSelecionado = usuario;
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    if (_state.usuarioEdicao == null) return;
    _state.usuarioEdicao = usuario;
  }

  Future<void> excluirUsuario(int numero) async {
    await _repo.excluirUsuario(numero);
  }
}
