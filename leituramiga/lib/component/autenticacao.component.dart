import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:leituramiga/service/sessao.service.dart';
import 'package:leituramiga/state/super/state.dart';
import 'package:leituramiga/usecase/autenticacao.usecase.dart';

class AutenticacaoComponent extends State {
  late final AutenticacaoUseCase _useCase;

  void inicializar(
    AutenticacaoService autenticacaoService,
    SessaoService sessaoService,
    UsuarioRepo repo,
    Function() atualizar,
  ) {
    super.atualizar = atualizar;
    _useCase = AutenticacaoUseCase(
      autenticacaoService,
      sessaoService,
      repo,
    );
  }

  Future<void> deslogar() async {
    await executar(
      rotina: () async => await _useCase.deslogar(),
      mensagemErro: "Não foi possível deslogar",
    );
  }

  Future<void> desativar() async {
    await executar(
      rotina: () async => await _useCase.desativar(),
      mensagemErro: "Não foi possível desativar",
    );
  }

  Future<void> atualizarTokens() async {
    await executar(
      rotina: () async => await _useCase.atualizarTokens(),
      mensagemErro: "Não foi possível atualizar os tokens",
    );
  }

  Future<void> logar(String email, String senha) async {
    await executar(
      rotina: () async => await _useCase.logar(email, senha),
      mensagemErro: "Não foi possível logar",
    );
  }

  Future<void> validarCodigoSeguranca(String codigo, String email) async {
    await executar(
      rotina: () async => await _useCase.validarCodigoSeguranca(codigo, email),
      mensagemErro: "Não foi possível validar o código",
    );
  }

  Future<void> validarCodigoRecuperacao(String codigo, String email) async {
    await executar(
      rotina: () async => await _useCase.validarCodigoRecuperacao(codigo, email),
      mensagemErro: "Não foi possível validar o código",
    );
  }

  Future<void> atualizarSenha(String senha) async {
    await executar(
      rotina: () async => _useCase.atualizarSenha(senha),
      mensagemErro: "Não foi possível atualizar a senha",
    );
  }

  Future<void> atualizarConfirmacaoSenha(String confirmacaoSenha) async {
    await executar(
      rotina: () async => _useCase.atualizarConfirmacaoSenha(confirmacaoSenha),
      mensagemErro: "Não foi possível atualizar a confirmação da senha",
    );
  }

  Future<void> carregarSessao() async {
    await executar(
      rotina: () async => await _useCase.carregarSessao(),
      mensagemErro: "Não foi possível carregar a sessão",
    );
  }

  Future<void> enviarCodigoCriacaoUsuario(String email) async {
    await executar(
      rotina: () async => await _useCase.enviarCodigoCriacaoUsuario(email),
      mensagemErro: "Não foi possível enviar o código de criação de usuário",
    );
  }

  Future<void> enviarCodigoRecuperacao(String email) async {
    await executar(
      rotina: () async => await _useCase.enviarCodigoRecuperacaoSenha(email),
      mensagemErro: "Não foi possível enviar o código de recuperação",
    );
  }

  Future<void> iniciarRecuperacaoSenha(String email) async {
    await executar(
      rotina: () async => await _useCase.iniciarRecuperacaoSenha(email),
      mensagemErro: "Não foi possível iniciar a recuperação de senha",
    );
  }

  Future<void> atualizarRecuperacaoSenha() async {
    await executar(
      rotina: () async => await _useCase.atualizarRecuperacaoSenha(),
      mensagemErro: "Não foi possível atualizar a recuperação de senha",
    );
  }

  Future<void> validarIdentificador(String username, String email) async {
    await executar(
      rotina: () async => await _useCase.validarIdentificador(username, email),
      mensagemErro: "Não foi possível validar o identificador",
    );
  }

  Future<void> validarSePossuiToken() async {
    await executar(
      rotina: () async => await _useCase.validarSePossuiToken(),
      mensagemErro: "Não foi possível validar o token",
    );
  }
}
