import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';

abstract class EnderecoRepo {
  Future<Endereco?> obterEndereco();

  Future<void> atualizarEndereco(Endereco endereco);

  Future<List<Municipio>> obterMunicipios(UF uf, [String? pesquisa]);
}
