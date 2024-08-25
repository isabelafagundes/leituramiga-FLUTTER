import 'package:leituramiga/domain/notificacao.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';

class NotificacaoMockRepo extends NotificacaoRepo {
  List<Notificacao> _notificacoes = [
    Notificacao.carregar(
      1,
      'Mensagem da notificação 1',
      1,
      1,
    ),
    Notificacao.carregar(
      2,
      'Mensagem da notificação 2',
      2,
      2,
    ),
    Notificacao.carregar(
      3,
      'Mensagem da notificação 3',
      3,
      3,
    ),
  ];

  @override
  Future<List<Notificacao>> obterNotificacoes(int numeroUsuario) async {
    return _notificacoes;
  }
}
