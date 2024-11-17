import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';

class PaginacaoLivroUseCase {
  final PaginacaoState<ResumoLivro> _state;
  final LivroRepo _repo;

  const PaginacaoLivroUseCase(this._state, this._repo);

  Future<void> obterLivrosIniciais([String? emailUsuario]) async {
    _state.reiniciar();
    List<ResumoLivro> pagina = await _repo.obterLivros(emailUsuario: emailUsuario ?? '');
    _state.paginar(pagina);
  }

  Future<void> obterLivrosPorPesquisa(String pesquisa) async {
    _state.reiniciar();
    _state.pesquisou = true;
    _state.pesquisa = pesquisa;
    List<ResumoLivro> pagina = await _repo.obterLivros(pesquisa: pesquisa);
    print(pagina.length);
    _state.paginar(pagina);
  }

  Future<void> obterLivrosPaginados({
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    TipoSolicitacao? tipo,
    String? pesquisa,
    int? numeroCategoria,
    String? emailUsuario,
    bool reiniciar = false,
  }) async {
    if (reiniciar) _state.reiniciar();
    List<ResumoLivro> pagina = await _repo.obterLivros(
      numeroPagina: _state.pagina,
      limite: limite,
      numeroMunicipio: numeroMunicipio,
      numeroInstituicao: numeroInstituicao,
      tipo: tipo,
      pesquisa: pesquisa,
      numeroCategoria: numeroCategoria,
      emailUsuario: emailUsuario,
    );
    _state.paginar(pagina, limite, pesquisa ?? '');
  }
}
