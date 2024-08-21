import 'package:leituramiga/domain/usuario/comentario_perfil.dart';

abstract class ComentarioRepo {
  Future<List<ComentarioPerfil>> obterComentarios(int numeroPerfil);

  Future<void> excluirComentario(int numeroComentario, int numeroPerfil);

  Future<void> cadastrarComentario(ComentarioPerfil comentario);
}
