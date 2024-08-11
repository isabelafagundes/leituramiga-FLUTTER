import 'dart:async';

import 'package:flutter/animation.dart';

class Debouncer {
  final int milisegundos;
  Timer? _timer;

  Debouncer({required this.milisegundos});

  void executar(VoidCallback rotina) {
    cancelar();
    _timer = Timer(Duration(milliseconds: milisegundos), rotina);
  }

  void cancelar() {
    if (_timer?.isActive??false) _timer!.cancel();
  }
}