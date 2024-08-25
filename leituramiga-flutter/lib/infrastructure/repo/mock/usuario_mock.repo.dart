import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/usuario/email.dart';
import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';

class UsuarioMockRepo extends UsuarioRepo {
  List<ResumoUsuario> usuarios = [
    ResumoUsuario.carregar(
      1,
      "Isabela Fagundes",
      "isabela",
      "Fatec Santana de Parnaíba",
      "Cajamar",
      4,
    ),
    ResumoUsuario.carregar(
      2,
      "Kaua Guedes",
      "kauaguedes",
      "Fatec Santana de Parnaíba",
      "Cajamar",
      5,
    ),
    ResumoUsuario.carregar(
      3,
      "João da Silva",
      "joao",
      "UNIP Alphaville",
      "Cajamar",
      3,
    ),
    ResumoUsuario.carregar(
      4,
      "Maria da Silva",
      "maria",
      "UNINOVE Vila Maria",
      "Cajamar",
      2,
    ),
  ];

  Usuario get usuario => Usuario.carregar(
        1,
        "Isabela Fagundes",
        "isabela",
        Email.criar("isabela@gmail.com"),
        null,
        5,
        "Sou estudante de ADS e tenho interesse em engenharia de software.",
        InstituicaoDeEnsino.carregar(1, "FATEC", "FATEC Santana de Parnaíba"),
        1,
        "Cajamar",
      );

  @override
  Future<void> atualizarUsuario(Usuario usuario) {
    // TODO: implement atualizarUsuario
    throw UnimplementedError();
  }

  @override
  Future<void> excluirUsuario(int numero) {
    // TODO: implement excluirUsuario
    throw UnimplementedError();
  }

  @override
  Future<Usuario> obterUsuario(int numeroUsuario) async {
    return Future.delayed(Duration(seconds: 1), () => usuario);
  }

  @override
  Future<List<ResumoUsuario>> obterUsuarios([
    int numeroPagina = 0,
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    String? pesquisa,
  ]) {
    return Future.value(usuarios);
  }
}
