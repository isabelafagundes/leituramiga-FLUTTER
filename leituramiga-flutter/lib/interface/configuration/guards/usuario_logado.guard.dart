import 'package:auto_route/auto_route.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';

class UsuarioLogadoGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    AutenticacaoState autenticacao = AutenticacaoState.instancia;

    if (autenticacao.usuario == null) {
      router.navigate(const AutenticacaoRoute());
    } else {
      resolver.next(true);
    }
  }
}
