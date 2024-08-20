import 'package:leituramiga/domain/notificacao.dart';

abstract class NotificacaoRepo {
  Future<List<Notificacao>> obterNotificacoes();
}