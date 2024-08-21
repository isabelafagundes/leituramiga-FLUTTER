import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';

abstract class UsuarioRepo {
  Future<List<ResumoUsuario>> obterUsuarios([
    int numeroPagina = 0,
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    String? pesquisa,
  ]);

  Future<Usuario> obterUsuario(int numeroUsuario);

  Future<void> excluirUsuario(int numero);

  Future<void> atualizarUsuario(Usuario usuario);
}
