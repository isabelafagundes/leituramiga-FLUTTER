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

  factory LivrosSolicitacao.carregarDeMapa(Map<String, dynamic> mapa) {
    return LivrosSolicitacao.carregar(
      mapa['numeroSolicitacao'],
      mapa['emailUsuario'],
      (mapa['livros'] as List).map((livro) => LivroSolicitacao.carregarDeMapa(livro)).toList(),
    );
  }

  Map<String, dynamic> paraMapa() {
    return {
      'numeroSolicitacao': _numeroSolicitacao,
      'emailUsuario': _emailUsuario,
      'livros': _livros.map((livro) => livro.paraMapa()).toList(),
    };
  }

  List<LivroSolicitacao> get livros => _livros;

  String get emailUsuario => _emailUsuario;

  int get numeroSolicitacao => _numeroSolicitacao;
}
