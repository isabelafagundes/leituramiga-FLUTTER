import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/repo/categoria.repo.dart';
import 'package:leituramiga/state/categoria.state.dart';

class CategoriaUseCase {
  final CategoriaRepo _repo;
  final CategoriaState _state;

  const CategoriaUseCase(this._repo, this._state);

  Future<void> obterCategorias() async {
    List<Categoria> categorias = await _repo.obterCategorias();
    _state.categoriasPorNumero.clear();
    for (Categoria categoria in categorias) {
      _state.categoriasPorNumero[categoria.numero] = categoria;
    }
  }

  void selecionarCategoria(Categoria? categoria) {
    _state.categoriaSelecionada = categoria;
  }
}
