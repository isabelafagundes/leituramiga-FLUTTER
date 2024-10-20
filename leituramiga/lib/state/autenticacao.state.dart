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
  String accessToken = "";
  String refreshToken = "";
  Usuario? usuario;
  Senha senha = Senha.criar();

  void validarSenha() => senha.validarSenha();

  String get emailUsuario => usuario!.email.endereco;

  void atualizarAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }

  void atualizarRefreshToken(String refreshToken) {
    this.refreshToken = refreshToken;
  }

  void limparTokens() {
    accessToken = "";
    refreshToken = "";
    usuario = null;
  }
}
