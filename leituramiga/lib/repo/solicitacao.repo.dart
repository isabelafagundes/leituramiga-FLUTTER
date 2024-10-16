import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';

abstract class SolicitacaoRepo {
  Future<List<ResumoSolicitacao>> obterSolicitacoes(String emailUsuario, [int numeroPagina = 0, int limite = 50]);

  Future<List<ResumoSolicitacao>> obterHistorico(String emailUsuario, [int numeroPagina = 0, int limite = 50]);

  Future<Solicitacao> obterSolicitacao(int numero);

  Future<void> atualizarSolicitacao(Solicitacao solicitacao);
}
