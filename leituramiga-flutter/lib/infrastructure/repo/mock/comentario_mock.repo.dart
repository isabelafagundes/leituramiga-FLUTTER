import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:leituramiga/repo/comentario.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';

class ComentarioMockRepo extends ComentarioRepo {
  static ComentarioMockRepo? _instancia;

  ComentarioMockRepo._();

  static ComentarioMockRepo get instancia {
    _instancia ??= ComentarioMockRepo._();
    return _instancia!;
  }

  final List<ComentarioPerfil> _comentarios = [];

  @override
  Future<void> cadastrarComentario(ComentarioPerfil comentario) async {
    int proximoNumero = (_comentarios.map((e) => e.numero ?? 0).fold<int>(0, (a, b) => a > b ? a : b)) + 1;

    String nomeCriador = UsuarioMockRepo.instancia
        .obterUsuarioPorIdentificador(comentario.emailUsuarioCriador)
        .nomeUsuario;

    _comentarios.add(
      ComentarioPerfil.carregar(
        proximoNumero,
        comentario.emailUsuarioCriador,
        comentario.comentario,
        nomeCriador,
        comentario.emailUsuarioPerfil,
        DataHora.hoje(),
        null,
      ),
    );
  }

  @override
  Future<void> excluirComentario(int numeroComentario, String email) async {
    _comentarios.removeWhere(
      (comentario) => comentario.numero == numeroComentario && comentario.emailUsuarioCriador == email,
    );
  }

  @override
  Future<List<ComentarioPerfil>> obterComentarios(String email) async {
    return _comentarios.where((comentario) => comentario.emailUsuarioPerfil == email).toList();
  }
}
