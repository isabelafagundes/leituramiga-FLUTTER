import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:leituramiga/service/sessao.service.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/usuario_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/service/api/autenticacao_api.service.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/sessao_flutter.service.dart';

class AppModule {

  static AutenticacaoService get autenticacaoService => AutenticacaoApiService.instancia;

  static SessaoService get sessaoService => SessaoFlutterService.instancia;

  static UsuarioRepo get usuarioRepo => UsuarioApiRepo.instancia;


}