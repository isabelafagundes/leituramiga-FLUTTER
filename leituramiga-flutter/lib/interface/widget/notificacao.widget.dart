import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

Future<void> notificarCasoErro(Future<void> Function() rotina) async {
  try {
    await rotina();
  } catch (e) {
    Notificacoes.mostrar(e.toString(), Emoji.ERRO);
    print(StackTrace.current);
  }
}

class Notificacoes {
  static final Queue<Notificacao> _notificacoes = Queue();
  static Notificacao? notificacaoAtual;
  static Function() atualizar = () => {};

  static definirAtualizar(Function() atualizarTela) {
    atualizar = atualizarTela;
    atualizar();
  }

  static void mostrar(String mensagem, [Emoji emoji = Emoji.ALERTA]) {
    Notificacao notificacao = Notificacao(emoji, mensagem);
    _notificacoes.add(notificacao);
    _processarNotificacoes();
  }

  static void _processarNotificacoes() {
    while (_notificacoes.isNotEmpty) {
      notificacaoAtual = _notificacoes.removeFirst();
      atualizar();
      Future.delayed(const Duration(seconds: 5), () {
        notificacaoAtual = null;
        atualizar();
      });
    }
  }

  static fechaNotificacao() {
    notificacaoAtual = null;
    atualizar();
    _processarNotificacoes();
  }
}

class NotificacaoWidget extends StatefulWidget {
  final Tema tema;
  final Widget child;

  const NotificacaoWidget({
    super.key,
    required this.tema,
    required this.child,
  });

  @override
  State<NotificacaoWidget> createState() => _NotificacaoWidgetState();
}

class _NotificacaoWidgetState extends State<NotificacaoWidget> {
  @override
  initState() {
    super.initState();
    Notificacoes.definirAtualizar(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: Responsive.altura(context),
        width: Responsive.largura(context),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            widget.child,
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: Notificacoes.notificacaoAtual == null ? -100 : 8,
              child: Container(
                height: Responsive.larguraP(context) ? 50 : 60,
                width: Responsive.larguraP(context) ? Responsive.largura(context) - widget.tema.espacamento * 2 : 400,
                decoration: BoxDecoration(
                  color: Color(widget.tema.base200),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(widget.tema.neutral).withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: widget.tema.espacamento),
                          if (Notificacoes.notificacaoAtual?.emoji != null)
                            SvgWidget(
                              nomeSvg: '',
                              caminhoCompleto: Notificacoes.notificacaoAtual?.emoji.icone,
                              altura: Responsive.larguraP(context) ? 30 : 35,
                              cor: corNotificacao,
                            ),
                          SizedBox(width: widget.tema.espacamento),
                          Expanded(
                            child: TextoWidget(texto: Notificacoes.notificacaoAtual?.mensagem ?? '', tema: widget.tema),
                          ),
                          SizedBox(width: widget.tema.espacamento),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Color(widget.tema.baseContent),
                            ),
                            onPressed: () => Notificacoes.fechaNotificacao(),
                          ),
                          SizedBox(width: widget.tema.espacamento / 2),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 3,
                        width: Responsive.larguraP(context) ? Responsive.largura(context) : 400,
                        color: corNotificacao,
                      )
                    ],
                  ).animate(target: Notificacoes.notificacaoAtual == null ? 0 : 1).fade(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color get corNotificacao {
    return switch (Notificacoes.notificacaoAtual?.emoji) {
      Emoji.SUCESSO => Color(widget.tema.success),
      Emoji.ERRO => Color(widget.tema.error),
      Emoji.ALERTA => Color(widget.tema.warning),
      _ => Color(widget.tema.base200),
    };
  }
}

class Notificacao {
  final Emoji emoji;
  final String mensagem;

  const Notificacao(this.emoji, this.mensagem);
}

enum Emoji {
  SUCESSO('Sucesso', 'assets/svg/face-smile.svg'),
  ERRO('Erro', 'assets/svg/face-frown.svg'),
  ALERTA('Alerta', 'assets/svg/exclaimation-circle.svg');

  final String descricao;
  final String icone;

  const Emoji(this.descricao, this.icone);
}
