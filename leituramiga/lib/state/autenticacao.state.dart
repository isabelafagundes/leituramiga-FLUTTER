import 'dart:async';

import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/senha.dart';
import 'package:leituramiga/domain/usuario/email.dart';
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

  // Usuario? get usuario => Usuario.carregar(
  //       1,
  //       "Isabela Fagundes",
  //       "isabela",
  //       Email.criar("isabela@gmail.com"),
  //       null,
  //       5,
  //       "Sou estudante de ADS e tenho interesse em engenharia de software.",
  //       InstituicaoDeEnsino.carregar(1, "FATEC", "FATEC Santana de Parnaíba"),
  //       1,
  //       "Cajamar",
  //     );

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
