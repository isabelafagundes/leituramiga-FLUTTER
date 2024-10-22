import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/livro.repo.dart';

class LivroMockRepo extends LivroRepo {
  List<ResumoLivro> livros = [];

  @override
  Future<void> atualizarLivro(Livro livro) {
    // TODO: implement atualizarLivro
    throw UnimplementedError();
  }

  @override
  Future<void> desativarLivro(int numero) {
    // TODO: implement excluirLivro
    throw UnimplementedError();
  }

  @override
  Future<Livro> obterLivro(int numero) async {
    return Livro.carregar(
      1,
      "O pequeno príncipe",
      "Antoine de Saint-Exupéry",
      "O livro conta a história de um piloto que cai no deserto do Saara e encontra um pequeno príncipe, que veio de um pequeno asteroide, o asteroide B-612.",
      "O livro está em bom estado",
      1,
      [TipoSolicitacao.DOACAO, TipoSolicitacao.TROCA],
      "isabela",
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      "isabela",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "",
      "",
    );
  }

  @override
  Future<List<ResumoLivro>> obterLivros({int numeroPagina = 0, int limite = 18, int? numeroMunicipio, int? numeroInstituicao, TipoSolicitacao? tipo, String? pesquisa, int? numeroCategoria, String? emailUsuario}) {
    // TODO: implement obterLivros
    throw UnimplementedError();
  }


}
