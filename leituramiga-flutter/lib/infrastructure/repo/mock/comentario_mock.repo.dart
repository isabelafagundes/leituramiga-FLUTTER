import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:leituramiga/repo/comentario.repo.dart';

class ComentarioMockRepo extends ComentarioRepo {
  List<ComentarioPerfil> comentarioss = [
    ComentarioPerfil.carregar(1, 1, 2, "Muito obrigado pela entrega do livro, está em ótimo estado!", "joao"),
    ComentarioPerfil.carregar(2, 2, 1, "O usuário colocou os livros no correio rapidamente!", "maria"),
    ComentarioPerfil.carregar(3, 1, 2, "O livro está em ótimo estado, obrigado!", "kauaguedes"),
    ComentarioPerfil.carregar(4, 2, 1, "Muito obrigada pelas doações de livros.", "isabela"),
  ];

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
