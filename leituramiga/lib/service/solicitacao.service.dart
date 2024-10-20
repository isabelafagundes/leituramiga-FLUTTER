import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';

abstract class SolicitacaoService {
  Future<void> recusarSolicitacao(int numero, String motivo);

  Future<void> aceitarSolicitacao(int numero, LivrosSolicitacao? livrosTroca);

  Future<void> cancelarSolicitacao(int numero, String motivo);

  Future<void> finalizarSolicitacao(int numero);
}
