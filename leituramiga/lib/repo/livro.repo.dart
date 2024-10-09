import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';

abstract class LivroRepo {
  Future<List<ResumoLivro>> obterLivros({
    int numeroPagina = 0,
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    TipoSolicitacao? tipo,
    String? pesquisa,
    int? numeroCategoria,
    String? emailUsuario,
  });

  Future<Livro> obterLivro(int numero);

  Future<void> deletarLivro(int numero);

  Future<void> atualizarLivro(Livro livro);
}
