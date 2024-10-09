import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:leituramiga/repo/comentario.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class ComentarioApiRepo extends ComentarioRepo with ConfiguracaoApiState {
  static ComentarioApiRepo? _instancia;

  ComentarioApiRepo._();

  static ComentarioApiRepo get instancia {
    _instancia ??= ComentarioApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<void> cadastrarComentario(ComentarioPerfil comentario) async {
    await _client.post("$host/comentario", data: comentario.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<void> excluirComentario(int numeroComentario, String email) async {
    await _client.delete("$host/comentario/$numeroComentario").catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<List<ComentarioPerfil>> obterComentarios(String email) async {
    return await _client.get("$host/comentario", data: {"email": email}).catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => ComentarioPerfil.carregarDeMapa(e)).toList());
  }
}
