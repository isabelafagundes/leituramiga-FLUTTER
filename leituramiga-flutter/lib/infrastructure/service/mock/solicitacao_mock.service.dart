import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/service/solicitacao.service.dart';

class SolicitacaoMockService extends SolicitacaoService {


  @override
  Future<void> cancelarSolicitacao(int numero,String motivo) {
    // TODO: implement cancelarSolicitacao
    throw UnimplementedError();
  }

  @override
  Future<void> recusarSolicitacao(int numero, String motivo) {
    // TODO: implement recusarSolicitacao
    throw UnimplementedError();
  }

  @override
  Future<void> finalizarSolicitacao(int numero) {
    // TODO: implement finalizarSolicitacao
    throw UnimplementedError();
  }

  @override
  Future<void> aceitarSolicitacao(int numero, LivrosSolicitacao? livrosTroca) {
    // TODO: implement aceitarSolicitacao
    throw UnimplementedError();
  }

}