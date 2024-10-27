// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AreaLogadaRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AreaLogadaPage(),
      );
    },
    AutenticacaoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AutenticacaoPage(),
      );
    },
    CadastroUsuarioRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CadastroUsuarioPage(),
      );
    },
    CalendarioRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CalendarioPage(),
      );
    },
    CriarLivroRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CriarLivroPage(),
      );
    },
    CriarSolicitacaoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CriarSolicitacaoRouteArgs>(
          orElse: () => CriarSolicitacaoRouteArgs(
                numeroLivro: pathParams.optInt('numeroLivro'),
                tipoSolicitacao: pathParams.getInt('tipoSolicitacao'),
                nomeUsuario: pathParams.optString('nomeUsuario'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CriarSolicitacaoPage(
          key: args.key,
          numeroLivro: args.numeroLivro,
          tipoSolicitacao: args.tipoSolicitacao,
          nomeUsuario: args.nomeUsuario,
        ),
      );
    },
    DetalhesSolicitacaoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetalhesSolicitacaoRouteArgs>(
          orElse: () => DetalhesSolicitacaoRouteArgs(
              numeroSolicitacao: pathParams.getInt('numeroSolicitacao')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetalhesSolicitacaoPage(
          key: args.key,
          numeroSolicitacao: args.numeroSolicitacao,
        ),
      );
    },
    EditarLivroRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EditarLivroRouteArgs>(
          orElse: () => EditarLivroRouteArgs(
              codigoLivro: pathParams.getInt('codigoLivro')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditarLivroPage(
          key: args.key,
          codigoLivro: args.codigoLivro,
        ),
      );
    },
    EditarPefilRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditarPefilPage(),
      );
    },
    EsqueceSenhaRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EsqueceSenhaPage(),
      );
    },
    HistoricoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoricoPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    LivrosRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<LivrosRouteArgs>(
          orElse: () =>
              LivrosRouteArgs(numeroLivro: pathParams.getInt('numeroLivro')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LivrosPage(
          key: args.key,
          numeroLivro: args.numeroLivro,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    PerfilRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PerfilPage(),
      );
    },
    UsuarioRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UsuarioRouteArgs>(
          orElse: () => UsuarioRouteArgs(
              identificador: pathParams.getString('username')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UsuarioPage(
          key: args.key,
          identificador: args.identificador,
        ),
      );
    },
    VisualizarSolicitacaoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VisualizarSolicitacaoRouteArgs>(
          orElse: () => VisualizarSolicitacaoRouteArgs(
              numeroSolicitacao: pathParams.getInt('numeroSolicitacao')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VisualizarSolicitacaoPage(
          key: args.key,
          numeroSolicitacao: args.numeroSolicitacao,
        ),
      );
    },
  };
}

/// generated route for
/// [AreaLogadaPage]
class AreaLogadaRoute extends PageRouteInfo<void> {
  const AreaLogadaRoute({List<PageRouteInfo>? children})
      : super(
          AreaLogadaRoute.name,
          initialChildren: children,
        );

  static const String name = 'AreaLogadaRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AutenticacaoPage]
class AutenticacaoRoute extends PageRouteInfo<void> {
  const AutenticacaoRoute({List<PageRouteInfo>? children})
      : super(
          AutenticacaoRoute.name,
          initialChildren: children,
        );

  static const String name = 'AutenticacaoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CadastroUsuarioPage]
class CadastroUsuarioRoute extends PageRouteInfo<void> {
  const CadastroUsuarioRoute({List<PageRouteInfo>? children})
      : super(
          CadastroUsuarioRoute.name,
          initialChildren: children,
        );

  static const String name = 'CadastroUsuarioRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CalendarioPage]
class CalendarioRoute extends PageRouteInfo<void> {
  const CalendarioRoute({List<PageRouteInfo>? children})
      : super(
          CalendarioRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarioRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CriarLivroPage]
class CriarLivroRoute extends PageRouteInfo<void> {
  const CriarLivroRoute({List<PageRouteInfo>? children})
      : super(
          CriarLivroRoute.name,
          initialChildren: children,
        );

  static const String name = 'CriarLivroRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CriarSolicitacaoPage]
class CriarSolicitacaoRoute extends PageRouteInfo<CriarSolicitacaoRouteArgs> {
  CriarSolicitacaoRoute({
    Key? key,
    required int? numeroLivro,
    required int tipoSolicitacao,
    String? nomeUsuario,
    List<PageRouteInfo>? children,
  }) : super(
          CriarSolicitacaoRoute.name,
          args: CriarSolicitacaoRouteArgs(
            key: key,
            numeroLivro: numeroLivro,
            tipoSolicitacao: tipoSolicitacao,
            nomeUsuario: nomeUsuario,
          ),
          rawPathParams: {
            'numeroLivro': numeroLivro,
            'tipoSolicitacao': tipoSolicitacao,
            'nomeUsuario': nomeUsuario,
          },
          initialChildren: children,
        );

  static const String name = 'CriarSolicitacaoRoute';

  static const PageInfo<CriarSolicitacaoRouteArgs> page =
      PageInfo<CriarSolicitacaoRouteArgs>(name);
}

class CriarSolicitacaoRouteArgs {
  const CriarSolicitacaoRouteArgs({
    this.key,
    required this.numeroLivro,
    required this.tipoSolicitacao,
    this.nomeUsuario,
  });

  final Key? key;

  final int? numeroLivro;

  final int tipoSolicitacao;

  final String? nomeUsuario;

  @override
  String toString() {
    return 'CriarSolicitacaoRouteArgs{key: $key, numeroLivro: $numeroLivro, tipoSolicitacao: $tipoSolicitacao, nomeUsuario: $nomeUsuario}';
  }
}

/// generated route for
/// [DetalhesSolicitacaoPage]
class DetalhesSolicitacaoRoute
    extends PageRouteInfo<DetalhesSolicitacaoRouteArgs> {
  DetalhesSolicitacaoRoute({
    Key? key,
    required int numeroSolicitacao,
    List<PageRouteInfo>? children,
  }) : super(
          DetalhesSolicitacaoRoute.name,
          args: DetalhesSolicitacaoRouteArgs(
            key: key,
            numeroSolicitacao: numeroSolicitacao,
          ),
          rawPathParams: {'numeroSolicitacao': numeroSolicitacao},
          initialChildren: children,
        );

  static const String name = 'DetalhesSolicitacaoRoute';

  static const PageInfo<DetalhesSolicitacaoRouteArgs> page =
      PageInfo<DetalhesSolicitacaoRouteArgs>(name);
}

class DetalhesSolicitacaoRouteArgs {
  const DetalhesSolicitacaoRouteArgs({
    this.key,
    required this.numeroSolicitacao,
  });

  final Key? key;

  final int numeroSolicitacao;

  @override
  String toString() {
    return 'DetalhesSolicitacaoRouteArgs{key: $key, numeroSolicitacao: $numeroSolicitacao}';
  }
}

/// generated route for
/// [EditarLivroPage]
class EditarLivroRoute extends PageRouteInfo<EditarLivroRouteArgs> {
  EditarLivroRoute({
    Key? key,
    required int codigoLivro,
    List<PageRouteInfo>? children,
  }) : super(
          EditarLivroRoute.name,
          args: EditarLivroRouteArgs(
            key: key,
            codigoLivro: codigoLivro,
          ),
          rawPathParams: {'codigoLivro': codigoLivro},
          initialChildren: children,
        );

  static const String name = 'EditarLivroRoute';

  static const PageInfo<EditarLivroRouteArgs> page =
      PageInfo<EditarLivroRouteArgs>(name);
}

class EditarLivroRouteArgs {
  const EditarLivroRouteArgs({
    this.key,
    required this.codigoLivro,
  });

  final Key? key;

  final int codigoLivro;

  @override
  String toString() {
    return 'EditarLivroRouteArgs{key: $key, codigoLivro: $codigoLivro}';
  }
}

/// generated route for
/// [EditarPefilPage]
class EditarPefilRoute extends PageRouteInfo<void> {
  const EditarPefilRoute({List<PageRouteInfo>? children})
      : super(
          EditarPefilRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditarPefilRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EsqueceSenhaPage]
class EsqueceSenhaRoute extends PageRouteInfo<void> {
  const EsqueceSenhaRoute({List<PageRouteInfo>? children})
      : super(
          EsqueceSenhaRoute.name,
          initialChildren: children,
        );

  static const String name = 'EsqueceSenhaRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoricoPage]
class HistoricoRoute extends PageRouteInfo<void> {
  const HistoricoRoute({List<PageRouteInfo>? children})
      : super(
          HistoricoRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoricoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LivrosPage]
class LivrosRoute extends PageRouteInfo<LivrosRouteArgs> {
  LivrosRoute({
    Key? key,
    required int numeroLivro,
    List<PageRouteInfo>? children,
  }) : super(
          LivrosRoute.name,
          args: LivrosRouteArgs(
            key: key,
            numeroLivro: numeroLivro,
          ),
          rawPathParams: {'numeroLivro': numeroLivro},
          initialChildren: children,
        );

  static const String name = 'LivrosRoute';

  static const PageInfo<LivrosRouteArgs> page = PageInfo<LivrosRouteArgs>(name);
}

class LivrosRouteArgs {
  const LivrosRouteArgs({
    this.key,
    required this.numeroLivro,
  });

  final Key? key;

  final int numeroLivro;

  @override
  String toString() {
    return 'LivrosRouteArgs{key: $key, numeroLivro: $numeroLivro}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PerfilPage]
class PerfilRoute extends PageRouteInfo<void> {
  const PerfilRoute({List<PageRouteInfo>? children})
      : super(
          PerfilRoute.name,
          initialChildren: children,
        );

  static const String name = 'PerfilRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsuarioPage]
class UsuarioRoute extends PageRouteInfo<UsuarioRouteArgs> {
  UsuarioRoute({
    Key? key,
    required String identificador,
    List<PageRouteInfo>? children,
  }) : super(
          UsuarioRoute.name,
          args: UsuarioRouteArgs(
            key: key,
            identificador: identificador,
          ),
          rawPathParams: {'username': identificador},
          initialChildren: children,
        );

  static const String name = 'UsuarioRoute';

  static const PageInfo<UsuarioRouteArgs> page =
      PageInfo<UsuarioRouteArgs>(name);
}

class UsuarioRouteArgs {
  const UsuarioRouteArgs({
    this.key,
    required this.identificador,
  });

  final Key? key;

  final String identificador;

  @override
  String toString() {
    return 'UsuarioRouteArgs{key: $key, identificador: $identificador}';
  }
}

/// generated route for
/// [VisualizarSolicitacaoPage]
class VisualizarSolicitacaoRoute
    extends PageRouteInfo<VisualizarSolicitacaoRouteArgs> {
  VisualizarSolicitacaoRoute({
    Key? key,
    required int numeroSolicitacao,
    List<PageRouteInfo>? children,
  }) : super(
          VisualizarSolicitacaoRoute.name,
          args: VisualizarSolicitacaoRouteArgs(
            key: key,
            numeroSolicitacao: numeroSolicitacao,
          ),
          rawPathParams: {'numeroSolicitacao': numeroSolicitacao},
          initialChildren: children,
        );

  static const String name = 'VisualizarSolicitacaoRoute';

  static const PageInfo<VisualizarSolicitacaoRouteArgs> page =
      PageInfo<VisualizarSolicitacaoRouteArgs>(name);
}

class VisualizarSolicitacaoRouteArgs {
  const VisualizarSolicitacaoRouteArgs({
    this.key,
    required this.numeroSolicitacao,
  });

  final Key? key;

  final int numeroSolicitacao;

  @override
  String toString() {
    return 'VisualizarSolicitacaoRouteArgs{key: $key, numeroSolicitacao: $numeroSolicitacao}';
  }
}
