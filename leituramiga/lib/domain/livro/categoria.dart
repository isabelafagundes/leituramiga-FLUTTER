import 'package:leituramiga/domain/super/entidade.dart';

class Categoria extends Entidade {
  final int _numero;
  final String _descricao;

  Categoria.carregar(this._numero, this._descricao);

  @override
  String get id => _numero.toString();

  int get numero => _numero;

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get descricao => _descricao;
}
