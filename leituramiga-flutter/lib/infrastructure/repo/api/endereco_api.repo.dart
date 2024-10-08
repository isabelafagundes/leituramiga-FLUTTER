import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/repo/endereco.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class EnderecoApiRepo extends EnderecoRepo with ConfiguracaoApiState {
  static EnderecoApiRepo? _instancia;

  EnderecoApiRepo._();

  static EnderecoApiRepo get instancia {
    _instancia ??= EnderecoApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<void> atualizarEndereco(Endereco endereco) async {
    await _client.post("$host/endereco", data: endereco.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<Endereco> obterEndereco() async {
    return await _client.get("$host/endereco").catchError((erro) {
      throw erro;
    }).then((response) => Endereco.carregarDeMapa(response.data));
  }

  @override
  Future<List<Municipio>> obterMunicipios() async {
    return await _client.get("$host/cidades").catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => Municipio.carregarDeMapa(e)).toList());
  }
}