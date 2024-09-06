import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/instituicao_mock.repo.dart';

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
      DataHora.hoje(),
      null,
      TipoSolicitacao.TROCA,
    ),
  ];

  Solicitacao get solicitacao => Solicitacao.criar(
        1,
        2,
        1,
        FormaEntrega.PRESENCIAL,
        DataHora.hoje(),
        DataHora.hoje(),
        null,
        DataHora.hoje(),
        "Vou esperar no refeitório da faculdade",
        EnderecoMockRepo().endereco,
        InstituicaoMockRepo().instituicoes[0],
        TipoStatusSolicitacao.PENDENTE,
        null,
        null,
        "isabela",
        TipoSolicitacao.TROCA,
        1,
      );

  @override
  Future<void> atualizarSolicitacao(Solicitacao solicitacao) {
    // TODO: implement atualizarSolicitacao
    throw UnimplementedError();
  }

  @override
  Future<Solicitacao> obterSolicitacao(int numero) async {
    return solicitacao;
  }

  @override
  Future<List<ResumoSolicitacao>> obterSolicitacoes(int numeroUsuario, [int numeroPagina = 0, int limite = 50]) async {
    return _solicitacoes;
  }
}
