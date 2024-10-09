import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/repo/instituicao_ensino.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class InstituicaoApiRepo extends InstituicaoEnsinoRepo with ConfiguracaoApiState {
  static InstituicaoApiRepo? _instancia;

  InstituicaoApiRepo._();

  static InstituicaoApiRepo get instancia {
    _instancia ??= InstituicaoApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<List<InstituicaoDeEnsino>> obterInstituicoes([String? pesquisa]) async {
    String query = "$host/instituicao";
    if (pesquisa != null) {
      query += "?pesquisa=$pesquisa";
    }
    return await _client.get(query).catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => InstituicaoDeEnsino.carregarDeMapa(e)).toList());
  }
}
