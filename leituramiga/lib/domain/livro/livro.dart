import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';

class Livro extends Entidade {
  final int? _numero;
  final String _nome;
  final String _nomeAutor;
  final String _descricao;
  final String _descricaoEstado;
  final int _numeroCategoria;
  final String _nomeUsuario;
  final String _nomeInstituicao;
  final String _nomeMunicipio;
  final List<TipoSolicitacao> _tiposSolicitacao;
  final String _emailUsuario;
  final DataHora? _dataCriacao;
  final DataHora? _dataUltimaSolicitacao;
  final TipoStatusLivro _status;

  Livro.carregar(
    this._numero,
    this._nome,
    this._nomeAutor,
    this._descricao,
    this._descricaoEstado,
    this._numeroCategoria,
    this._tiposSolicitacao,
    this._emailUsuario,
    this._dataCriacao,
    this._dataUltimaSolicitacao,
    this._status,
    this._nomeUsuario,
    this._nomeInstituicao,
    this._nomeMunicipio,
  );

  int? get numero => _numero;

  DataHora? get dataCriacao => _dataCriacao;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      "codigoLivro": _numero,
      "titulo": _nome,
      "autor": _nomeAutor,
      "descricao": _descricao,
      "estadoFisico": _descricaoEstado,
      "codigoCategoria": _numeroCategoria,
      "tipoSolicitacao": _tiposSolicitacao.join(","),
      "emailUsuario": _emailUsuario,
      "dataCriacao": _dataCriacao?.formatar(),
      "dataUltimaSolicitacao": _dataUltimaSolicitacao?.formatar(),
      "codigoStatusLivro": _status.id,
      "nomeUsuario": _nomeUsuario,
      "nomeInstituicao": _nomeInstituicao,
      "nomeCidade": _nomeMunicipio,
    };
  }

  factory Livro.carregarDeMapa(Map<String, dynamic> livroAsMap) {
    return Livro.carregar(
      livroAsMap['codigoLivro'],
      livroAsMap['titulo'],
      livroAsMap['autor'],
      livroAsMap['descricao'],
      livroAsMap['estadoFisico'],
      livroAsMap['codigoCategoria'],
      livroAsMap['tipoSolicitacao'].toString().split(",").map((e) => TipoSolicitacao.deNumero(int.parse(e))).toList(),
      livroAsMap['emailUsuario'],
      livroAsMap['dataCriacao'] == null ? null : DataHora.criar(livroAsMap['dataCriacao']),
      livroAsMap['dataUltimaSolicitacao'] == null ? null : DataHora.criar(livroAsMap['dataUltimaSolicitacao']),
      TipoStatusLivro.obterDeNumero(livroAsMap['codigoStatusLivro']),
      livroAsMap['nomeUsuario'],
      livroAsMap['nomeInstituicao'],
      livroAsMap['nomeCidade'],
    );
  }

  String get nome => _nome;

  String get nomeAutor => _nomeAutor;

  String get descricao => _descricao;

  String get descricaoEstado => _descricaoEstado;

  int get numeroCategoria => _numeroCategoria;

  List<TipoSolicitacao> get tiposSolicitacao => _tiposSolicitacao;

  String get emailUsuario => _emailUsuario;

  DataHora? get dataUltimaSolicitacao => _dataUltimaSolicitacao;

  TipoStatusLivro get status => _status;

  String get nomeUsuario => _nomeUsuario;

  String get nomeMunicipio => _nomeMunicipio;

  String get nomeInstituicao => _nomeInstituicao;
}
