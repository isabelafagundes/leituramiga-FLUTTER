import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/repo/notificacao.repo.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:leituramiga/service/solicitacao.service.dart';
import 'package:leituramiga/state/notificao.state.dart';
import 'package:leituramiga/state/solicitacao.state.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';
import 'package:leituramiga/state/super/state.dart';
import 'package:leituramiga/usecase/notificacao.usecase.dart';
import 'package:leituramiga/usecase/solicitacao.usecase.dart';
import 'package:leituramiga/usecase/solicitacao_paginacao.usecase.dart';

class SolicitacaoComponent extends State with SolicitacaoState, PaginacaoState<ResumoSolicitacao>, NotificacaoState {
  late final SolicitacaoUseCase _solicitacaoUseCase;
  late final SolicitacaoPaginacaoUseCase _paginacaoUseCase;
  late final NotificacaoUseCase _notificacaoUseCase;

  void inicializar(
      SolicitacaoRepo repo, SolicitacaoService service, NotificacaoRepo notificacaoRepo, Function() atualizar) {
    _solicitacaoUseCase = SolicitacaoUseCase(this, repo, service);
    _paginacaoUseCase = SolicitacaoPaginacaoUseCase(this, repo);
    _notificacaoUseCase = NotificacaoUseCase(notificacaoRepo, this);
    super.atualizar = atualizar;
  }

  Future<void> obterSolicitacoesIniciais(String emailUsuario) async {
    await executar(
      rotina: () => _paginacaoUseCase.obterSolicitacoesIniciais(emailUsuario),
      mensagemErro: "Não foi possível obter as solicitações",
    );
  }

  Future<void> obterHistoricoInicial(String emailUsuario) async {
    await executar(
      rotina: () => _paginacaoUseCase.obterHistoricoInicial(emailUsuario),
      mensagemErro: "Não foi possível obter o histórico",
    );
  }

  Future<void> obterHistoricoPaginadas(String emailUsuario) async {
    await executar(
      rotina: () => _paginacaoUseCase.obterHistoricoPaginadas(emailUsuario),
      mensagemErro: "Não foi possível obter o histórico",
    );
  }

  Future<void> obterSolicitacoesPaginadas(String emailUsuario) async {
    await executar(
      rotina: () => _paginacaoUseCase.obterSolicitacoesPaginadas(emailUsuario),
      mensagemErro: "Não foi possível obter as solicitações",
    );
  }

  Future<void> aceitarSolicitacao(int numeroSolicitacao) async {
    await executar(
      rotina: () => _solicitacaoUseCase.aceitarSolicitacao(numeroSolicitacao),
      mensagemErro: "Não foi possível aceitar a solicitação",
    );
  }

  Future<void> recusarSolicitacao(int numeroSolicitacao, String motivo) async {
    await executar(
      rotina: () => _solicitacaoUseCase.recusarSolicitacao(numeroSolicitacao, motivo),
      mensagemErro: "Não foi possível recusar a solicitação",
    );
  }

  Future<void> finalizarSolicitacao(int numeroSolicitacao) async {
    await executar(
      rotina: () => _solicitacaoUseCase.finalizarSolicitacao(numeroSolicitacao),
      mensagemErro: "Não foi possível finalizar a solicitação",
    );
  }

  Future<void> atualizarSolicitacao() async {
    await executar(
      rotina: () => _solicitacaoUseCase.atualizarSolicitacao(),
      mensagemErro: "Não foi possível atualizar a solicitação",
    );
  }

  void atualizarSolicitacaoMemoria(Solicitacao solicitacao) {
    executar(
      rotina: () => _solicitacaoUseCase.atualizarSolicitacaoMemoria(solicitacao),
      mensagemErro: "Não foi possível atualizar a solicitação",
    );
  }

  Future<void> cancelarSolicitacao(int numeroSolicitacao, String motivo) async {
    await executar(
      rotina: () => _solicitacaoUseCase.cancelarSolicitacao(numeroSolicitacao, motivo),
      mensagemErro: "Não foi possível cancelar a solicitação",
    );
  }

  Future<void> obterNotificacoes(String emailUsuario) async {
    await executar(
      rotina: () => _notificacaoUseCase.obterNotificacoes(emailUsuario),
      mensagemErro: "Não foi possível obter as notificações",
    );
  }

  Future<void> obterSolicitacao(int numeroSolicitacao) async {
    await executar(
      rotina: () => _solicitacaoUseCase.obterSolicitacao(numeroSolicitacao),
      mensagemErro: "Não foi possível obter a solicitação",
    );
  }

  void selecionarLivro(ResumoLivro livro) async {
    await executar(
      rotina: () => _solicitacaoUseCase.selecionarLivro(livro),
      mensagemErro: "Não foi possível selecionar o livro",
    );
  }

  void removerLivro(LivroSolicitacao livro) async {
    await executar(
      rotina: () => _solicitacaoUseCase.removerLivro(livro),
      mensagemErro: "Não foi possível remover o livro",
    );
  }

  void utilizarEnderecoDoPerfil() async {
    await executar(
      rotina: () => _solicitacaoUseCase.utilizarEnderecoPerfil(),
      mensagemErro: "Não foi possível utilizar o endereço do perfil",
    );
  }
}
