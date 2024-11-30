import 'package:leituramiga/domain/super/entidade.dart';

class ResumoUsuario extends Entidade implements Comparable {
  final String _email;
  final String _nome;
  final String _nomeUsuario;
  final String? _nomeInstituicao;
  final String? _nomeMunicipio;
  final int _quantidadeLivros;
  final String? _imagem;

  ResumoUsuario.carregar(
    this._nome,
    this._nomeUsuario,
    this._nomeInstituicao,
    this._nomeMunicipio,
    this._quantidadeLivros,
    this._email,
    this._imagem,
  );

  @override
  String get id => _email.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      "email": _email,
      "nome": _nome,
      "nomeUsuario": _nomeUsuario,
      "nomeInstituicao": _nomeInstituicao,
      "nomeMunicipio": _nomeMunicipio,
      "quantidadeLivros": _quantidadeLivros,
      "imagem": _imagem,
    };
  }

  factory ResumoUsuario.carregarDeMapa(Map<String, dynamic> usuarioAsMap) {
    return ResumoUsuario.carregar(
      usuarioAsMap["nome"],
      usuarioAsMap["username"],
      usuarioAsMap["nomeInstituicao"],
      usuarioAsMap["nomeCidade"],
      usuarioAsMap["quantidadeLivros"],
      usuarioAsMap["email"],
      usuarioAsMap["imagem"],
    );
  }

  int get quantidadeLivros => _quantidadeLivros;

  String? get nomeMunicipio => _nomeMunicipio;

  String? get nomeInstituicao => _nomeInstituicao;

  String get nomeUsuario => _nomeUsuario;

  String get nome => _nome;

  String get email => _email;

  @override
  int compareTo(other) {
    if (other is ResumoUsuario) {
      return _nome.compareTo(other.nome);
    }
    return 0;
  }

  @override
  bool operator ==(Object other) {
    if (other is ResumoUsuario) {
      return _email == other._email;
    }
    return false;
  }

  hashcode() {
    return _email.hashCode;
  }

  String? get imagem => _imagem;
}
