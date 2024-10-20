import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/usuario/email.dart';

class ResumoLivro extends Entidade {
  final int _numero;
  final String _nomeUsuario;
  final String _nomeAutor;
  final String? _nomeInstituicao;
  final String? _nomeMunicipio;
  final String _nomeCategoria;
  final String _descricao;
  final String _nomeLivro;
  final String? _imagem;
  final Email _emailUsuario;
  final List<TipoSolicitacao> _tiposSolicitacao;

  ResumoLivro.carregar(
    this._numero,
    this._nomeCategoria,
    this._nomeUsuario,
    this._nomeInstituicao,
    this._nomeMunicipio,
    this._descricao,
    this._nomeLivro,
    this._nomeAutor,
    this._emailUsuario,
    this._tiposSolicitacao, [
    this._imagem,
  ]);

  int get numero => _numero;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      "codigoLivro": _numero,
      "categoria": _nomeCategoria,
      "nomeUsuario": _nomeUsuario,
      "nomeInstituicao": _nomeInstituicao,
      "nomeCidade": _nomeMunicipio,
      "descricao": _descricao,
      "titulo": _nomeLivro,
      "autor": _nomeAutor,
      "emailUsuario": _emailUsuario.endereco,
      "tipoSolicitacao": _tiposSolicitacao.map((e) => e.id).toList(),
      "imagem": _imagem,
    };
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
      Email.criar(resumoLivroAsMap['emailUsuario']),
      resumoLivroAsMap['tipoSolicitacao'].toString().split(",").map((e) => TipoSolicitacao.deNumero(int.parse(e))).toList(),
      resumoLivroAsMap['imagem'],
    );
  }

  Email get emailUsuario => _emailUsuario;

  String? get imagem => _imagem;

  String get nomeUsuario => _nomeUsuario;

  String? get nomeInstituicao => _nomeInstituicao;

  List<TipoSolicitacao> get tiposSolicitacao => _tiposSolicitacao;

  String get nomeCategoria => _nomeCategoria;

  String? get nomeMunicipio => _nomeMunicipio;

  String get nomeLivro => _nomeLivro;

  String get descricao => _descricao;

  String get nomeAutor => _nomeAutor;
}
