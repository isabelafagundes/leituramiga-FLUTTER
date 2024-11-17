import 'package:leituramiga/domain/usuario/usuario_autenticado.dart';

abstract class AutenticacaoService {
  Future<UsuarioAutenticado> logar(String email, String senha);

  Future<UsuarioAutenticado?> atualizarTokens();

  Future<void> desativar();

  Future<void> verificarCodigoSeguranca(String codigo, String email);

  Future<void> verificarCodigoRecuperacao(String codigo, String email);

  Future<void> enviarCodigoCriacaoUsuario(String email);

  Future<void> enviarCodigoRecuperacaoSenha(String email);

  Future<void> atualizarSenha(String email, String senha);

  Future<void> iniciarRecuperacaoSenha(String email);

  Future<void> validarIdentificador(String username, String email);
}
