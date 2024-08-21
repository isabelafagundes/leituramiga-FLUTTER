import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:leituramiga/repo/comentario.repo.dart';
import 'package:leituramiga/state/comentario.state.dart';

class ComentarioUseCase {
  final ComentarioRepo _repo;
  final ComentarioState _state;

  const ComentarioUseCase(this._repo, this._state);

  Future<void> obterComentarios(int usuario) async {
    List<ComentarioPerfil> comentarios = await _repo.obterComentarios(usuario);
    _state.comentarios = comentarios;
  }

  Future<void> cadastrarComentario() async {
    if (_state.comentarioEdicao == null) return;
    await _repo.cadastrarComentario(_state.comentarioEdicao!);
  }

  Future<void> excluirComentario(int numeroComentario, int numeroPerfil) async {
    await _repo.excluirComentario(numeroComentario, numeroPerfil);
  }
}
