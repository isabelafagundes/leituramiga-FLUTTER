import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';

mixin class LivroState {
  Map<int, ResumoLivro> livrosPorNumero = {};
  Livro? livroSelecionado;
  Livro? livroEdicao;
  Categoria? categoriaSelecionada;

}