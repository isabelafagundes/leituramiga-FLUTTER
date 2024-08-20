import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';

abstract class UsuarioRepo {
  Future<List<ResumoUsuario>> obterUsuarios();

  Future<Usuario> obterUsuario(int numeroUsuario);

  Future<void> excluirUsuario(int numero);

  Future<void> atualizarUsuario(Usuario usuario);
}
