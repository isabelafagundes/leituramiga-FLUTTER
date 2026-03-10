import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/service/solicitacao.service.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.repo.dart';

class SolicitacaoMockService extends SolicitacaoService {
  static SolicitacaoMockService? _instancia;

  SolicitacaoMockService._();

  static SolicitacaoMockService get instancia {
    _instancia ??= SolicitacaoMockService._();
    return _instancia!;
  }

  SolicitacaoMockRepo get _repo => SolicitacaoMockRepo.instancia;

  @override
  Future<void> cancelarSolicitacao(int numero, String motivo) async {
    await _repo.cancelarSolicitacao(numero, motivo);
  }

  @override
  Future<void> recusarSolicitacao(int numero, String motivo) async {
    await _repo.recusarSolicitacao(numero, motivo);
  }

  @override
  Future<void> finalizarSolicitacao(int numero) async {
    await _repo.finalizarSolicitacao(numero);
  }

  @override
  Future<void> aceitarSolicitacao(int numero, LivrosSolicitacao? livrosTroca, Endereco? segundoEndereco) async {
    await _repo.aceitarSolicitacao(numero, livrosTroca, segundoEndereco);
  }
}
