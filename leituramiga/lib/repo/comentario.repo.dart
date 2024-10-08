import 'package:leituramiga/domain/usuario/comentario_perfil.dart';

abstract class ComentarioRepo {
  Future<List<ComentarioPerfil>> obterComentarios(String email);

  Future<void> excluirComentario(int numeroComentario, String email);

  Future<void> cadastrarComentario(ComentarioPerfil comentario);
}
