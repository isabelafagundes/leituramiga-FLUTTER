import 'package:leituramiga/domain/super/entidade.dart';

class ComentarioPerfil extends Entidade {
  final int _numero;
  final String _emailUsuarioCriador;
  final String _emailUsuarioPerfil;
  final String _nomeUsuarioCriador;
  final String _comentario;

  ComentarioPerfil.carregar(
    this._numero,
    this._emailUsuarioCriador,
    this._comentario,
    this._nomeUsuarioCriador,
    this._emailUsuarioPerfil,
  );

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      'codigoComentario': _numero,
      'emailUsuarioCriador': _emailUsuarioCriador,
      'emailUsuarioPerfil': _emailUsuarioPerfil,
      'descricao': _comentario,
      'nomeUsuarioCriador': _nomeUsuarioCriador,
    };
  }

  factory ComentarioPerfil.carregarDeMapa(Map<String, dynamic> mapa) {
    return ComentarioPerfil.carregar(
      mapa['codigoComentario'],
      mapa['emailUsuarioCriador'],
      mapa['descricao'],
      mapa['nomeUsuarioCriador'],
      mapa['emailUsuarioPerfil'],
    );
  }

  String get comentario => _comentario;

  String get emailUsuarioCriador => _emailUsuarioCriador;

  int get numero => _numero;

  String get nomeUsuarioCriador => _nomeUsuarioCriador;

  String get emailUsuarioPerfil => _emailUsuarioPerfil;
}
