import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';

class SolicitacaoMockRepo extends SolicitacaoRepo {
  final List<ResumoSolicitacao> _solicitacoes = [
    ResumoSolicitacao.carregar(
      1,
      EnderecoMockRepo().endereco,
      "isabela",
      DataHora.hoje(),
      null,
      TipoSolicitacao.TROCA,
    ),
    ResumoSolicitacao.carregar(
      2,
      EnderecoMockRepo().endereco,
      "isabela",
      DataHora.hoje(),
      null,
      TipoSolicitacao.DOACAO,
    ),
    ResumoSolicitacao.carregar(
      3,
      EnderecoMockRepo().endereco,
      "isabela",
      DataHora.ontem(),
      null,
      TipoSolicitacao.TROCA,
    ),
  ];

  @override
  Future<void> atualizarSolicitacao(Solicitacao solicitacao) {
    // TODO: implement atualizarSolicitacao
    throw UnimplementedError();
  }

  @override
  Future<Solicitacao> obterSolicitacao(int numero) async {
    // TODO: implement atualizarSolicitacao
    throw UnimplementedError();
  }

  @override
  Future<List<ResumoSolicitacao>> obterSolicitacoes(String numeroUsuario,
      [int numeroPagina = 0, int limite = 50]) async {
    return _solicitacoes;
  }

  @override
  Future<List<ResumoSolicitacao>> obterHistorico(String emailUsuario, String? dataInicio, String? dataFim, [int numeroPagina = 0, int limite = 50]) {
    // TODO: implement obterHistorico
    throw UnimplementedError();
  }


}
