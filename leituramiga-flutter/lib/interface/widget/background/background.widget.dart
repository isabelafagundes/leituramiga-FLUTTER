import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final Tema tema;

  const BackgroundWidget({super.key, required this.child, required this.tema});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(tema.base100),
        body: child,
      ),
    );
  }
}
