import 'package:leituramiga/domain/usuario/usuario_autenticado.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class AutenticacaoApiService extends AutenticacaoService with ConfiguracaoApiState {
  static AutenticacaoApiService? _instancia;

  AutenticacaoApiService._();

  static AutenticacaoApiService get instancia {
    _instancia ??= AutenticacaoApiService._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<UsuarioAutenticado?> atualizarTokens() async {
    await _client.post("$host/refresh").catchError((erro) {
      throw erro;
    }).then((response) => UsuarioAutenticado.carregarDeMapa(response.data));
  }

  @override
  Future<void> desativar() async {
    await _client.post("$host/desativar").catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<UsuarioAutenticado?> logar(String email, String senha) async {
    await _client.post(
      "$host/login",
      data: {"email": email, "senha": senha},
    ).catchError((erro) {
      throw erro;
    }).then((response) => UsuarioAutenticado.carregarDeMapa(response.data));
  }

  @override
  Future<void> verificarCodigoSeguranca(String codigo, String email) async {
    await _client.post(
      "$host/verificar-codigo-seguranca",
      data: {"codigo": codigo, "email": email},
    ).catchError((erro) {
      throw erro;
    });
  }
}
