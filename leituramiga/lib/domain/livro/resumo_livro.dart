import 'package:leituramiga/domain/super/entidade.dart';

class ResumoLivro extends Entidade {
  final int _numero;
  final String _nomeUsuario;
  final String _nomeAutor;
  final String _nomeInstituicao;
  final String _nomeMunicipio;
  final String _nomeCategoria;
  final String _descricao;
  final String _nomeLivro;

  ResumoLivro.carregar(
    this._numero,
    this._nomeCategoria,
    this._nomeUsuario,
    this._nomeInstituicao,
    this._nomeMunicipio,
    this._descricao,
    this._nomeLivro,
    this._nomeAutor,
  );

  int get numero => _numero;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  factory ResumoLivro.carregarDeMapa(Map<String, dynamic> resumoLivroAsMap) {
    return ResumoLivro.carregar(
      resumoLivroAsMap['codigoLivro'],
      resumoLivroAsMap['categoria'],
      resumoLivroAsMap['nomeUsuario'],
      resumoLivroAsMap['nomeInstituicao'],
      resumoLivroAsMap['nomeCidade'],
      resumoLivroAsMap['descricao'],
      resumoLivroAsMap['titulo'],
      resumoLivroAsMap['autor'],
    );
  }

  String get nomeUsuario => _nomeUsuario;

  String get nomeInstituicao => _nomeInstituicao;

  String get nomeCategoria => _nomeCategoria;

  String get nomeMunicipio => _nomeMunicipio;

  String get nomeLivro => _nomeLivro;

  String get descricao => _descricao;

  String get nomeAutor => _nomeAutor;
}
