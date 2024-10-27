import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/super/entidade.dart';

class ComentarioPerfil extends Entidade {
  final int? _numero;
  final String _emailUsuarioCriador;
  final String _emailUsuarioPerfil;
  final String? _nomeUsuarioCriador;
  final String _comentario;
  final DataHora? _dataCriacao;

  ComentarioPerfil.carregar(
    this._numero,
    this._emailUsuarioCriador,
    this._comentario,
    this._nomeUsuarioCriador,
    this._emailUsuarioPerfil,
    this._dataCriacao,
  );

  ComentarioPerfil.criar(
    this._emailUsuarioCriador,
    this._emailUsuarioPerfil,
    this._comentario,
  )   : _numero = null,
        _nomeUsuarioCriador = null,
        _dataCriacao = null;

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
    String dataCriacao = "${mapa["dataCriacao"]} ${mapa["horaCriacao"]}";
    return ComentarioPerfil.carregar(
      mapa['codigoComentario'],
      mapa['emailUsuarioCriador'],
      mapa['descricao'],
      mapa['nomeUsuarioCriador'],
      mapa['emailUsuarioPerfil'],
      mapa['dataCriacao'] != null ? DataHora.deString(dataCriacao) : null,
    );
  }

  String get comentario => _comentario;

  String get emailUsuarioCriador => _emailUsuarioCriador;

  int? get numero => _numero;

  String get nomeUsuarioCriador => _nomeUsuarioCriador ?? "";

  String get emailUsuarioPerfil => _emailUsuarioPerfil;

  DataHora? get dataCriacao => _dataCriacao;
}
