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
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "O pequeno príncipe",
      "Antoine de Saint-Exupéry",
    ),
    ResumoLivro.carregar(
      2,
      "Tecnologia",
      "isabela",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "Algumas páginas estão amassadas, porém o livro está em bom estado",
      "Engenharia de Software",
      "Ian Sommerville",
    ),
    ResumoLivro.carregar(
      3,
      "Fantasia",
      "kauaguedes",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "Paginas amareladas e capa com marcas de uso",
      "Alice no País das Maravilhas",
      "Lewis Carroll",
    ),
    ResumoLivro.carregar(
      4,
      "Terror",
      "kauaguedes",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "Nunca usei e está intacto",
      "O Iluminado",
      "Stephen King",
    ),
    ResumoLivro.carregar(
      5,
      "Romance",
      "kauaguedes",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Orgulho e Preconceito",
      "Jane Austen",
    ),
    ResumoLivro.carregar(
      6,
      "Aventura",
      "kauaguedes",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "O Senhor dos Anéis",
      "J. R. R. Tolkien",
    ),
    ResumoLivro.carregar(
      7,
      "Ficção Científica",
      "kauaguedes",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Fundação",
      "Isaac Asimov",
    ),
    ResumoLivro.carregar(
      8,
      "Biografia",
      "kauaguedes",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Steve Jobs",
      "Walter Isaacson",
    ),
    ResumoLivro.carregar(
      9,
      "História",
      "kauaguedes",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "O livro está em bom estado",
      "Uma Breve História do Tempo",
      "Stephen Hawking",
    ),
  ];

  @override
  Future<void> atualizarLivro(Livro livro) {
    // TODO: implement atualizarLivro
    throw UnimplementedError();
  }

  @override
  Future<void> deletarLivro(int numero) {
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
      "isabela",
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      "isabela",
      "FATEC Santana de Parnaíba",
      "Cajamar",
      "",
    );
  }

  @override
  Future<List<ResumoLivro>> obterLivros({int numeroPagina = 0, int limite = 18, int? numeroMunicipio, int? numeroInstituicao, TipoSolicitacao? tipo, String? pesquisa, int? numeroCategoria, String? emailUsuario}) {
    // TODO: implement obterLivros
    throw UnimplementedError();
  }


}
