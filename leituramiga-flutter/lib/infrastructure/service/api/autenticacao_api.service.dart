import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/domain/usuario/usuario_autenticado.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class AutenticacaoApiService extends AutenticacaoService with ConfiguracaoApiState {
  static AutenticacaoApiService? _instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

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
  Future<UsuarioAutenticado> logar(String email, String senha) async {
    return await _client.post(
      "$host/login",
      data: {"email": email, "senha": senha},
    ).catchError((erro) {
      if (erro.response.statusCode == 401) throw CredenciaisIncorretas();
      if (erro.response.statusCode == 404) throw UsuarioNaoEncontrado();
      if (erro.response.statusCode == 412) throw UsuarioNaoAtivo();
      if (erro.response.statusCode == 409) throw CredenciaisExistentes();
      throw erro;
    }).then((response) => UsuarioAutenticado.carregarDeMapa(response.data));
  }

  @override
  Future<void> verificarCodigoSeguranca(String codigo, String email) async {
    await _client.post(
      "$host/verificar-codigo-seguranca",
      headers: {"Authorization": "Bearer ${_autenticacaoState.criacaoUsuarioToken}"},
      data: {"codigo": codigo, "email": email},
    ).catchError((erro) {
      if (erro.response.statusCode == 404) throw UsuarioJaExiste();
      if (erro.response.statusCode == 400) throw CodigoInvalido();
      if (erro.response.statusCode == 412) throw TokenExpirado();
      throw erro;
    });
  }

  @override
  Future<void> atualizarSenha(String email, String senha) async {
    Map<String, dynamic> data = {"email": email, "senha": senha};

    await _client.post(
      "$host/atualizar-senha",
      data: data,
      headers: {"Authorization": "Bearer ${_autenticacaoState.recuperacaoSenhaToken}"},
    ).catchError((erro) {
      if (erro.response.statusCode == 400) throw TokenExpirado();
      if (erro.response.statusCode == 404) throw UsuarioNaoEncontrado();
    });
  }

  @override
  Future<void> enviarCodigoCriacaoUsuario(String email) async {
    String token = await _client.post(
      "$host/enviar-codigo-verificacao",
      data: {"email": email},
    ).catchError((erro) {
      if (erro.response.statusCode == 404) throw UsuarioNaoEncontrado();
      throw erro;
    }).then((response) => response.data["token"]);

    _autenticacaoState.criacaoUsuarioToken = token;
  }

  @override
  Future<void> enviarCodigoRecuperacaoSenha(String email) async {
    String token = await _client.post(
      "$host/enviar-codigo-recuperacao",
      data: {"email": email},
    ).catchError((erro) {
      if (erro.response.statusCode == 404) throw UsuarioNaoEncontrado();
      throw erro;
    }).then((response) => response.data["token"]);

    _autenticacaoState.recuperacaoSenhaToken = token;
  }

  @override
  Future<void> iniciarRecuperacaoSenha(String email) async {
    String token = await _client.post(
      "$host/recuperar-senha",
      data: {"email": email},
    ).catchError((erro) {
      if (erro.response.statusCode == 404) throw UsuarioNaoEncontrado();
      throw erro;
    }).then((response) => response.data["token"]);

    _autenticacaoState.recuperacaoSenhaToken = token;
  }

  @override
  Future<void> verificarCodigoRecuperacao(String codigo, String email) async {
    await _client.post(
      "$host/verificar-codigo-recuperacao",
      headers: {"Authorization": "Bearer ${_autenticacaoState.recuperacaoSenhaToken}"},
      data: {"codigo": codigo, "email": email},
    ).catchError((erro) {
      if (erro.response.statusCode == 404) throw UsuarioJaExiste();
      if (erro.response.statusCode == 400) throw CodigoInvalido();
      if (erro.response.statusCode == 412) throw TokenExpirado();
      throw erro;
    });
  }
}
