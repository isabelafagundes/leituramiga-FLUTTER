import 'package:leituramiga/repo/instituicao_ensino.repo.dart';
import 'package:leituramiga/state/instituicao_ensino.state.dart';
import 'package:leituramiga/state/super/state.dart';
import 'package:leituramiga/usecase/instituicao_ensino.usecase.dart';

class InstituicaoComponent extends State with InstituicaoEnsinoState {
  late final InstituicaoEnsinoUseCase _useCase;

  void inicializar(InstituicaoEnsinoRepo repo, Function() atualizar) {
    _useCase = InstituicaoEnsinoUseCase(repo, this);
    super.atualizar = atualizar;
  }

  Future<void> obterInstituicoes() async {
    await executar(
      rotina: () => _useCase.obterInstituicoes(),
      mensagemErro: "Não foi possível obter as instituições de ensino",
    );
  }


}