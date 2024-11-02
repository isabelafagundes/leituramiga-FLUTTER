import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';

abstract class SolicitacaoService {
  Future<void> recusarSolicitacao(int numero, String motivo);

  Future<void> aceitarSolicitacao(int numero, LivrosSolicitacao? livrosTroca, Endereco? segundoEndereco);

  Future<void> cancelarSolicitacao(int numero, String motivo);

  Future<void> finalizarSolicitacao(int numero);
}
