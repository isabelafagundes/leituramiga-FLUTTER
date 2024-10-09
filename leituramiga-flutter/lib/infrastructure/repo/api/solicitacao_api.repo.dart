import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class SolicitacaoApiRepo extends SolicitacaoRepo with ConfiguracaoApiState {
  static SolicitacaoApiRepo? _instancia;

  SolicitacaoApiRepo._();

  static SolicitacaoApiRepo get instancia {
    _instancia ??= SolicitacaoApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<void> atualizarSolicitacao(Solicitacao solicitacao) async {
    if (solicitacao.numero == null) {
      await _criarSolicitacao(solicitacao);
    } else {
      await _atualizarSolicitacao(solicitacao);
    }
  }

  Future<void> _criarSolicitacao(Solicitacao solicitacao) async {
    await _client.post("$host/solicitacao", data: solicitacao.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  Future<void> _atualizarSolicitacao(Solicitacao solicitacao) async {
    await _client
        .post("$host/solicitacao/${solicitacao.numero}/atualizar", data: solicitacao.paraMapa())
        .catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<Solicitacao> obterSolicitacao(int numero) async {
    return await _client.get("$host/solicitacao/$numero").catchError((erro) {
      throw erro;
    }).then((response) => Solicitacao.carregarDeMapa(response.data));
  }

  @override
  Future<List<ResumoSolicitacao>> obterSolicitacoes(
    String emailUsuario, [
    int numeroPagina = 0,
    int limite = 50,
  ]) async {
    Map<String, dynamic> mapaFiltros = {
      "numeroPagina": numeroPagina,
      "tamanhoPagina": limite,
      "emailUsuario": emailUsuario,
    };

    return await _client.get("$host/solicitacoes", data: mapaFiltros).catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => ResumoSolicitacao.carregarDeMapa(e)).toList());
  }
}
