import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/usuario/email.dart';
import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';

class UsuarioMockRepo extends UsuarioRepo {
  static UsuarioMockRepo? _instancia;

  UsuarioMockRepo._();

  static UsuarioMockRepo get instancia {
    _instancia ??= UsuarioMockRepo._();
    return _instancia!;
  }

  final Map<String, Usuario> _usuariosPorEmail = {
    'isabela@gmail.com': Usuario.carregar(
      'Isabela Fagundes',
      'isabela',
      Email.criar('isabela@gmail.com'),
      null,
      5,
      'Sou estudante de ADS e tenho interesse em engenharia de software.',
      InstituicaoDeEnsino.carregar(1, 'FATEC', 'FATEC Santana de Parnaiba'),
      1,
      'Cajamar',
      null,
      EnderecoMockRepo.instancia.obterEnderecoPorEmail('isabela@gmail.com'),
    ),
    'kaua@gmail.com': Usuario.carregar(
      'Kaua Guedes',
      'kauaguedes',
      Email.criar('kaua@gmail.com'),
      null,
      4,
      'Leitor de ficcao cientifica.',
      InstituicaoDeEnsino.carregar(1, 'FATEC', 'FATEC Santana de Parnaiba'),
      2,
      'Santana de Parnaiba',
      null,
      EnderecoMockRepo.instancia.obterEnderecoPorEmail('kaua@gmail.com'),
    ),
    'joao@gmail.com': Usuario.carregar(
      'Joao da Silva',
      'joao_silva',
      Email.criar('joao@gmail.com'),
      null,
      3,
      'Gosto de classicos.',
      InstituicaoDeEnsino.carregar(7, 'UNIP', 'Universidade Paulista'),
      3,
      'Sao Paulo',
      null,
      EnderecoMockRepo.instancia.obterEnderecoPorEmail('joao@gmail.com'),
    ),
    'maria@gmail.com': Usuario.carregar(
      'Maria da Silva',
      'mariazinha',
      Email.criar('maria@gmail.com'),
      null,
      2,
      'Amo romance e poesia.',
      InstituicaoDeEnsino.carregar(13, 'UNINOVE', 'Universidade Nove de Julho'),
      4,
      'Sao Caetano do Sul',
      null,
      EnderecoMockRepo.instancia.obterEnderecoPorEmail('maria@gmail.com'),
    ),
    'ana@gmail.com': Usuario.carregar(
      'Ana Beatriz',
      'anabia',
      Email.criar('ana@gmail.com'),
      null,
      6,
      'Leio fantasia e desenvolvimento pessoal.',
      InstituicaoDeEnsino.carregar(5, 'USP', 'Universidade de Sao Paulo'),
      5,
      'Sao Carlos',
      null,
      EnderecoMockRepo.instancia.obterEnderecoPorEmail('ana@gmail.com'),
    ),
    'pedro@gmail.com': Usuario.carregar(
      'Pedro Henrique',
      'pedroh',
      Email.criar('pedro@gmail.com'),
      null,
      7,
      'Curto tecnologia, biografias e historia.',
      InstituicaoDeEnsino.carregar(9, 'ETEC', 'ETEC Vasco Antonio Venchiarutti'),
      6,
      'Jundiai',
      null,
      EnderecoMockRepo.instancia.obterEnderecoPorEmail('pedro@gmail.com'),
    ),
    'beatriz@gmail.com': Usuario.carregar(
      'Beatriz Souza',
      'biareads',
      Email.criar('beatriz@gmail.com'),
      null,
      8,
      'Apaixonada por suspense e thriller psicologico.',
      InstituicaoDeEnsino.carregar(11, 'UNIFESP', 'Universidade Federal de Sao Paulo'),
      7,
      'Osasco',
      null,
      EnderecoMockRepo.instancia.obterEnderecoPorEmail('beatriz@gmail.com'),
    ),
  };

  final Set<String> _usuariosDesativados = {};

  @override
  Future<void> atualizarUsuario(Usuario usuario) async {
    String email = usuario.email.endereco.toLowerCase();

    if (usuario.senha != null) {
      if (possuiIdentificador(usuario.nomeUsuario, email)) throw UsuarioJaExiste();
      _usuariosPorEmail[email] = usuario;
      AutenticacaoState.instancia.atualizarCriacaoUsuarioToken(
        'mock_criacao_usuario_${DateTime.now().millisecondsSinceEpoch}',
      );
      return;
    }

    if (!_usuariosPorEmail.containsKey(email)) throw UsuarioNaoEncontrado();
    _usuariosPorEmail[email] = usuario;
  }

  @override
  Future<void> desativarUsuario() async {
    Usuario? autenticado = AutenticacaoState.instancia.usuario;
    if (autenticado == null) throw UsuarioNaoEncontrado();

    String email = autenticado.email.endereco.toLowerCase();
    if (!_usuariosPorEmail.containsKey(email)) throw UsuarioNaoEncontrado();

    _usuariosDesativados.add(email);
  }

  @override
  Future<Usuario> obterUsuario(String emailUsuario) async {
    Usuario usuario = obterUsuarioPorIdentificador(emailUsuario);
    if (_usuariosDesativados.contains(usuario.email.endereco.toLowerCase())) throw UsuarioNaoAtivo();
    return usuario;
  }

  @override
  Future<Usuario> obterUsuarioPerfil() async {
    Usuario? autenticado = AutenticacaoState.instancia.usuario;
    if (autenticado != null) {
      return obterUsuario(autenticado.email.endereco);
    }

    return obterUsuario('isabela@gmail.com');
  }

  @override
  Future<List<ResumoUsuario>> obterUsuarios({
    int numeroPagina = 0,
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    String? pesquisa,
  }) async {
    Iterable<Usuario> usuarios = _usuariosPorEmail.values.where(
      (usuario) => !_usuariosDesativados.contains(usuario.email.endereco.toLowerCase()),
    );

    if (numeroInstituicao != null) {
      usuarios = usuarios.where((usuario) => usuario.instituicaoDeEnsino?.numero == numeroInstituicao);
    }

    if (numeroMunicipio != null) {
      String? nomeMunicipio = EnderecoMockRepo.instancia.municipios
          .where((municipio) => municipio.numero == numeroMunicipio)
          .firstOrNull
          ?.nome;
      if (nomeMunicipio != null) {
        usuarios = usuarios.where((usuario) => usuario.nomeMunicipio == nomeMunicipio);
      }
    }

    if (pesquisa != null && pesquisa.trim().isNotEmpty) {
      String termo = pesquisa.trim().toLowerCase();
      usuarios = usuarios.where((usuario) {
        return usuario.nome.toLowerCase().contains(termo) ||
            usuario.nomeUsuario.toLowerCase().contains(termo) ||
            usuario.email.endereco.toLowerCase().contains(termo);
      });
    }

    List<ResumoUsuario> resumos = usuarios.map(_paraResumo).toList();

    int inicio = numeroPagina * limite;
    if (inicio >= resumos.length) return [];

    int fim = inicio + limite;
    if (fim > resumos.length) fim = resumos.length;

    return resumos.sublist(inicio, fim);
  }

  @override
  Future<String> obterIdentificadorUsuario(String login) async {
    Usuario usuario = obterUsuarioPorIdentificador(login, ignorarDesativado: true);
    return usuario.email.endereco;
  }

  bool possuiIdentificador(String username, String email) {
    String usernameNormalizado = username.trim().toLowerCase();
    String emailNormalizado = email.trim().toLowerCase();

    return _usuariosPorEmail.values.any(
      (usuario) =>
          usuario.email.endereco.toLowerCase() == emailNormalizado ||
          usuario.nomeUsuario.toLowerCase() == usernameNormalizado,
    );
  }

  bool existePorEmail(String email) {
    return _usuariosPorEmail.containsKey(email.trim().toLowerCase());
  }

  bool estaDesativado(String email) {
    return _usuariosDesativados.contains(email.trim().toLowerCase());
  }

  String obterEmailPorIdentificador(String identificador) {
    return obterUsuarioPorIdentificador(identificador, ignorarDesativado: true).email.endereco;
  }

  Usuario obterUsuarioPorIdentificador(String identificador, {bool ignorarDesativado = false}) {
    String login = identificador.trim().toLowerCase();

    Usuario? usuario;
    if (login.contains('@')) {
      usuario = _usuariosPorEmail[login];
    } else {
      usuario = _usuariosPorEmail.values.where((item) => item.nomeUsuario.toLowerCase() == login).firstOrNull;
    }

    if (usuario == null) throw UsuarioNaoEncontrado();

    if (!ignorarDesativado && _usuariosDesativados.contains(usuario.email.endereco.toLowerCase())) {
      throw UsuarioNaoAtivo();
    }

    return usuario;
  }

  ResumoUsuario _paraResumo(Usuario usuario) {
    return ResumoUsuario.carregar(
      usuario.nome,
      usuario.nomeUsuario,
      usuario.nomeInstituicao,
      usuario.nomeMunicipio,
      usuario.numeroDeLivros,
      usuario.email.endereco,
      usuario.imagem,
    );
  }
}
