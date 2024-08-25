import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/repo/categoria.repo.dart';

class CategoriaMockRepo extends CategoriaRepo {
  List<Categoria> categorias = [
    Categoria.carregar(1, "Infantil"),
    Categoria.carregar(2, "Tecnologia"),
    Categoria.carregar(3, "Fantasia"),
    Categoria.carregar(4, "Terror"),
    Categoria.carregar(5, "Romance"),
    Categoria.carregar(6, "Aventura"),
    Categoria.carregar(7, "Mangá"),
    Categoria.carregar(8, "Ficção Científica"),
    Categoria.carregar(9, "Biografia"),
    Categoria.carregar(10, "História"),
    Categoria.carregar(11, "Histórias em Quadrinhos"),
    Categoria.carregar(12, "Autoajuda"),
    Categoria.carregar(13, "Religião"),
    Categoria.carregar(14, "Policial"),
    Categoria.carregar(15, "Drama"),
    Categoria.carregar(16, "Comédia"),
    Categoria.carregar(17, "Suspense"),
    Categoria.carregar(18, "Didático"),
    Categoria.carregar(19, "Poesia"),
    Categoria.carregar(20, "Conto"),
    Categoria.carregar(21, "Crônica"),
    Categoria.carregar(22, "Fábula"),
    Categoria.carregar(23, "Biologia"),
    Categoria.carregar(24, "Geografia"),
    Categoria.carregar(25, "Matemática"),
    Categoria.carregar(26, "Português"),
    Categoria.carregar(27, "História"),
    Categoria.carregar(28, "Física"),
    Categoria.carregar(29, "Química"),
    Categoria.carregar(30, "Inglês"),
    Categoria.carregar(31, "Espanhol"),
    Categoria.carregar(32, "Francês"),
    Categoria.carregar(33, "Alemão"),
  ];

  @override
  Future<List<Categoria>> obterCategorias() async {
    return categorias;
  }
}
