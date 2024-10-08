import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';

class LivrosSolicitacao {
  final int _numeroSolicitacao;
  final String _emailUsuario;
  List<LivroSolicitacao> _livros;

  LivrosSolicitacao.carregar(
    this._numeroSolicitacao,
    this._emailUsuario,
    this._livros,
  );

  void adicionar(Livro livro) {
    LivroSolicitacao resumo = LivroSolicitacao.criarDeLivro(livro);
    _livros.add(resumo);
  }

  List<LivroSolicitacao> get livros => _livros;

  String get emailUsuario => _emailUsuario;

  int get numeroSolicitacao => _numeroSolicitacao;
}
