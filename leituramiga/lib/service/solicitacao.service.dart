abstract class SolicitacaoService {
  Future<void> recusarSolicitacao(String motivo);

  Future<void> aceitarSolicitacao();

  Future<void> cancelarSolicitacao();
}
