import 'package:leituramiga/repo/categoria.repo.dart';
import 'package:leituramiga/repo/comentario.repo.dart';
import 'package:leituramiga/repo/endereco.repo.dart';
import 'package:leituramiga/repo/instituicao_ensino.repo.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:leituramiga/service/sessao.service.dart';
import 'package:leituramiga/service/solicitacao.service.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/categoria_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/comentario_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/endereco_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/instituicao_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/livro_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/notificacao_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/solicitacao_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/api/usuario_api.repo.dart';
import 'package:projeto_leituramiga/infrastructure/service/api/autenticacao_api.service.dart';
import 'package:projeto_leituramiga/infrastructure/service/api/solicitacao_api.service.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/sessao_flutter.service.dart';

class AppModule {
  static AutenticacaoService get autenticacaoService => AutenticacaoApiService.instancia;

  static SessaoService get sessaoService => SessaoFlutterService.instancia;

  static UsuarioRepo get usuarioRepo => UsuarioApiRepo.instancia;

  static CategoriaRepo get categoriaRepo => CategoriaApiRepo.instancia;

  static ComentarioRepo get comentarioRepo => ComentarioApiRepo.instancia;

  static InstituicaoEnsinoRepo get instituicaoEnsinoRepo => InstituicaoApiRepo.instancia;

  static LivroApiRepo get livroRepo => LivroApiRepo.instancia;

  static SolicitacaoRepo get solicitacaoRepo => SolicitacaoApiRepo.instancia;

  static SolicitacaoService get solicitacaoService => SolicitacaoApiService.instancia;

  static EnderecoRepo get enderecoRepo => EnderecoApiRepo.instancia;

  static NotificacaoRepo get notificacaoRepo => NotificacaoApiRepo.instancia;
}
