import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/domain/usuario/usuario_autenticado.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:leituramiga/service/sessao.service.dart';
import 'package:leituramiga/state/autenticacao.state.dart';

class AutenticacaoUseCase {
  final AutenticacaoService _autenticacaoService;
  final SessaoService _sessaoService;
  final UsuarioRepo _repo;

  AutenticacaoState get _state => AutenticacaoState.instancia;

  const AutenticacaoUseCase(this._autenticacaoService, this._sessaoService, this._repo);

  Future<void> deslogar() async {
    _state.limparTokens();
    await _sessaoService.limpar();
  }

  Future<void> desativar() async {
    await _autenticacaoService.desativar();
    await deslogar();
  }

  Future<void> atualizarTokens() async {
    UsuarioAutenticado? usuario = await _autenticacaoService.atualizarTokens();
    if (usuario != null) {
      _state.atualizarAccessToken(usuario.accessToken);
      _state.atualizarRefreshToken(usuario.refreshToken);
      await _sessaoService.salvarToken({'accessToken': usuario.accessToken, 'refreshToken': usuario.refreshToken});
    }
  }

  Future<UsuarioAutenticado?> logar(String email, String senha) async {
    UsuarioAutenticado? usuario = await _autenticacaoService.logar(email, senha);
    if (usuario != null) {
      _state.atualizarAccessToken(usuario.accessToken);
      _state.atualizarRefreshToken(usuario.refreshToken);
      await _sessaoService.salvarToken({'accessToken': usuario.accessToken, 'refreshToken': usuario.refreshToken});
      await _obterUsuario(email);
    }
    return usuario;
  }

  Future<void> _obterUsuario(String email) async {
    Usuario usuario = await _repo.obterUsuario(email);
    _state.usuario = usuario;
  }

  Future<void> validarCodigoSeguranca(String codigo, String email) async {
    await _autenticacaoService.verificarCodigoSeguranca(codigo, email);
  }

  Future<void> validarCodigoRecuperacao(String codigo, String email) async {
    await _autenticacaoService.verificarCodigoRecuperacao(codigo, email);
  }

  void atualizarSenha(String senha) {
    _state.senha.atualizarSenha(senha);
    _state.senha.validarSenha();
  }

  void atualizarConfirmacaoSenha(String confirmacaoSenha) {
    _state.senha.atualizarConfirmacaoSenha(confirmacaoSenha);
    _state.senha.validarSenha();
  }

  Future<void> carregarSessao() async {
    Map<String, dynamic> tokens = await _sessaoService.obterTokens();
    if (tokens.isNotEmpty && tokens['accessToken'] != null && tokens['refreshToken'] != null) {
      _state.atualizarAccessToken(tokens['accessToken']!);
      _state.atualizarRefreshToken(tokens['refreshToken']!);
      Usuario usuario = await _repo.obterUsuarioPerfil();
      _state.usuario = usuario;
    }
  }

  Future<void> enviarCodigoCriacaoUsuario(String email) async {
    await _autenticacaoService.enviarCodigoCriacaoUsuario(email);
  }

  Future<void> enviarCodigoRecuperacaoSenha(String email) async {
    await _autenticacaoService.enviarCodigoRecuperacaoSenha(email);
  }

  Future<void> iniciarRecuperacaoSenha(String email) async {
    await _autenticacaoService.iniciarRecuperacaoSenha(email);
    _state.email = email;
  }

  Future<void> validarIdentificador(String username, String email) async {
    await _autenticacaoService.validarIdentificador(username, email);
  }

  Future<void> atualizarRecuperacaoSenha() async {
    await _autenticacaoService.atualizarSenha(_state.email, _state.senha.senha);
  }

  Future<void> validarSePossuiToken() async {
    bool possuiToken = await _sessaoService.validarSePossuiToken();
    _state.possuiTokens = possuiToken;
    if (possuiToken) {
      await carregarSessao();
    } else {
      _state.limparTokens();
    }
  }

}
