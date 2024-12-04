import 'dart:async';

import 'package:leituramiga/domain/senha.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';

class AutenticacaoState {
  static AutenticacaoState? _instancia;

  AutenticacaoState._();

  static AutenticacaoState get instancia {
    _instancia ??= AutenticacaoState._();
    return _instancia!;
  }

  Future<void> Function() atualizarTokens = () async {};
  String _accessToken = "";
  String refreshToken = "";
  String criacaoUsuarioToken = "";
  String recuperacaoSenhaToken = "";
  Usuario? usuario;
  String email = "";
  Senha senha = Senha.criar();
  bool possuiTokens = false;

  String get accessToken => _accessToken;

  void validarSenha() => senha.validarSenha();

  String get emailUsuario => usuario!.email.endereco;

  void atualizarAccessToken(String accessToken) {
    this._accessToken = accessToken;
  }

  void atualizarRefreshToken(String refreshToken) {
    this.refreshToken = refreshToken;
  }

  void atualizarCriacaoUsuarioToken(String token) {
    criacaoUsuarioToken = token;
  }

  void atualizarRecuperacaoSenhaToken(String token) {
    recuperacaoSenhaToken = token;
  }

  void limparTokens() {
    _accessToken = "";
    refreshToken = "";
    criacaoUsuarioToken = "";
    recuperacaoSenhaToken = "";
    usuario = null;
  }
}
