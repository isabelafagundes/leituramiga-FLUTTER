import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/super/entidade.dart';

class LivroSolicitacao extends Entidade {
  final int _numero;
  final String _nome;
  final String _nomeAutor;

  LivroSolicitacao.carregar(
    this._numero,
    this._nome,
    this._nomeAutor,
  );

  factory LivroSolicitacao.criarDeLivro(Livro livro) {
    return LivroSolicitacao.carregar(
      livro.numero,
      livro.nome,
      livro.nomeAutor,
    );
  }

  @override
  String get id => _numero.toString();

  int get numero => _numero;

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get nome => _nome;

  String get nomeAutor => _nomeAutor;
}
