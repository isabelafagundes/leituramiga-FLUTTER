import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.state.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/criar_solicitacao.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/cadastro_usuario.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/home.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/login.page.dart';
import 'package:projeto_leituramiga/interface/widget/scroll_horizontal.dart';

void main() {
  Rota.registrarTodas();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LeiturAmiga',
      scrollBehavior: ScrollHorizontal(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: RotaState.instancia!.appRouter.config(),
    );
  }
}
