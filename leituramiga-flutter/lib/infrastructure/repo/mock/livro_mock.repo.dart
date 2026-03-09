import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/instituicao_mock.repo.dart';

class LivroMockRepo extends LivroRepo {
  static LivroMockRepo? _instancia;

  LivroMockRepo._();

  static LivroMockRepo get instancia {
    _instancia ??= LivroMockRepo._();
    return _instancia!;
  }

  final List<Livro> _livros = [
    Livro.carregar(
      1,
      'O Pequeno Principe',
      'Antoine de Saint-Exupery',
      'Classico sobre amizade e descobertas.',
      'Livro conservado, sem rasgos.',
      1,
      [TipoSolicitacao.DOACAO, TipoSolicitacao.TROCA],
      'isabela@gmail.com',
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      'isabela',
      'FATEC Santana de Parnaiba',
      'Cajamar',
      'Infantil',
      null,
    ),
    Livro.carregar(
      2,
      'Clean Code',
      'Robert C. Martin',
      'Boas praticas para desenvolvimento de software.',
      'Algumas marcacoes a lapis.',
      2,
      [TipoSolicitacao.EMPRESTIMO, TipoSolicitacao.TROCA],
      'kaua@gmail.com',
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      'kauaguedes',
      'FATEC Santana de Parnaiba',
      'Santana de Parnaiba',
      'Tecnologia',
      null,
    ),
    Livro.carregar(
      3,
      'Dom Casmurro',
      'Machado de Assis',
      'Romance brasileiro classico.',
      'Capa em bom estado.',
      5,
      [TipoSolicitacao.DOACAO],
      'joao@gmail.com',
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      'joao_silva',
      'Universidade Paulista',
      'Sao Paulo',
      'Romance',
      null,
    ),
    Livro.carregar(
      4,
      'Duna',
      'Frank Herbert',
      'Ficcao cientifica com politica e ecologia.',
      'Paginas amareladas pelo tempo.',
      8,
      [TipoSolicitacao.EMPRESTIMO, TipoSolicitacao.TROCA],
      'maria@gmail.com',
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      'mariazinha',
      'Universidade Nove de Julho',
      'Sao Caetano do Sul',
      'Ficcao Cientifica',
      null,
    ),
  ];

  @override
  Future<void> atualizarLivro(Livro livro) async {
    if (livro.numero == null) {
      int novoNumero = (_livros.map((e) => e.numero ?? 0).fold<int>(0, (a, b) => a > b ? a : b)) + 1;
      _livros.add(_comNumero(livro, novoNumero));
      return;
    }

    int indice = _livros.indexWhere((item) => item.numero == livro.numero);
    if (indice == -1) {
      _livros.add(livro);
      return;
    }

    _livros[indice] = livro;
  }

  @override
  Future<void> desativarLivro(int numero) async {
    int indice = _livros.indexWhere((livro) => livro.numero == numero);
    if (indice == -1) throw LivroNaoEncontrado();
    _livros.removeAt(indice);
  }

  @override
  Future<Livro> obterLivro(int numero) async {
    return _livros.firstWhere((livro) => livro.numero == numero, orElse: () => throw LivroNaoEncontrado());
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
    Iterable<Livro> filtrados = _livros;

    if (emailUsuario != null && emailUsuario.trim().isNotEmpty) {
      String email = emailUsuario.trim().toLowerCase();
      filtrados = filtrados.where((livro) => livro.emailUsuario.toLowerCase() == email);
    }

    if (numeroCategoria != null) {
      filtrados = filtrados.where((livro) => livro.numeroCategoria == numeroCategoria);
    }

    if (tipo != null) {
      filtrados = filtrados.where((livro) => livro.tiposSolicitacao.contains(tipo));
    }

    if (pesquisa != null && pesquisa.trim().isNotEmpty) {
      String termo = pesquisa.trim().toLowerCase();
      filtrados = filtrados.where((livro) {
        return livro.nome.toLowerCase().contains(termo) ||
            livro.nomeAutor.toLowerCase().contains(termo) ||
            livro.descricao.toLowerCase().contains(termo);
      });
    }

    if (numeroMunicipio != null) {
      String? nomeMunicipio = EnderecoMockRepo.instancia.municipios
          .where((municipio) => municipio.numero == numeroMunicipio)
          .firstOrNull
          ?.nome;

      if (nomeMunicipio != null) {
        filtrados = filtrados.where((livro) => livro.nomeMunicipio == nomeMunicipio);
      }
    }

    if (numeroInstituicao != null) {
      String? nomeInstituicao = InstituicaoMockRepo.instancia.instituicoes
          .where((instituicao) => instituicao.numero == numeroInstituicao)
          .firstOrNull
          ?.nome;

      if (nomeInstituicao != null) {
        filtrados = filtrados.where((livro) => livro.nomeInstituicao == nomeInstituicao);
      }
    }

    List<ResumoLivro> resumos = filtrados.map((livro) => livro.criarResumoLivro()).toList();

    int inicio = numeroPagina * limite;
    if (inicio >= resumos.length) return [];

    int fim = inicio + limite;
    if (fim > resumos.length) fim = resumos.length;

    return resumos.sublist(inicio, fim);
  }

  Livro _comNumero(Livro livro, int numero) {
    return Livro.carregar(
      numero,
      livro.nome,
      livro.nomeAutor,
      livro.descricao,
      livro.descricaoEstado,
      livro.numeroCategoria,
      livro.tiposSolicitacao,
      livro.emailUsuario,
      livro.dataCriacao,
      livro.dataUltimaSolicitacao,
      livro.status,
      livro.nomeUsuario,
      livro.nomeInstituicao,
      livro.nomeMunicipio,
      livro.nomeCategoria,
      livro.imagemLivro,
    );
  }
}
