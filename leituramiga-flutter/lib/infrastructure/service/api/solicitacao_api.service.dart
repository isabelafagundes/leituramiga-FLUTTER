import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/service/solicitacao.service.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class SolicitacaoApiService extends SolicitacaoService with ConfiguracaoApiState {
  static SolicitacaoApiService? _instancia;

  SolicitacaoApiService._();

  static SolicitacaoApiService get instancia {
    _instancia ??= SolicitacaoApiService._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<void> aceitarSolicitacao(int numero, LivrosSolicitacao? livrosTroca, Endereco? segundoEndereco) async {
    Map<String, dynamic> mapa = {
      "livros": livrosTroca?.paraMapa(),
      "codigoSolicitacao": numero,
      "endereco": segundoEndereco?.paraMapa(),
    };
    await _client.post("$host/solicitacao/$numero/aceitar", data: mapa).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<void> cancelarSolicitacao(int numero, String motivo) async {
    await _client.post("$host/solicitacao/$numero/cancelar", data: {
      "motivo": motivo,
      "codigoSolicitacao": numero,
    }).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<void> recusarSolicitacao(int numero, String motivo) async {
    await _client.post("$host/solicitacao/$numero/recusar", data: {
      "motivo": motivo,
      "codigoSolicitacao": numero,
    }).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<void> finalizarSolicitacao(int numero) async {
    await _client.post("$host/solicitacao/$numero/finalizar").catchError((erro) {
      throw erro;
    });
  }
}
