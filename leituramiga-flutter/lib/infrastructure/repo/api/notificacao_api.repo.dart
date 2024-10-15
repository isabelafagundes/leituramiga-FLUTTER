import 'package:leituramiga/domain/notificacao.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class NotificacaoApiRepo extends NotificacaoRepo with ConfiguracaoApiState {
  static NotificacaoApiRepo? _instancia;

  NotificacaoApiRepo._();

  static NotificacaoApiRepo get instancia {
    _instancia ??= NotificacaoApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<List<Notificacao>> obterNotificacoes(String emailUsuario) async {
    return await _client.get("$host/notificacoes").catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => Notificacao.carregarDeMapa(e)).toList());
  }
}
