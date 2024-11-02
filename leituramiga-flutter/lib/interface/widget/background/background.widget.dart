import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final Tema tema;

  const BackgroundWidget({super.key, required this.child, required this.tema});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(tema.base100),
        body: Stack(
          children: [
            Positioned(
              bottom: 8,
              right: 8,
              child: TextoWidget(
                texto: "© 2024 LeiturAmiga. Todos os direitos reservados.",
                tema: tema,
                cor: Color(tema.baseContent).withOpacity(.7),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
