import 'package:leituramiga/domain/notificacao.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';

class NotificacaoMockRepo extends NotificacaoRepo {
  List<Notificacao> _notificacoes = [
    Notificacao.carregar(
      1,
      'joao',
      '',
      1,
    ),
    Notificacao.carregar(
      2,
      'isabela',
      '',
      2,
    ),
    Notificacao.carregar(
      3,
      'kauaguedes',
      '',
      3,
    ),
  ];

  @override
  Future<List<Notificacao>> obterNotificacoes(String emailUsuario) async {
    return _notificacoes;
  }
}
