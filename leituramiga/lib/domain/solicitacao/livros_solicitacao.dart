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

  factory LivrosSolicitacao.carregarDeMapa(List<dynamic> livros, Map<String, dynamic> mapa, String email) {
    return LivrosSolicitacao.carregar(
      mapa['codigoSolicitacao'],
      email,
      livros.map((livro) => LivroSolicitacao.carregarDeMapa(livro as Map<String, dynamic>)).toList(),
    );
  }

  List<Map<String, dynamic>> paraMapa() {
    return _livros.map((livro) => livro.paraMapaLivro(emailUsuario)).toList();
  }

  List<LivroSolicitacao> get livros => _livros;

  String get emailUsuario => _emailUsuario;

  int get numeroSolicitacao => _numeroSolicitacao;
}
