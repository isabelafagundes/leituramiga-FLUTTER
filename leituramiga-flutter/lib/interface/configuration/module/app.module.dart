import 'package:leituramiga/repo/categoria.repo.dart';
import 'package:leituramiga/repo/comentario.repo.dart';
import 'package:leituramiga/repo/endereco.repo.dart';
import 'package:leituramiga/repo/instituicao_ensino.repo.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/service/autenticacao.service.dart';
import 'package:leituramiga/service/sessao.service.dart';
import 'package:leituramiga/service/solicitacao.service.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/categoria_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/comentario_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/instituicao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/notificacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/sessao_flutter.service.dart';
import 'package:projeto_leituramiga/infrastructure/service/mock/autenticacao_mock.service.dart';
import 'package:projeto_leituramiga/infrastructure/service/mock/solicitacao_mock.service.dart';

class AppModule {
  static AutenticacaoService get autenticacaoService => AutenticacaoMockService.instancia;

  static SessaoService get sessaoService => SessaoFlutterService.instancia;

  static UsuarioRepo get usuarioRepo => UsuarioMockRepo.instancia;

  static CategoriaRepo get categoriaRepo => CategoriaMockRepo.instancia;

  static ComentarioRepo get comentarioRepo => ComentarioMockRepo.instancia;

  static InstituicaoEnsinoRepo get instituicaoEnsinoRepo => InstituicaoMockRepo.instancia;

  static LivroRepo get livroRepo => LivroMockRepo.instancia;

  static SolicitacaoRepo get solicitacaoRepo => SolicitacaoMockRepo.instancia;

  static SolicitacaoService get solicitacaoService => SolicitacaoMockService.instancia;

  static EnderecoRepo get enderecoRepo => EnderecoMockRepo.instancia;

  static NotificacaoRepo get notificacaoRepo => NotificacaoMockRepo.instancia;
}
