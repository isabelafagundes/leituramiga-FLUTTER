import 'package:dio/dio.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/sessao_flutter.service.dart';

class Interceptor extends InterceptorsWrapper {
  static Interceptor? _instancia;

  Interceptor._();

  static Interceptor get instancia {
    _instancia ??= Interceptor._();
    return _instancia!;
  }

  SessaoFlutterService get _sessaoFlutterService => SessaoFlutterService.instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;
  int _tentativas = 1;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("Efetuando requisição para ${options.uri}");
    String token =
        options.uri.path.contains('refresh') ? _autenticacaoState.refreshToken : _autenticacaoState.accessToken;
    if (!options.headers.containsKey("Authorization")) options.headers["Authorization"] = "Bearer $token";
    options.headers["Content-Type"] = "application/json";
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('Recebendo resposta da requisitação: ${response.statusCode} ${response.statusMessage}');
    await _atualizarTokenSeNaoAutorizado(response);
    await _deslogarSeTentativasExcedidas(response);
    _resetarTentativasSeSucesso(response);
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }

  Future<void> _atualizarTokenSeNaoAutorizado(Response response) async {
    if (response.statusCode == 401 && _tentativas <= 3) {
      print('Iniciando a tentativa $_tentativas de atualização do token de acesso...');
      _autenticacaoState.atualizarTokens();
      _tentativas++;
    }
  }

  Future<void> _deslogarSeTentativasExcedidas(Response response) async {
    if (response.statusCode == 401 && _tentativas > 3) {
      print('Tentativas de atualização do token de acesso esgotadas. Redirecionando para a tela de login...');
      _sessaoFlutterService.limpar();
      _autenticacaoState.limparTokens();
      _tentativas = 0;
    }
  }

  void _resetarTentativasSeSucesso(Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      _tentativas = 0;
    }
  }
}
