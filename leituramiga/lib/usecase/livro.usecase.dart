import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:leituramiga/state/livro.state.dart';

class LivroUseCase {
  final LivroRepo _repo;
  final LivroState _state;

  const LivroUseCase(this._repo, this._state);

  Future<void> atualizarLivro() async {
    if (_state.livroEdicao == null) return;
    await _repo.atualizarLivro(_state.livroEdicao!);
  }
  
  void salvarLivroMemoria(Livro livro) {
    _state.livroEdicao = livro;
  }

  Future<void> excluirLivro(int numero) async {
    await _repo.deletarLivro(numero);
  }

  Future<void> obterLivro(int numero) async {
    Livro livro = await _repo.obterLivro(numero);
    _state.livroSelecionado = livro;
  }

  void selecionarCategoria(Categoria categoria) {
    _state.categoriaSelecionada = categoria;
  }
}
