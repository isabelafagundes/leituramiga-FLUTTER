import 'package:leituramiga/domain/super/entidade.dart';

class ResumoUsuario extends Entidade {
  final int _numero;
  final String _nome;
  final String _nomeUsuario;
  final String _nomeInstituicao;
  final String _nomeMunicipio;
  final int _quantidadeLivros;

  ResumoUsuario.carregar(
    this._numero,
    this._nome,
    this._nomeUsuario,
    this._nomeInstituicao,
    this._nomeMunicipio,
    this._quantidadeLivros,
  );

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }
}
