import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/interface/configuration/guards/usuario_logado.guard.dart';
import 'package:projeto_leituramiga/interface/configuration/guards/usuario_nao_logado.guard.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';

enum Rota {
  AUTENTICACAO(url: "/", pageInfo: AutenticacaoRoute.page),
  AREA_LOGADA(url: "/leituramiga/", pageInfo: AreaLogadaRoute.page),
  LOGIN(url: "login", pageInfo: LoginRoute.page),
  CADASTRO_USUARIO(url: "cadastro-usuario", pageInfo: CadastroUsuarioRoute.page),
  SENHA(url: "esqueceu-senha", pageInfo: EsqueceSenhaRoute.page),
  HOME(url: "home", pageInfo: HomeRoute.page),
  LIVRO(url: "livro/:numeroLivro", pageInfo: LivrosRoute.page),
  USUARIO(url: "usuario/:numeroUsuario", pageInfo: UsuarioRoute.page),
  SUPORTE(url: "criar-solicitacao/:numeroLivro/:tipoSolicitacao", pageInfo: CriarSolicitacaoRoute.page),
  PERFIL(url: "perfil", pageInfo: PerfilRoute.page),
  EDITAR_PERFIL(url: "editar-perfil", pageInfo: EditarPefilRoute.page),
  CRIAR_LIVRO(url: "adicionar-livro", pageInfo: CriarLivroRoute.page),
  CALENDARIO(url: "calendario", pageInfo: CalendarioRoute.page),
  DETALHES_SOLICITACAO(url: "detalhes-solicitacao/:numeroSolicitacao", pageInfo: DetalhesSolicitacaoRoute.page),
  SOLICITACAO(url: "solicitacao/:numeroSolicitacao", pageInfo: VisualizarSolicitacaoRoute.page);

  final PageInfo<dynamic> pageInfo;
  final String url;
  static final Map<String, PageInfo> rotas = registrarTodas();

  const Rota({required this.pageInfo, required this.url});

  static List<AutoRoute> get rotasAuto => [
        adicionar(
          rota: AUTENTICACAO,
          inicial: true,
          subrotas: [
            adicionar(rota: LOGIN, inicial: true, guards: [UsuarioNaoLogadoGuard()]),
            adicionar(rota: CADASTRO_USUARIO, guards: [UsuarioNaoLogadoGuard()]),
            adicionar(rota: SENHA, guards: [UsuarioNaoLogadoGuard()]),
          ],
        ),
        adicionar(
          rota: AREA_LOGADA,
          subrotas: [
            adicionar(rota: HOME, inicial: true, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: LIVRO, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: SUPORTE, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: USUARIO, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: PERFIL, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: CRIAR_LIVRO, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: EDITAR_PERFIL, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: SOLICITACAO, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: DETALHES_SOLICITACAO, guards: [UsuarioLogadoGuard()]),
            adicionar(rota: CALENDARIO, guards: [UsuarioLogadoGuard()]),
          ],
        ),
      ];

  static void navegar(BuildContext context, Rota rota) {
    try {
      AutoRouter.of(context).navigateNamed(rota.url);
    } catch (e) {
      Notificacoes.mostrar("Não foi possível navegar");
    }
  }

  static void navegarComArgumentos(BuildContext context, PageRouteInfo rota) {
    AutoRouter.of(context).navigate(rota);
  }

  static Map<String, PageInfo> registrarTodas() {
    Map<String, PageInfo> mapa = {};
    for (Rota rota in Rota.values.toList()) {
      mapa[rota.name] = rota.pageInfo;
    }
    return mapa;
  }

  static CustomRoute adicionar({
    bool manterEstado = true,
    List<AutoRouteGuard>? guards,
    List<AutoRoute>? subrotas,
    required Rota rota,
    bool inicial = false,
  }) {
    return CustomRoute(
      path: rota.url,
      page: rota.pageInfo,
      maintainState: manterEstado,
      guards: guards ?? [],
      children: subrotas,
      initial: inicial,
    );
  }
}
