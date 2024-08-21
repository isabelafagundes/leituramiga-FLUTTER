import 'package:leituramiga/domain/notificacao.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';
import 'package:leituramiga/state/notificao.state.dart';

class NotificacaoUseCase {
  final NotificacaoRepo _repo;
  final NotificacaoState _state;

  const NotificacaoUseCase(this._repo, this._state);

  Future<void> obterNotificacoes(int numeroUsuario) async {
    List<Notificacao> notificacoes = await _repo.obterNotificacoes(numeroUsuario);
    _state.notificacoes = notificacoes;
  }
}
