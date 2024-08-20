import 'package:leituramiga/domain/super/entidade.dart';

class ResumoLivro extends Entidade {
  final int _numero;
  final String _nomeUsuario;
  final int _numeroUsuario;
  final String _nomeInstituicao;
  final String _nomeMunicipio;

  ResumoLivro.carregar(
    this._numero,
    this._nomeUsuario,
    this._numeroUsuario,
    this._nomeInstituicao,
    this._nomeMunicipio,
  );

  int get numero => _numero;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get nomeUsuario => _nomeUsuario;

  int get numeroUsuario => _numeroUsuario;

  String get nomeInstituicao => _nomeInstituicao;

  String get nomeMunicipio => _nomeMunicipio;
}
