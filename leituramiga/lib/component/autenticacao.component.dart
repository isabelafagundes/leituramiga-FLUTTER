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
    executar(
      rotina: () async => await _useCase.deslogar(),
      mensagemErro: "Não foi possível deslogar",
    );
  }

  Future<void> desativar() async {
    executar(
      rotina: () async => await _useCase.desativar(),
      mensagemErro: "Não foi possível desativar",
    );
  }

  Future<void> atualizarTokens() async {
    executar(
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
    executar(
      rotina: () async => await _useCase.validarCodigoSeguranca(codigo, email),
      mensagemErro: "Não foi possível validar o código",
    );
  }

  Future<void> atualizarSenha(String senha) async {
    executar(
      rotina: () async => _useCase.atualizarSenha(senha),
      mensagemErro: "Não foi possível atualizar a senha",
    );
  }

  Future<void> atualizarConfirmacaoSenha(String confirmacaoSenha) async {
    executar(
      rotina: () async => _useCase.atualizarConfirmacaoSenha(confirmacaoSenha),
      mensagemErro: "Não foi possível atualizar a confirmação da senha",
    );
  }
}
