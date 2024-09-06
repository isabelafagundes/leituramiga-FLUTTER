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

  Future<void> obterUsuarioSolicitacao(int numero) async {
    Usuario usuario = await _repo.obterUsuario(numero);
    print(usuario.nomeUsuario);
    _state.usuarioSolicitacao = usuario;
  }

  Future<void> atualizarUsuario() async {
    if (_state.usuarioEdicao == null) return;
    await _repo.atualizarUsuario(_state.usuarioEdicao!);
  }

  Future<void> excluirUsuario(int numero) async {
    await _repo.excluirUsuario(numero);
  }

  void atualizarUsuarioMemoria(Usuario usuario) {
    _state.usuarioEdicao = usuario;
  }
}
