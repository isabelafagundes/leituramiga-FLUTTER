import 'package:leituramiga/domain/usuario/email.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/usuario/telefone.dart';

class Usuario extends Entidade {
  final int? _numero;
  final String _nome;
  final String _nomeUsuario;
  final Email _email;
  final Telefone? _telefone;
  final int _numeroDeLivros;
  final String? _descricao;
  final InstituicaoDeEnsino _instituicaoDeEnsino;
  final int _numeroEndereco;

  Usuario.criar(
    this._nome,
    this._nomeUsuario,
    this._email,
    this._telefone,
    this._numeroDeLivros,
    this._descricao,
    this._instituicaoDeEnsino,
    this._numeroEndereco,
  ) : _numero = null;

  Usuario.carregar(
    this._numero,
    this._nome,
    this._nomeUsuario,
    this._email,
    this._telefone,
    this._numeroDeLivros,
    this._descricao,
    this._instituicaoDeEnsino,
    this._numeroEndereco,
  );

  int? get numero => _numero;

  @override
  String get id => _numero!.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get nome => _nome;

  String get nomeUsuario => _nomeUsuario;

  Email get email => _email;

  Telefone? get telefone => _telefone;

  int get numeroDeLivros => _numeroDeLivros;

  String? get descricao => _descricao;

  InstituicaoDeEnsino get instituicaoDeEnsino => _instituicaoDeEnsino;

  int get numeroEndereco => _numeroEndereco;
}
