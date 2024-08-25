import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';

class PaginacaoLivroUseCase {
  final PaginacaoState<ResumoLivro> _state;
  final LivroRepo _repo;

  const PaginacaoLivroUseCase(this._state, this._repo);

  Future<void> obterLivrosIniciais([int? numeroUsuario]) async {
    _state.reiniciar();
    List<ResumoLivro> pagina = await _repo.obterLivros(numeroUsuario: numeroUsuario);
    _state.paginar(pagina);
  }

  Future<void> obterLivrosPaginados({
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    TipoSolicitacao? tipo,
    String? pesquisa,
    int? numeroCategoria,
    int? numeroUsuario,
  }) async {
    List<ResumoLivro> pagina = await _repo.obterLivros(
      numeroPagina: _state.pagina,
      limite: limite,
      numeroMunicipio: numeroMunicipio,
      numeroInstituicao: numeroInstituicao,
      tipo: tipo,
      pesquisa: pesquisa,
      numeroCategoria: numeroCategoria,
      numeroUsuario: numeroUsuario,
    );
    _state.paginar(pagina, limite, pesquisa ?? '');
  }
}
