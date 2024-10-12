import 'package:leituramiga/domain/usuario/usuario_autenticado.dart';

abstract class AutenticacaoService {
  Future<UsuarioAutenticado> logar(String email, String senha);

  Future<UsuarioAutenticado?> atualizarTokens();

  Future<void> desativar();

  Future<void> verificarCodigoSeguranca(String codigo, String email);
}
