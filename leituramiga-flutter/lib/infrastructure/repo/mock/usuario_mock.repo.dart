import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/usuario/email.dart';
import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';

class UsuarioMockRepo extends UsuarioRepo {
  List<ResumoUsuario> usuarios = [
    ResumoUsuario.carregar(
      "Isabela Fagundes",
      "isabela",
      "Fatec Santana de Parnaíba",
      "Cajamar",
      4,
      "isabela@gmail.com",
      null,
    ),
    ResumoUsuario.carregar(
        "Kaua Guedes", "kauaguedes", "Fatec Santana de Parnaíba", "Cajamar", 5, "kaua@gmail.com", null),
    ResumoUsuario.carregar("João da Silva", "joao", "UNIP Alphaville", "Cajamar", 3, "joao@gmail.com", null),
    ResumoUsuario.carregar("Maria da Silva", "maria", "UNINOVE Vila Maria", "Cajamar", 2, "maria@gmail.com", null),
  ];

  Usuario get usuario => Usuario.carregar(
        "Isabela Fagundes",
        "isabela",
        Email.criar("isabela@gmail.com"),
        null,
        5,
        "Sou estudante de ADS e tenho interesse em engenharia de software.",
        InstituicaoDeEnsino.carregar(1, "FATEC", "FATEC Santana de Parnaíba"),
        1,
        "Cajamar",
        "",
        null,
      );

  @override
  Future<void> atualizarUsuario(Usuario usuario) {
    // TODO: implement atualizarUsuario
    throw UnimplementedError();
  }

  @override
  Future<void> desativarUsuario() async {
    // TODO: implement excluirUsuario
    throw UnimplementedError();
  }

  @override
  Future<Usuario> obterUsuario(String emailUsuario) async {
    return Future.delayed(Duration(seconds: 1), () => usuario);
  }

  @override
  Future<Usuario> obterUsuarioPerfil() {
    // TODO: implement obterUsuarioPerfil
    throw UnimplementedError();
  }

  @override
  Future<List<ResumoUsuario>> obterUsuarios(
      {int numeroPagina = 0, int limite = 18, int? numeroMunicipio, int? numeroInstituicao, String? pesquisa}) {
    // TODO: implement obterUsuarios
    throw UnimplementedError();
  }

  @override
  Future<String> obterIdentificadorUsuario(String login) {
    // TODO: implement obterIdentificadorUsuario
    throw UnimplementedError();
  }
}
