import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/repo/endereco.repo.dart';

class EnderecoMockRepo extends EnderecoRepo {
  static EnderecoMockRepo? _instancia;

  EnderecoMockRepo._();

  static EnderecoMockRepo get instancia {
    _instancia ??= EnderecoMockRepo._();
    return _instancia!;
  }

  final List<Municipio> municipios = [
    Municipio.carregar(1, 'Cajamar', UF.SP),
    Municipio.carregar(2, 'Santana de Parnaiba', UF.SP),
    Municipio.carregar(3, 'Sao Paulo', UF.SP),
    Municipio.carregar(4, 'Sao Caetano do Sul', UF.SP),
    Municipio.carregar(5, 'Sao Carlos', UF.SP),
    Municipio.carregar(6, 'Jundiai', UF.SP),
    Municipio.carregar(7, 'Osasco', UF.SP),
    Municipio.carregar(8, 'Santos', UF.SP),
    Municipio.carregar(9, 'Sao Vicente', UF.SP),
    Municipio.carregar(10, 'Sao Jose dos Campos', UF.SP),
    Municipio.carregar(11, 'Sao Bernardo do Campo', UF.SP),
    Municipio.carregar(12, 'Sao Sebastiao', UF.SP),
    Municipio.carregar(13, 'Sao Joao da Boa Vista', UF.SP),
    Municipio.carregar(14, 'Sao Roque', UF.SP),
    Municipio.carregar(15, 'Sao Lourenco da Serra', UF.SP),
    Municipio.carregar(16, 'Sao Miguel Arcanjo', UF.SP),
    Municipio.carregar(17, 'Sao Pedro', UF.SP),
    Municipio.carregar(18, 'Sao Simao', UF.SP),
    Municipio.carregar(19, 'Sao Tome das Letras', UF.MG),
    Municipio.carregar(20, 'Sao Jose do Rio Preto', UF.SP),
  ];

  final Map<String, Endereco> _enderecosPorEmail = {
    'isabela@gmail.com': Endereco.carregar(
      1,
      '123',
      'Casa 2',
      'Rua das Flores',
      '07700000',
      'Jardim das Rosas',
      Municipio.carregar(1, 'Cajamar', UF.SP),
      true,
    ),
    'kaua@gmail.com': Endereco.carregar(
      2,
      '45',
      'Apto 14',
      'Avenida Tenente Marques',
      '06530001',
      'Portal dos Ipes',
      Municipio.carregar(2, 'Santana de Parnaiba', UF.SP),
      true,
    ),
    'joao@gmail.com': Endereco.carregar(
      3,
      '890',
      'Bloco B',
      'Rua Vergueiro',
      '01504001',
      'Liberdade',
      Municipio.carregar(3, 'Sao Paulo', UF.SP),
      true,
    ),
    'maria@gmail.com': Endereco.carregar(
      4,
      '321',
      'Fundos',
      'Alameda Sao Caetano',
      '09560000',
      'Santa Paula',
      Municipio.carregar(4, 'Sao Caetano do Sul', UF.SP),
      true,
    ),
    'ana@gmail.com': Endereco.carregar(
      5,
      '78',
      null,
      'Rua Episcopal',
      '13560049',
      'Centro',
      Municipio.carregar(5, 'Sao Carlos', UF.SP),
      true,
    ),
    'pedro@gmail.com': Endereco.carregar(
      6,
      '1500',
      'Casa',
      'Avenida Nove de Julho',
      '13208056',
      'Anhangabau',
      Municipio.carregar(6, 'Jundiai', UF.SP),
      true,
    ),
    'beatriz@gmail.com': Endereco.carregar(
      7,
      '600',
      'Apto 32',
      'Rua Antonio Agu',
      '06013000',
      'Centro',
      Municipio.carregar(7, 'Osasco', UF.SP),
      true,
    ),
  };

  Endereco get enderecoPadrao => _enderecosPorEmail['isabela@gmail.com']!;

  Endereco? obterEnderecoPorEmail(String email) {
    return _enderecosPorEmail[email.trim().toLowerCase()];
  }

  Future<void> atualizarEnderecoPorEmail(String email, Endereco endereco) async {
    String emailNormalizado = email.trim().toLowerCase();
    int numero = endereco.numero ?? ((_enderecosPorEmail[emailNormalizado]?.numero ?? 0) + 1);

    _enderecosPorEmail[emailNormalizado] = Endereco.carregar(
      numero,
      endereco.numeroResidencial,
      endereco.complemento,
      endereco.rua,
      endereco.cep,
      endereco.bairro,
      endereco.municipio,
      endereco.principal,
    );
  }

  @override
  Future<void> atualizarEndereco(Endereco endereco) async {
    _enderecosPorEmail['isabela@gmail.com'] = Endereco.carregar(
      endereco.numero ?? 1,
      endereco.numeroResidencial,
      endereco.complemento,
      endereco.rua,
      endereco.cep,
      endereco.bairro,
      endereco.municipio,
      endereco.principal,
    );
  }

  @override
  Future<Endereco?> obterEndereco() async {
    return enderecoPadrao;
  }

  Future<Endereco?> obterEnderecoDoUsuario(String email) async {
    return obterEnderecoPorEmail(email);
  }

  @override
  Future<List<Municipio>> obterMunicipios(UF uf, [String? pesquisa]) async {
    Iterable<Municipio> filtrados = municipios.where((municipio) => municipio.estado == uf);

    if (pesquisa != null && pesquisa.trim().isNotEmpty) {
      String pesquisaNormalizada = pesquisa.trim().toLowerCase();
      filtrados = filtrados.where(
            (municipio) => municipio.nome.toLowerCase().contains(pesquisaNormalizada),
      );
    }

    return filtrados.toList();
  }

  @override
  Future<void> desativarEndereco(int codigoEndereco) async {
    String? emailEncontrado;
    for (final item in _enderecosPorEmail.entries) {
      if (item.value.numero == codigoEndereco) {
        emailEncontrado = item.key;
        break;
      }
    }

    if (emailEncontrado != null) {
      _enderecosPorEmail.remove(emailEncontrado);
    }
  }
}