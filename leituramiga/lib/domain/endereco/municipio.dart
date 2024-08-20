import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/endereco/uf.dart';

class Municipio extends Entidade {
  final int _numero;
  final String _nome;
  final UF _estado;

  Municipio.carregar(
    this._numero,
    this._nome,
    this._estado,
  );

  int get numero => _numero;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  String get nome => _nome;

  UF get estado => _estado;
}
