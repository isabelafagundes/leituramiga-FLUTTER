import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/usuario/resumo_usuario.dart';

class ResumoLivro extends Entidade {
  final int _numero;
  final String _nomeUsuario;
  final int _numeroUsuario;
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
    this._numeroUsuario,
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
      resumoLivroAsMap['numero'],
      resumoLivroAsMap['nomeCategoria'],
      resumoLivroAsMap['nomeUsuario'],
      resumoLivroAsMap['numeroUsuario'],
      resumoLivroAsMap['nomeInstituicao'],
      resumoLivroAsMap['nomeMunicipio'],
      resumoLivroAsMap['descricao'],
      resumoLivroAsMap['nomeLivro'],
      resumoLivroAsMap['nomeAutor'],
    );
  }

  String get nomeUsuario => _nomeUsuario;

  int get numeroUsuario => _numeroUsuario;

  String get nomeInstituicao => _nomeInstituicao;

  String get nomeCategoria => _nomeCategoria;

  String get nomeMunicipio => _nomeMunicipio;

  String get nomeLivro => _nomeLivro;

  String get descricao => _descricao;

  String get nomeAutor => _nomeAutor;
}
