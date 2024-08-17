import 'package:leituramiga/dominio/uf.dart';

class Cidade {
  final int _numero;
  final String _descricao;
  final UF _uf;
  final String? _codigoIbge;

  Cidade.carregar(this._numero, this._descricao, this._uf, this._codigoIbge);

  String? get codigoIbge => _codigoIbge;

  UF get uf => _uf;

  String get descricao => _descricao;

  int get numero => _numero;
}
