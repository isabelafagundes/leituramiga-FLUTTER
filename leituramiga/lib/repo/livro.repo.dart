import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';

abstract class LivroRepo {
  Future<List<ResumoLivro>> obterLivros();

  Future<Livro> obterLivro(int numero);

  Future<void> excluirLivro(int numero);

  Future<void> atualizarLivro(Livro livro);

}
