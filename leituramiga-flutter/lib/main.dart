import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.state.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/scroll_horizontal.dart';

void main() {
  Rota.registrarTodas();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => Rota.navegar(context, Rota.AUTENTICACAO));
  }

  @override
  Widget build(BuildContext context) {
    Tema tema = TemaState.instancia.temaSelecionado!;
    return MaterialApp.router(
      title: 'LeiturAmiga',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
      scrollBehavior: ScrollHorizontal(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(tema.accent)),
        useMaterial3: true,
        fontFamily: tema.familiaDeFontePrimaria,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Color(tema.accent)), // Cor da barra de rolagem
          thickness: WidgetStateProperty.all(8.0), // Espessura da barra de rolagem
          radius: const Radius.circular(10), // Raio das bordas da barra de rolagem
        ),
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return NotificacaoWidget(
          tema: tema,
          child: child!,
        );
      },
      routerConfig: RotaState.instancia!.appRouter.config(),
    );
  }
}
