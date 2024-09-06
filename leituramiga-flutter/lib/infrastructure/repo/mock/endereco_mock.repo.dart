import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/repo/endereco.repo.dart';

class EnderecoMockRepo extends EnderecoRepo {
  List<Municipio> municipios = [
    Municipio.carregar(1, "Cajamar", UF.SP),
    Municipio.carregar(2, "Santana de Parnaíba", UF.SP),
    Municipio.carregar(3, "São Paulo", UF.SP),
    Municipio.carregar(4, "São Caetano do Sul", UF.SP),
    Municipio.carregar(5, "São Carlos", UF.SP),
    Municipio.carregar(6, "Jundiaí", UF.SP),
    Municipio.carregar(7, "Osasco", UF.SP),
    Municipio.carregar(8, "Santos", UF.SP),
    Municipio.carregar(9, "São Vicente", UF.SP),
    Municipio.carregar(10, "São José dos Campos", UF.SP),
    Municipio.carregar(11, "São Bernardo do Campo", UF.SP),
    Municipio.carregar(12, "São Sebastião", UF.SP),
    Municipio.carregar(13, "São João da Boa Vista", UF.SP),
    Municipio.carregar(14, "São Roque", UF.SP),
    Municipio.carregar(15, "São Lourenço da Serra", UF.SP),
    Municipio.carregar(16, "São Miguel Arcanjo", UF.SP),
    Municipio.carregar(17, "São Pedro", UF.SP),
    Municipio.carregar(18, "São Simão", UF.SP),
    Municipio.carregar(19, "São Tomé das Letras", UF.MG),
    Municipio.carregar(20, "São José do Rio Preto", UF.SP),
  ];

  Endereco get endereco => Endereco.carregar(
        1,
        '123',
        "Casa",
        "Rua das Flores",
        "07700000",
        "Jardim das Rosas",
        municipios[0],
      );

  @override
  Future<void> atualizarEndereco(Endereco endereco, int usuario) {
    // TODO: implement atualizarEndereco
    throw UnimplementedError();
  }

  @override
  Future<Endereco> obterEndereco(int numero) {
    // TODO: implement obterEndereco
    throw UnimplementedError();
  }

  @override
  Future<List<Municipio>> obterMunicipios() async {
    return municipios;
  }
}
