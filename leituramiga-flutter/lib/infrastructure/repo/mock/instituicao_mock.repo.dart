import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/repo/instituicao_ensino.repo.dart';

class InstituicaoMockRepo extends InstituicaoEnsinoRepo {
  static InstituicaoMockRepo? _instancia;

  InstituicaoMockRepo._();

  static InstituicaoMockRepo get instancia {
    _instancia ??= InstituicaoMockRepo._();
    return _instancia!;
  }

  final List<InstituicaoDeEnsino> instituicoes = [
    InstituicaoDeEnsino.carregar(1, 'FATECSDP', 'FATEC Santana de Parnaiba'),
    InstituicaoDeEnsino.carregar(2, 'FATECSP', 'FATEC Sao Paulo'),
    InstituicaoDeEnsino.carregar(3, 'FATECSCS', 'FATEC Sao Caetano do Sul'),
    InstituicaoDeEnsino.carregar(4, 'FATECSC', 'FATEC Sao Carlos'),
    InstituicaoDeEnsino.carregar(5, 'FATECJ', 'FATEC Jundiai'),
    InstituicaoDeEnsino.carregar(6, 'FATECOS', 'FATEC Osasco'),
    InstituicaoDeEnsino.carregar(7, 'UNIP', 'Universidade Paulista'),
    InstituicaoDeEnsino.carregar(8, 'USP', 'Universidade de Sao Paulo'),
    InstituicaoDeEnsino.carregar(9, 'UNESP', 'Universidade Estadual Paulista'),
    InstituicaoDeEnsino.carregar(10, 'UNICAMP', 'Universidade Estadual de Campinas'),
    InstituicaoDeEnsino.carregar(11, 'UNIFESP', 'Universidade Federal de Sao Paulo'),
    InstituicaoDeEnsino.carregar(12, 'UNICID', 'Universidade Cidade de Sao Paulo'),
    InstituicaoDeEnsino.carregar(13, 'UNINOVE', 'Universidade Nove de Julho'),
    InstituicaoDeEnsino.carregar(14, 'UNIBAN', 'Universidade Bandeirante'),
    InstituicaoDeEnsino.carregar(15, 'UNIMONTE', 'Universidade Monte Serrat'),
    InstituicaoDeEnsino.carregar(16, 'UNISANTOS', 'Universidade Catolica de Santos'),
    InstituicaoDeEnsino.carregar(17, 'UNISANTA', 'Universidade Santa Cecilia'),
    InstituicaoDeEnsino.carregar(18, 'UNIMES', 'Universidade Metropolitana de Santos'),
  ];

  @override
  Future<List<InstituicaoDeEnsino>> obterInstituicoes([String? pesquisa]) async {
    if (pesquisa == null || pesquisa.trim().isEmpty) return instituicoes;

    String pesquisaNormalizada = pesquisa.trim().toLowerCase();
    return instituicoes
        .where((instituicao) =>
            instituicao.nome.toLowerCase().contains(pesquisaNormalizada) ||
            instituicao.sigla.toLowerCase().contains(pesquisaNormalizada))
        .toList();
  }
}
