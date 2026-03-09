import 'dart:async';

import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/domain/usuario/usuario_autenticado.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';

class AutenticacaoMockService extends AutenticacaoService {
  static AutenticacaoMockService? _instancia;

  final Map<String, String> _codigosCriacao = {};
  final Map<String, String> _codigosRecuperacao = {};

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;
  UsuarioMockRepo get _usuarioRepo => UsuarioMockRepo.instancia;

  AutenticacaoMockService._();

  static AutenticacaoMockService get instancia {
    _instancia ??= AutenticacaoMockService._();
    return _instancia!;
  }

  @override
  Future<void> atualizarSenha(String email, String senha) async {
    await _latencia();
    if (_autenticacaoState.recuperacaoSenhaToken.isEmpty) throw TokenExpirado();
    String emailNormalizado = _usuarioRepo.obterEmailPorIdentificador(email);
    if (!_usuarioRepo.existePorEmail(emailNormalizado)) throw UsuarioNaoEncontrado();
  }

  @override
  Future<UsuarioAutenticado?> atualizarTokens() async {
    await _latencia();
    if (_autenticacaoState.refreshToken.isEmpty) return null;

    String email = _autenticacaoState.usuario?.email.endereco ?? _autenticacaoState.email;
    if (email.isEmpty || !_usuarioRepo.existePorEmail(email)) return null;

    String username = _usuarioRepo.obterUsuarioPorIdentificador(email).nomeUsuario;
    return _criarSessao(username, email);
  }

  @override
  Future<void> desativar() async {
    await _latencia();
    await _usuarioRepo.desativarUsuario();
  }

  @override
  Future<void> enviarCodigoCriacaoUsuario(String email) async {
    await _latencia();
    String emailNormalizado = _usuarioRepo.obterEmailPorIdentificador(email);
    _validarUsuarioExiste(emailNormalizado);

    String token = _gerarToken(emailNormalizado, 'criacao');
    _codigosCriacao[emailNormalizado] = '123456';
    _autenticacaoState.atualizarCriacaoUsuarioToken(token);
  }

  @override
  Future<void> enviarCodigoRecuperacaoSenha(String email) async {
    await _latencia();
    String emailNormalizado = _usuarioRepo.obterEmailPorIdentificador(email);
    _validarUsuarioExiste(emailNormalizado);

    String token = _gerarToken(emailNormalizado, 'recuperacao');
    _codigosRecuperacao[emailNormalizado] = '123456';
    _autenticacaoState.atualizarRecuperacaoSenhaToken(token);
  }

  @override
  Future<void> iniciarRecuperacaoSenha(String email) async {
    await enviarCodigoRecuperacaoSenha(email);
  }

  @override
  Future<UsuarioAutenticado> logar(String email, String senha) async {
    await _latencia();
    if (senha.trim().isEmpty) throw CredenciaisIncorretas();

    try {
      final usuario = _usuarioRepo.obterUsuarioPorIdentificador(email);
      if (_usuarioRepo.estaDesativado(usuario.email.endereco)) throw PerfilNaoAtivo();
      return _criarSessao(usuario.nomeUsuario, usuario.email.endereco);
    } on UsuarioNaoEncontrado {
      rethrow;
    } on UsuarioNaoAtivo {
      throw PerfilNaoAtivo();
    }
  }

  @override
  Future<void> validarIdentificador(String username, String email) async {
    await _latencia();
    if (_usuarioRepo.possuiIdentificador(username, email)) throw UsuarioJaExiste();
  }

  @override
  Future<void> verificarCodigoRecuperacao(String codigo, String email) async {
    await _latencia();
    if (_autenticacaoState.recuperacaoSenhaToken.isEmpty) throw TokenExpirado();

    String emailNormalizado = _usuarioRepo.obterEmailPorIdentificador(email);
    _validarUsuarioExiste(emailNormalizado);

    String codigoEsperado = _codigosRecuperacao[emailNormalizado] ?? '123456';
    if (codigo.trim().isEmpty || (codigo != codigoEsperado && codigo != '123456')) throw CodigoInvalido();
  }

  @override
  Future<void> verificarCodigoSeguranca(String codigo, String email) async {
    await _latencia();
    if (_autenticacaoState.criacaoUsuarioToken.isEmpty) throw TokenExpirado();

    String emailNormalizado = _usuarioRepo.obterEmailPorIdentificador(email);
    _validarUsuarioExiste(emailNormalizado);

    String codigoEsperado = _codigosCriacao[emailNormalizado] ?? '123456';
    if (codigo.trim().isEmpty || (codigo != codigoEsperado && codigo != '123456')) throw CodigoInvalido();
  }

  void _validarUsuarioExiste(String email) {
    if (!_usuarioRepo.existePorEmail(email)) throw UsuarioNaoEncontrado();
  }

  UsuarioAutenticado _criarSessao(String username, String email) {
    int agora = DateTime.now().millisecondsSinceEpoch;
    return UsuarioAutenticado.carregar(
      username,
      email,
      'mock_access_${email}_$agora',
      'mock_refresh_${email}_${agora + 1}',
    );
  }

  String _gerarToken(String email, String tipo) {
    int agora = DateTime.now().millisecondsSinceEpoch;
    return 'mock_${tipo}_token_${email}_$agora';
  }

  Future<void> _latencia() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
