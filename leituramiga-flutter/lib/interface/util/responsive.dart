import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Responsive {
  static MediaQueryData of(BuildContext context) => MediaQuery.of(context);

  static Size size(BuildContext context) => of(context).size;

  static double largura(BuildContext context) => size(context).width;

  static double altura(BuildContext context) => size(context).height;

  static double alturaUtil(BuildContext context) {
    final media = of(context);
    final h = media.size.height - media.padding.top - media.padding.bottom;
    return math.max(0, h);
  }

  static double alturaDisponivel(BuildContext context) {
    final media = of(context);
    final h = media.size.height -
        media.padding.top -
        media.padding.bottom -
        media.viewInsets.bottom;
    return math.max(0, h);
  }

  static bool tecladoAberto(BuildContext context) {
    return of(context).viewInsets.bottom > 0;
  }

  static bool isMobile(BuildContext context) => largura(context) < 600;

  static bool isTablet(BuildContext context) {
    final w = largura( context);
    return w >= 600 && w < 1024;
  }

  static bool isDesktop(BuildContext context) => largura( context) >= 1024;

  static bool larguraM(BuildContext context) => largura( context) < 1200;

  static bool larguraP(BuildContext context) => largura( context) < 900;

  static bool larguraPP(BuildContext context) => largura( context) < 400;

  static bool get isWeb => kIsWeb;

  static EdgeInsets paddingHorizontal(BuildContext context) {
    final w = largura( context);

    if (w >= 1400) return const EdgeInsets.symmetric(horizontal: 80);
    if (w >= 1024) return const EdgeInsets.symmetric(horizontal: 48);
    if (w >= 600) return const EdgeInsets.symmetric(horizontal: 32);
    return const EdgeInsets.symmetric(horizontal: 16);
  }

  static double maxContentWidth(BuildContext context) {
    final w = largura( context);
    if (w >= 1400) return 1320;
    if (w >= 1024) return 1100;
    if (w >= 600) return 900;
    return w;
  }
}