import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';

enum Rota {
  AUTENTICACAO(url: "/", pageInfo: AutenticacaoRoute.page),
  AREA_LOGADA(url: "/leituramiga/", pageInfo: AreaLogadaRoute.page),
  LOGIN(url: "login", pageInfo: LoginRoute.page),
  CADASTRO_USUARIO(url: "cadastro-usuario", pageInfo: CadastroUsuarioRoute.page),
  HOME(url: "home", pageInfo: HomeRoute.page),
  LIVRO(url: "livro", pageInfo: LivrosRoute.page),
  USUARIO(url: "usuario", pageInfo: UsuarioRoute.page),
  CRIAR_SOLICITACAO(url: "criar-solicitacao", pageInfo: CriarSolicitacaoRoute.page),
  PERFIL(url: "perfil", pageInfo: PerfilRoute.page),
  EDITAR_PERFIL(url: "editar-perfil", pageInfo: EditarPefilRoute.page),
  CRIAR_LIVRO(url: "adicionar-livro", pageInfo: CriarLivroRoute.page);

  final PageInfo<dynamic> pageInfo;
  final String url;
  static final Map<String, PageInfo> rotas = registrarTodas();

  const Rota({required this.pageInfo, required this.url});

  static List<AutoRoute> get rotasAuto => [
        adicionar(
          rota: AUTENTICACAO,
          inicial: true,
          subrotas: [
            adicionar(rota: LOGIN, inicial: true),
            adicionar(rota: CADASTRO_USUARIO),
          ],
        ),
        adicionar(
          rota: AREA_LOGADA,
          subrotas: [
            adicionar(rota: HOME, inicial: true),
            adicionar(rota: LIVRO),
            adicionar(rota: CRIAR_SOLICITACAO),
            adicionar(rota: USUARIO),
            adicionar(rota: PERFIL),
            adicionar(rota: CRIAR_LIVRO),
            adicionar(rota: EDITAR_PERFIL),
          ],
        ),
      ];

  static void navegar(BuildContext context, Rota rota) {
    AutoRouter.of(context).navigateNamed(rota.url);
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
    bool manterEstado = false,
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
