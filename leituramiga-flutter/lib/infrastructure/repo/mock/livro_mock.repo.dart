import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/livro.repo.dart';

class LivroMockRepo extends LivroRepo {
  List<ResumoLivro> livros = [
    ResumoLivro.carregar(
      1,
      "Infantil",
      "isabela",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "O pequeno príncipe",
    ),
    ResumoLivro.carregar(
      2,
      "Tecnologia",
      "isabela",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "Algumas páginas estão amassadas, porém o livro está em bom estado",
      "Engenharia de Software",
    ),
    ResumoLivro.carregar(
      3,
      "Fantasia",
      "kauaguedes",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "Paginas amareladas e capa com marcas de uso",
      "Alice no País das Maravilhas",
    ),
    ResumoLivro.carregar(
      4,
      "Terror",
      "kauaguedes",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "Nunca usei e está intacto",
      "O Iluminado",
    ),
    ResumoLivro.carregar(
      5,
      "Romance",
      "kauaguedes",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Orgulho e Preconceito",
    ),
    ResumoLivro.carregar(
      6,
      "Aventura",
      "kauaguedes",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "O Senhor dos Anéis",
    ),
    ResumoLivro.carregar(
      7,
      "Ficção Científica",
      "kauaguedes",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Fundação",
    ),
    ResumoLivro.carregar(
      8,
      "Biografia",
      "kauaguedes",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Steve Jobs",
    ),
    ResumoLivro.carregar(
      9,
      "História",
      "kauaguedes",
      1,
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Uma Breve História do Tempo",
    ),
  ];

  @override
  Future<void> atualizarLivro(Livro livro) {
    // TODO: implement atualizarLivro
    throw UnimplementedError();
  }

  @override
  Future<void> excluirLivro(int numero) {
    // TODO: implement excluirLivro
    throw UnimplementedError();
  }

  @override
  Future<Livro> obterLivro(int numero) async {
    return Livro.carregar(
      1,
      "O pequeno príncipe",
      "Antoine de Saint-Exupéry",
      "O livro conta a história de um piloto que cai no deserto do Saara e encontra um pequeno príncipe, que veio de um pequeno asteroide, o asteroide B-612.",
      "O livro está em bom estado",
      1,
      [TipoSolicitacao.DOACAO, TipoSolicitacao.TROCA],
      1,
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      "isabela",
      "FATEC Santana de Parnaíba",
      "Cajamar",
    );
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
    int? numeroUsuario,
  }) {
    return Future.value(livros);
  }
}
