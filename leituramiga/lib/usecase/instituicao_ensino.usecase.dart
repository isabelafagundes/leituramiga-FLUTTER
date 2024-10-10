import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/repo/instituicao_ensino.repo.dart';
import 'package:leituramiga/state/instituicao_ensino.state.dart';

class InstituicaoEnsinoUseCase {
  final InstituicaoEnsinoRepo _repo;
  final InstituicaoEnsinoState _state;

  const InstituicaoEnsinoUseCase(this._repo, this._state);

  Future<void> obterInstituicoes() async {
    List<InstituicaoDeEnsino> instituicoes = await _repo.obterInstituicoes();
    instituicoes;
    _state.instituicoesPorNumero.clear();
    for (InstituicaoDeEnsino instituicao in instituicoes) {
      _state.instituicoesPorNumero[instituicao.numero] = instituicao;
    }
  }
}
