import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/repo/instituicao_ensino.repo.dart';

class InstituicaoMockRepo extends InstituicaoEnsinoRepo {
  List<InstituicaoDeEnsino> instituicoes = [
    InstituicaoDeEnsino.carregar(1, "FATECSDP", "FATEC Santana de Parnaíba"),
    InstituicaoDeEnsino.carregar(2, "FATECSP", "FATEC São Paulo"),
    InstituicaoDeEnsino.carregar(3, "FATECSCS", "FATEC São Caetano do Sul"),
    InstituicaoDeEnsino.carregar(4, "FATECSC", "FATEC São Carlos"),
    InstituicaoDeEnsino.carregar(5, "FATECJ", "FATEC Jundiaí"),
    InstituicaoDeEnsino.carregar(6, "FATECOS", "FATEC Osasco"),
    InstituicaoDeEnsino.carregar(7, "UNIP", "Universidade Paulista"),
    InstituicaoDeEnsino.carregar(8, "USP", "Universidade de São Paulo"),
    InstituicaoDeEnsino.carregar(9, "UNESP", "Universidade Estadual Paulista"),
    InstituicaoDeEnsino.carregar(10, "UNICAMP", "Universidade Estadual de Campinas"),
    InstituicaoDeEnsino.carregar(11, "UNIFESP", "Universidade Federal de São Paulo"),
    InstituicaoDeEnsino.carregar(12, "UNICID", "Universidade Cidade de São Paulo"),
    InstituicaoDeEnsino.carregar(13, "UNINOVE", "Universidade Nove de Julho"),
    InstituicaoDeEnsino.carregar(14, "UNIBAN", "Universidade Bandeirante"),
    InstituicaoDeEnsino.carregar(15, "UNIMONTE", "Universidade Monte Serrat"),
    InstituicaoDeEnsino.carregar(16, "UNISANTOS", "Universidade Católica de Santos"),
    InstituicaoDeEnsino.carregar(17, "UNISANTA", "Universidade Santa Cecília"),
    InstituicaoDeEnsino.carregar(18, "UNIMES", "Universidade Metropolitana de Santos"),
    InstituicaoDeEnsino.carregar(19, "UNIFESP", "Universidade Federal de São Paulo"),
    InstituicaoDeEnsino.carregar(20, "UNIFESP", "Universidade Federal de São Paulo"),
  ];

  @override
  Future<List<InstituicaoDeEnsino>> obterInstituicoes() async {
    return instituicoes;
  }
}
