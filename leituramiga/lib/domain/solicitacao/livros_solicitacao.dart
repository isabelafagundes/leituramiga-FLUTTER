import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';

class LivrosSolicitacao {
  final int _numeroSolicitacao;
  final int _numeroUsuario;
  List<LivroSolicitacao> _livros;

  LivrosSolicitacao.carregar(
    this._numeroSolicitacao,
    this._numeroUsuario,
    this._livros,
  );

  void adicionar(Livro livro) {
    LivroSolicitacao resumo = LivroSolicitacao.criarDeLivro(livro);
    _livros.add(resumo);
  }

  List<LivroSolicitacao> get livros => _livros;

  int get numeroUsuario => _numeroUsuario;

  int get numeroSolicitacao => _numeroSolicitacao;
}
