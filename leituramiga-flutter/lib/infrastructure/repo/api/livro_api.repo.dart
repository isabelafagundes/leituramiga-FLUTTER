import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class LivroApiRepo extends LivroRepo with ConfiguracaoApiState {
  static LivroApiRepo? _instancia;

  LivroApiRepo._();

  static LivroApiRepo get instancia {
    _instancia ??= LivroApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<void> atualizarLivro(Livro livro) async {
    print(livro.paraMapa());
    if (livro.numero == null) {
      await _criarLivro(livro);
    } else {
      await _atualizarLivro(livro);
    }
  }

  Future<void> _criarLivro(Livro livro) async {
    await _client.post("$host/livro/criar", data: livro.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  Future<void> _atualizarLivro(Livro livro) async {
    await _client.post("$host/livro/${livro.id}", data: livro.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<void> desativarLivro(int numero) async {
    await _client.delete("$host/livro/$numero").catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<Livro> obterLivro(int numero) async {
    return await _client.get("$host/livro/$numero").catchError((erro) {
      throw erro;
    }).then((response) => Livro.carregarDeMapa(response.data));
  }

  @override
  Future<List<ResumoLivro>> obterLivros({
    int numeroPagina = 0,
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    TipoSolicitacao? tipo,
    String? pesquisa,
    int? numeroCategoria,
    String? emailUsuario,
  }) async {
    Map<String, dynamic> filtros = _obterFiltros(
      numeroPagina: numeroPagina,
      limite: limite,
      numeroMunicipio: numeroMunicipio,
      numeroInstituicao: numeroInstituicao,
      tipo: tipo,
      pesquisa: pesquisa,
      numeroCategoria: numeroCategoria,
      emailUsuario: emailUsuario,
    );
    print(filtros);
    return await _client.post("$host/livros", data: filtros).catchError((erro) {
      throw erro;
    }).then((response) => (response.data as List).map((e) => ResumoLivro.carregarDeMapa(e)).toList());
  }

  Map<String, dynamic> _obterFiltros({
    int numeroPagina = 0,
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    TipoSolicitacao? tipo,
    String? pesquisa,
    int? numeroCategoria,
    String? emailUsuario,
  }) {
    Map<String, dynamic> filtros = {
      "numeroPagina": numeroPagina,
      "tamanhoPagina": limite,
    };
    filtros["numeroCidade"] = numeroMunicipio;
    filtros["numeroInstituicao"] = numeroInstituicao;
    filtros["pesquisa"] = pesquisa;
    filtros["numeroCategoria"] = numeroCategoria;
    filtros["emailUsuario"] = emailUsuario == null || emailUsuario.isEmpty ? null : emailUsuario;
    filtros["tipoSolicitacao"] = tipo?.id;
    return filtros;
  }
}
