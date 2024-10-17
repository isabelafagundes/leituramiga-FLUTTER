abstract class SolicitacaoService {
  Future<void> recusarSolicitacao(int numero, String motivo);

  Future<void> aceitarSolicitacao(int numero);

  Future<void> cancelarSolicitacao(int numero);

  Future<void> finalizarSolicitacao(int numero);
}
