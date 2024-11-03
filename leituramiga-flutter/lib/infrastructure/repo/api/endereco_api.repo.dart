import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
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
    print(endereco.paraMapa());
    if (endereco.numero == null) {
      await _salvarEndereco(endereco);
    } else {
      await _atualizarEndereco(endereco);
    }
  }

  Future<void> _salvarEndereco(Endereco endereco) async {
    await _client.post("$host/criar-endereco", data: endereco.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  Future<void> _atualizarEndereco(Endereco endereco) async {
    await _client.post("$host/atualizar-endereco", data: endereco.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<Endereco?> obterEndereco() async {
    return await _client.get("$host/endereco").catchError((erro) {
      if (erro.response?.statusCode == 404) throw EnderecoNaoEncontrado();
      throw erro;
    }).then((response) => Endereco.carregarDeMapa(response.data));
  }

  @override
  Future<List<Municipio>> obterMunicipios(UF uf, [String? pesquisa]) async {
    String url = "$host/cidades/${uf.name}";
    if (pesquisa != null) url += "?pesquisa=$pesquisa";
    return await _client.get(url).catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => Municipio.carregarDeMapa(e)).toList());
  }

  @override
  Future<void> desativarEndereco(int codigoEndereco)async {
    await _client.delete("$host/endereco/$codigoEndereco").catchError((erro) {
      throw erro;
    });
  }
}
