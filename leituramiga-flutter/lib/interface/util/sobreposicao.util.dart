import 'package:flutter/material.dart';

class SobreposicaoUtil {
  static double _opacidade = 0;
  static bool _visivel = false;
  static double _larguraDrawer = 630;
  static late Function() _atualizar = () {};

  static void definirAtualizar(Function() value) => _atualizar = value;

  static void definirDimensoes({double largura = 630}) {
    _larguraDrawer = larguraDrawer;
    _atualizar();
  }

  static double get opacidade => _opacidade;

  static bool get visivel => _visivel;

  static double get larguraDrawer => _larguraDrawer;

  static Future<void> exibir(BuildContext context, Widget widget, {Function()? aoFechar}) async {
    _resetarVisualizacao();
    dynamic resposta = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: const Duration(milliseconds: 0),
        reverseTransitionDuration: const Duration(milliseconds: 0),
        opaque: false,
      ),
    );
    if (resposta != null && resposta && aoFechar != null) aoFechar();
  }

  static Future exibirFuture(BuildContext context, Widget widget) async {
    _resetarVisualizacao();
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: const Duration(milliseconds: 0),
        reverseTransitionDuration: const Duration(milliseconds: 0),
        opaque: false,
      ),
    );
  }

  static void _resetarVisualizacao() {
    _opacidade = 0;
    _visivel = false;
    _atualizar();
  }

  static Future<void> fechar(BuildContext context, {dynamic resposta = false, bool semAnimacao = false}) async {
    await alterarVisibilidade(semAnimacao: semAnimacao);
    _opacidade = 0;
    _atualizar();
    await Future.delayed(
      Duration(milliseconds: semAnimacao ? 0 : 100),
          () {
        if(context.mounted)Navigator.pop(context, resposta);
      },
    );
  }

  static Future<void> alterarVisibilidade({bool semAnimacao = false}) async {
    await Future.delayed(Duration(milliseconds: semAnimacao ? 0 : 100), () {
      _opacidade = 1;
      _visivel = !_visivel;
      _atualizar();
    });
  }
}