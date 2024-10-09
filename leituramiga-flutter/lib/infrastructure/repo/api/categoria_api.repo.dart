import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/repo/categoria.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class CategoriaApiRepo extends CategoriaRepo with ConfiguracaoApiState{
  static CategoriaApiRepo? _instancia;

  CategoriaApiRepo._();

  static CategoriaApiRepo get instancia {
    _instancia ??= CategoriaApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<List<Categoria>> obterCategorias() async {
    return await _client.get("$host/categorias").catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => Categoria.carregarDeMapa(e)).toList());
  }

}