import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/state/usuario.state.dart';

class UsuarioUseCase {
  final UsuarioRepo _repo;
  final UsuarioState _state;

  const UsuarioUseCase(this._repo, this._state);

  Future<void> obterUsuario(String email) async {
    Usuario usuario = await _repo.obterUsuario(email);
    _state.usuarioSelecionado = usuario;
  }

  Future<void> obterPerfil() async {
    Usuario usuario = await _repo.obterUsuarioPerfil();
    _state.usuarioSelecionado = usuario;
  }

  Future<void> obterUsuarioSolicitacao(String email) async {
    Usuario usuario = await _repo.obterUsuario(email);
    print(usuario.nomeUsuario);
    _state.usuarioSolicitacao = usuario;
  }

  Future<void> atualizarUsuario() async {
    if (_state.usuarioEdicao == null) return;
    await _repo.atualizarUsuario(_state.usuarioEdicao!);
  }

  Future<void> desativarUsuario() async {
    await _repo.desativarUsuario();
  }

  void atualizarUsuarioMemoria(Usuario usuario) {
    _state.usuarioEdicao = usuario;
  }
}
