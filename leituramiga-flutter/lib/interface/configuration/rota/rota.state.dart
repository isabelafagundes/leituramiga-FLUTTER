import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';

class RotaState {
  static RotaState? _instancia;

  RotaState._();

  static RotaState? get instancia {
    _instancia ??= RotaState._();
    return _instancia!;
  }

  final AppRouter _appRouter = AppRouter();

  AppRouter get appRouter => _appRouter;
}
