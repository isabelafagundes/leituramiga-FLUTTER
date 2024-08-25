import 'package:leituramiga/domain/super/entidade.dart';

class ComentarioPerfil extends Entidade {
  final int _numero;
  final int _numeroUsuarioCriador;
  final int _numeroPerfil;
  final String _nomeUsuarioCriador;
  final String _comentario;

  ComentarioPerfil.carregar(
    this._numero,
    this._numeroUsuarioCriador,
    this._numeroPerfil,
    this._comentario,
    this._nomeUsuarioCriador,
  );

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get comentario => _comentario;

  int get numeroPerfil => _numeroPerfil;

  int get numeroUsuarioCriador => _numeroUsuarioCriador;

  int get numero => _numero;

  String get nomeUsuarioCriador => _nomeUsuarioCriador;
}
