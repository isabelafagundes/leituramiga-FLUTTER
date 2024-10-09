import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:leituramiga/repo/comentario.repo.dart';

class ComentarioMockRepo extends ComentarioRepo {
  List<ComentarioPerfil> comentarioss = [];

  @override
  Future<void> cadastrarComentario(ComentarioPerfil comentario) {
    // TODO: implement cadastrarComentario
    throw UnimplementedError();
  }

  @override
  Future<void> excluirComentario(int numeroComentario, String email) {
    // TODO: implement excluirComentario
    throw UnimplementedError();
  }

  @override
  Future<List<ComentarioPerfil>> obterComentarios(String email) async {
    return comentarioss;
  }
}
