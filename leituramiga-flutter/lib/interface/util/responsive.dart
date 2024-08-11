import 'package:flutter/cupertino.dart';

class Responsive {
  static double altura(BuildContext context) => MediaQuery.of(context).size.height;

  static double largura(BuildContext context) => MediaQuery.of(context).size.width;

  static bool larguraM(BuildContext context) => largura(context) < 1200;

  static bool larguraP(BuildContext context) => largura(context) < 900;

  static bool larguraPP(BuildContext context) => largura(context) < 400;
}
