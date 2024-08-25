import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';

mixin class EnderecoState {
  Endereco? enderecoEdicao;
  Map<int, Municipio> municipiosPorNumero = {};
}
