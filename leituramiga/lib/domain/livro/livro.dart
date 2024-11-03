import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/usuario/email.dart';

class Livro extends Entidade {
  final int? _numero;
  final String _nome;
  final String _nomeAutor;
  final String _descricao;
  final String _descricaoEstado;
  final int _numeroCategoria;
  final String _nomeUsuario;
  final String _nomeCategoria;
  final String? _nomeInstituicao;
  final String? _nomeMunicipio;
  final List<TipoSolicitacao> _tiposSolicitacao;
  final String _emailUsuario;
  final DataHora? _dataCriacao;
  final DataHora? _dataUltimaSolicitacao;
  final TipoStatusLivro _status;
  final String? _imagemLivro;

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
    this._nomeCategoria,
    this._imagemLivro,
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
      "tipoSolicitacao": _tiposSolicitacao.map((e) => e.id).toList().join(","),
      "emailUsuario": _emailUsuario,
      "dataCriacao": _dataCriacao?.formatar(),
      "dataUltimaSolicitacao": _dataUltimaSolicitacao?.formatar(),
      "codigoStatusLivro": _status.id,
      "nomeUsuario": _nomeUsuario,
      "nomeInstituicao": _nomeInstituicao,
      "nomeCidade": _nomeMunicipio,
      "nomeCategoria": _nomeCategoria,
      "imagem": _imagemLivro
    };
  }

  ResumoLivro criarResumoLivro() {
    return ResumoLivro.carregar(
      _numero!,
      _nomeCategoria,
      _nomeUsuario,
      _nomeInstituicao ?? '',
      _nomeMunicipio ?? '',
      _descricao,
      _nome,
      _nomeAutor,
      Email.criar(_emailUsuario),
      _tiposSolicitacao,
      _imagemLivro,
    );
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
        null,
        TipoStatusLivro.obterDeNumero(livroAsMap['codigoStatusLivro']),
        livroAsMap['nomeUsuario'],
        livroAsMap['nomeInstituicao'],
        livroAsMap['nomeCidade'],
        livroAsMap['categoria'],
        livroAsMap['imagem']);
  }

  String get nome => _nome;

  String get nomeAutor => _nomeAutor;

  String get descricao => _descricao;

  String get descricaoEstado => _descricaoEstado;

  int get numeroCategoria => _numeroCategoria;

  String get nomeCategoria => _nomeCategoria;

  List<TipoSolicitacao> get tiposSolicitacao => _tiposSolicitacao;

  String get emailUsuario => _emailUsuario;

  DataHora? get dataUltimaSolicitacao => _dataUltimaSolicitacao;

  TipoStatusLivro get status => _status;

  String get nomeUsuario => _nomeUsuario;

  String? get nomeMunicipio => _nomeMunicipio;

  String? get nomeInstituicao => _nomeInstituicao;

  String? get imagemLivro => _imagemLivro;
}
