import 'package:leituramiga/domain/livro/categoria.dart';

abstract class CategoriaRepo {
  Future<List<Categoria>> obterCategorias();
}