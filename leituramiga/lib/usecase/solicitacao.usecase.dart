import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:leituramiga/service/solicitacao.service.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:leituramiga/state/solicitacao.state.dart';

class SolicitacaoUseCase {
  final SolicitacaoState _state;
  final SolicitacaoRepo _repo;
  final SolicitacaoService _service;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  const SolicitacaoUseCase(this._state, this._repo, this._service);

  Future<void> obterSolicitacao(int numero) async {
    Solicitacao solicitacao = await _repo.obterSolicitacao(numero);
    _state.solicitacaoSelecionada = solicitacao;
  }

  Future<void> aceitarSolicitacao(int numero) async {
    LivrosSolicitacao? livrosTroca = _state.livrosSelecionados.isEmpty
        ? null
        : LivrosSolicitacao.criar(_autenticacaoState.emailUsuario, _state.livrosSelecionados);
    await _service.aceitarSolicitacao(numero, livrosTroca);
    await obterSolicitacao(numero);
  }

  Future<void> recusarSolicitacao(int numero, String motivo) async {
    await _service.recusarSolicitacao(numero, motivo);
    await obterSolicitacao(numero);
  }

  Future<void> finalizarSolicitacao(int numero) async {
    await _service.finalizarSolicitacao(numero);
    await obterSolicitacao(numero);
  }

  Future<void> cancelarSolicitacao(int numero, String motivo) async {
    await _service.cancelarSolicitacao(numero,motivo);
    await obterSolicitacao(numero);
  }

  Future<void> atualizarSolicitacao() async {
    if (_state.solicitacaoEdicao == null) return;
    await _repo.atualizarSolicitacao(_state.solicitacaoEdicao!);
  }

  void atualizarSolicitacaoMemoria(Solicitacao solicitacao) {
    _state.solicitacaoEdicao = solicitacao;
  }

  void selecionarLivro(ResumoLivro livro) {
    LivroSolicitacao livroSolicitacao = LivroSolicitacao.criarDeResumoLivro(livro);
    if (_state.verificarSelecao(livro)) {
      print("Removendo livro da seleção... ${livro.numero}");
      _state.livrosSelecionados.removeWhere((element) => element.numero == livro.numero);
    } else {
      print("Adicionando livro à seleção... ${livro.numero}");
      _state.livrosSelecionados.add(livroSolicitacao);
    }
    print("Livro selecionado: ${_state.verificarSelecao(livro)}");
  }

  void removerLivro(LivroSolicitacao livro) {
    _state.livrosSelecionados.removeWhere((element) => element.numero == livro.numero);
  }

  void utilizarEnderecoPerfil() {
    _state.utilizarEnderecoPerfil = !_state.utilizarEnderecoPerfil;
  }
}
