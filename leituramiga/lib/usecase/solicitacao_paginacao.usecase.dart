import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';

class SolicitacaoPaginacaoUseCase {
  final PaginacaoState<ResumoSolicitacao> _state;
  final SolicitacaoRepo _repo;

  const SolicitacaoPaginacaoUseCase(this._state, this._repo);

  Future<void> obterSolicitacoesIniciais(String emailUsuario) async {
    _state.reiniciar();
    List<ResumoSolicitacao> pagina = await _repo.obterSolicitacoes(emailUsuario);
    _state.paginar(pagina, 50);
  }

  Future<void> obterHistoricoInicial(String emailUsuario) async {
    _state.reiniciar();
    List<ResumoSolicitacao> pagina = await _repo.obterHistorico(emailUsuario);
    _state.paginar(pagina, 50);
  }

  Future<void> obterSolicitacoesPaginadas(String emailUsuario) async {
    List<ResumoSolicitacao> pagina = await _repo.obterSolicitacoes(emailUsuario, _state.pagina);
    _state.paginar(pagina, 50);
  }

  Future<void> obterHistoricoPaginadas(String emailUsuario) async {
    List<ResumoSolicitacao> pagina = await _repo.obterHistorico(emailUsuario, _state.pagina);
    _state.paginar(pagina, 50);
  }
}
