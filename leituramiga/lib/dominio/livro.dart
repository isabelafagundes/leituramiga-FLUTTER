import 'package:leituramiga/dominio/super/entidade.dart';
import 'package:leituramiga/dominio/tipo_solicitacao.dart';

class Livro extends Entidade {
  final int _numero;
  final String _nome;
  final String _nomeAutor;
  final int _numeroAutor;
  final String _descricao;
  final String _descricaoEstado;
  final int _numeroCategoria;
  final List<TipoSolicitacao> _tiposSolicitacao;
  final int _numeroUsuario;
  final DateTime _dataCriacao;
  final DateTime? _dataUltimaSolicitacao;

  Livro.carregar(
    this._numero,
    this._nome,
    this._nomeAutor,
    this._numeroAutor,
    this._descricao,
    this._descricaoEstado,
    this._numeroCategoria,
    this._tiposSolicitacao,
    this._numeroUsuario,
    this._dataCriacao,
    this._dataUltimaSolicitacao,
  );

  int get numero => _numero;

  DateTime get dataCriacao => _dataCriacao;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get nome => _nome;

  String get nomeAutor => _nomeAutor;

  int get numeroAutor => _numeroAutor;

  String get descricao => _descricao;

  String get descricaoEstado => _descricaoEstado;

  int get numeroCategoria => _numeroCategoria;

  List<TipoSolicitacao> get tiposSolicitacao => _tiposSolicitacao;

  int get numeroUsuario => _numeroUsuario;

  DateTime? get dataUltimaSolicitacao => _dataUltimaSolicitacao;
}
