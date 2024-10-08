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
    executar(
      rotina: () async => await _useCase.logar(email, senha),
      mensagemErro: "Não foi possível logar",
    );
  }
}
