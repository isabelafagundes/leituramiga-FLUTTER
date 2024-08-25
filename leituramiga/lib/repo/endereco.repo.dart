import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';

abstract class EnderecoRepo {
  Future<Endereco> obterEndereco(int numero);

  Future<void> atualizarEndereco(Endereco endereco, int usuario);

  Future<List<Municipio>> obterMunicipios();
}
