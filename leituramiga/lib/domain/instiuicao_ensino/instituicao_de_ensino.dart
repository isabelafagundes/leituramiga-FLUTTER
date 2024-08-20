import 'package:leituramiga/domain/super/entidade.dart';

class InstituicaoDeEnsino extends Entidade {
  final int _numero;
  final String _sigla;
  final String _nome;

  InstituicaoDeEnsino.carregar(this._numero, this._sigla, this._nome);

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get nome => _nome;

  String get sigla => _sigla;

  int get numero => _numero;
}
