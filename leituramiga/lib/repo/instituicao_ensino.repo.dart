import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';

abstract class InstituicaoEnsinoRepo {
  Future<List<InstituicaoDeEnsino>> obterInstituicoes([String? pesquisa]);
}