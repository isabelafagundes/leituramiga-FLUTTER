import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/repo/categoria.repo.dart';

class CategoriaMockRepo extends CategoriaRepo {
  static CategoriaMockRepo? _instancia;

  CategoriaMockRepo._();

  static CategoriaMockRepo get instancia {
    _instancia ??= CategoriaMockRepo._();
    return _instancia!;
  }

  final List<Categoria> categorias = [
    Categoria.carregar(1, 'Infantil'),
    Categoria.carregar(2, 'Tecnologia'),
    Categoria.carregar(3, 'Fantasia'),
    Categoria.carregar(4, 'Terror'),
    Categoria.carregar(5, 'Romance'),
    Categoria.carregar(6, 'Aventura'),
    Categoria.carregar(7, 'Manga'),
    Categoria.carregar(8, 'Ficcao Cientifica'),
    Categoria.carregar(9, 'Biografia'),
    Categoria.carregar(10, 'Historia'),
    Categoria.carregar(11, 'Historias em Quadrinhos'),
    Categoria.carregar(12, 'Autoajuda'),
    Categoria.carregar(13, 'Religiao'),
    Categoria.carregar(14, 'Policial'),
    Categoria.carregar(15, 'Drama'),
    Categoria.carregar(16, 'Comedia'),
    Categoria.carregar(17, 'Suspense'),
    Categoria.carregar(18, 'Didatico'),
    Categoria.carregar(19, 'Poesia'),
    Categoria.carregar(20, 'Conto'),
    Categoria.carregar(21, 'Cronica'),
    Categoria.carregar(22, 'Fabula'),
    Categoria.carregar(23, 'Biologia'),
    Categoria.carregar(24, 'Geografia'),
    Categoria.carregar(25, 'Matematica'),
    Categoria.carregar(26, 'Portugues'),
    Categoria.carregar(27, 'Fisica'),
    Categoria.carregar(28, 'Quimica'),
    Categoria.carregar(29, 'Ingles'),
    Categoria.carregar(30, 'Espanhol'),
    Categoria.carregar(31, 'Frances'),
    Categoria.carregar(32, 'Alemao'),
  ];

  @override
  Future<List<Categoria>> obterCategorias() async {
    return categorias;
  }
}
