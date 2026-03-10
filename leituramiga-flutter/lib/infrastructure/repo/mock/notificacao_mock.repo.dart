import 'package:leituramiga/domain/notificacao.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';

class NotificacaoMockRepo extends NotificacaoRepo {
  static NotificacaoMockRepo? _instancia;

  NotificacaoMockRepo._();

  static NotificacaoMockRepo get instancia {
    _instancia ??= NotificacaoMockRepo._();
    return _instancia!;
  }

  final List<Notificacao> _notificacoes = [
    Notificacao.carregar(1, 'joao_silva', 'joao@gmail.com', 1, null),
    Notificacao.carregar(2, 'isabela', 'isabela@gmail.com', 2, null),
    Notificacao.carregar(3, 'kauaguedes', 'kaua@gmail.com', 3, null),
  ];

  @override
  Future<List<Notificacao>> obterNotificacoes(String emailUsuario) async {
    return _notificacoes;
  }
}
