import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:leituramiga/repo/solicitacao.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';

class SolicitacaoMockRepo extends SolicitacaoRepo {
  static SolicitacaoMockRepo? _instancia;

  SolicitacaoMockRepo._();

  static SolicitacaoMockRepo get instancia {
    _instancia ??= SolicitacaoMockRepo._();
    return _instancia!;
  }

  final List<Solicitacao> _solicitacoes = [];

  void _inicializarSeNecessario() {
    if (_solicitacoes.isNotEmpty) return;

    final enderecoRepo = EnderecoMockRepo.instancia;

    Livro livro1 = _livroBasico(1, 'O Pequeno Principe', 'isabela@gmail.com', 'isabela');
    Livro livro2 = _livroBasico(2, 'Clean Code', 'kaua@gmail.com', 'kauaguedes');
    Livro livro3 = _livroBasico(3, 'Dom Casmurro', 'joao@gmail.com', 'joao_silva');

    _solicitacoes.addAll([
      Solicitacao.carregar(
        1,
        livro1.emailUsuario,
        'kaua@gmail.com',
        LivrosSolicitacao.criar('kaua@gmail.com', [])..adicionar(livro1),
        null,
        FormaEntrega.CORREIOS,
        DataHora.hoje(),
        DataHora.hoje(),
        null,
        DataHora.hoje(),
        'Primeiro contato por chat.',
        enderecoRepo.obterEnderecoPorEmail('kaua@gmail.com'),
        false,
        TipoSolicitacao.TROCA,
        TipoStatusSolicitacao.PENDENTE,
        null,
        null,
        null,
        enderecoRepo.obterEnderecoPorEmail(livro1.emailUsuario),
      ),
      Solicitacao.carregar(
        2,
        livro2.emailUsuario,
        'isabela@gmail.com',
        LivrosSolicitacao.criar('isabela@gmail.com', [])..adicionar(livro2),
        null,
        FormaEntrega.PRESENCIAL,
        DataHora.hoje(),
        DataHora.hoje(),
        null,
        DataHora.hoje(),
        'Entrega presencial no campus.',
        enderecoRepo.obterEnderecoPorEmail('isabela@gmail.com'),
        false,
        TipoSolicitacao.DOACAO,
        TipoStatusSolicitacao.EM_ANDAMENTO,
        DataHora.hoje(),
        null,
        null,
        enderecoRepo.obterEnderecoPorEmail(livro2.emailUsuario),
      ),
      Solicitacao.carregar(
        3,
        livro3.emailUsuario,
        'isabela@gmail.com',
        LivrosSolicitacao.criar('isabela@gmail.com', [])..adicionar(livro3),
        null,
        FormaEntrega.CORREIOS,
        DataHora.ontem(),
        DataHora.ontem(),
        null,
        DataHora.hoje(),
        'Concluida com sucesso.',
        enderecoRepo.obterEnderecoPorEmail('isabela@gmail.com'),
        false,
        TipoSolicitacao.EMPRESTIMO,
        TipoStatusSolicitacao.FINALIZADA,
        DataHora.ontem(),
        null,
        null,
        enderecoRepo.obterEnderecoPorEmail(livro3.emailUsuario),
      ),
    ]);
  }

  @override
  Future<void> atualizarSolicitacao(Solicitacao solicitacao) async {
    _inicializarSeNecessario();

    final enderecoRepo = EnderecoMockRepo.instancia;

    Endereco? enderecoSolicitanteAtual = enderecoRepo.obterEnderecoPorEmail(
      solicitacao.emailUsuarioSolicitante,
    );

    Endereco? enderecoProprietarioAtual = enderecoRepo.obterEnderecoPorEmail(
      solicitacao.emailUsuarioProprietario,
    );

    if (solicitacao.enderecoSolicitante != null) {
      enderecoSolicitanteAtual = solicitacao.enderecoSolicitante;
      enderecoRepo.atualizarEndereco(solicitacao.enderecoSolicitante!);
    }

    if (solicitacao.enderecoReceptor != null) {
      enderecoProprietarioAtual = solicitacao.enderecoReceptor;
      enderecoRepo.atualizarEndereco(solicitacao.enderecoSolicitante!);
    }

    final solicitacaoComEnderecoAtual = Solicitacao.carregar(
      solicitacao.numero,
      solicitacao.emailUsuarioProprietario,
      solicitacao.emailUsuarioSolicitante,
      solicitacao.livrosSolicitante,
      solicitacao.livrosUsuarioReceptor,
      solicitacao.formaEntrega,
      solicitacao.dataCriacao,
      solicitacao.dataEntrega,
      solicitacao.dataDevolucao,
      solicitacao.dataAtualizacao,
      solicitacao.informacoesAdicionais,
      enderecoSolicitanteAtual,
      solicitacao.enderecoUsuarioCriador,
      solicitacao.tipoSolicitacao,
      solicitacao.status,
      solicitacao.dataAceite,
      solicitacao.motivoRecusa,
      solicitacao.codigoRastreamento,
      enderecoProprietarioAtual,
    );

    if (solicitacao.numero == null) {
      int novoNumero = (_solicitacoes.map((e) => e.numero ?? 0).fold<int>(0, (a, b) => a > b ? a : b)) + 1;
      _solicitacoes.add(_comNumero(solicitacaoComEnderecoAtual, novoNumero));
      return;
    }

    int indice = _solicitacoes.indexWhere((item) => item.numero == solicitacao.numero);
    if (indice == -1) {
      _solicitacoes.add(solicitacaoComEnderecoAtual);
    } else {
      _solicitacoes[indice] = solicitacaoComEnderecoAtual;
    }
  }

  @override
  Future<Solicitacao> obterSolicitacao(int numero) async {
    _inicializarSeNecessario();

    final solicitacao = _solicitacoes.firstWhere((item) => item.numero == numero);
    final enderecoRepo = EnderecoMockRepo.instancia;

    return Solicitacao.carregar(
      solicitacao.numero,
      solicitacao.emailUsuarioProprietario,
      solicitacao.emailUsuarioSolicitante,
      solicitacao.livrosSolicitante,
      solicitacao.livrosUsuarioReceptor,
      solicitacao.formaEntrega,
      solicitacao.dataCriacao,
      solicitacao.dataEntrega,
      solicitacao.dataDevolucao,
      solicitacao.dataAtualizacao,
      solicitacao.informacoesAdicionais,
      enderecoRepo.obterEnderecoPorEmail(solicitacao.emailUsuarioSolicitante),
      solicitacao.enderecoUsuarioCriador,
      solicitacao.tipoSolicitacao,
      solicitacao.status,
      solicitacao.dataAceite,
      solicitacao.motivoRecusa,
      solicitacao.codigoRastreamento,
      enderecoRepo.obterEnderecoPorEmail(solicitacao.emailUsuarioProprietario),
    );
  }

  @override
  Future<List<ResumoSolicitacao>> obterSolicitacoes(String emailUsuario,
      [int numeroPagina = 0, int limite = 50]) async {
    _inicializarSeNecessario();

    List<Solicitacao> filtradas = _solicitacoes.where((solicitacao) {
      bool participa =
          solicitacao.emailUsuarioSolicitante == emailUsuario || solicitacao.emailUsuarioProprietario == emailUsuario;
      bool historico = solicitacao.status == TipoStatusSolicitacao.FINALIZADA ||
          solicitacao.status == TipoStatusSolicitacao.CANCELADA ||
          solicitacao.status == TipoStatusSolicitacao.RECUSADA;
      return participa && !historico;
    }).toList();

    return _paginacaoResumo(filtradas, numeroPagina, limite);
  }

  @override
  Future<List<ResumoSolicitacao>> obterHistorico(
    String emailUsuario,
    String? dataInicio,
    String? dataFim, [
    int numeroPagina = 0,
    int limite = 50,
  ]) async {
    _inicializarSeNecessario();

    DataHora? inicio = dataInicio == null ? null : DataHora.deString('$dataInicio 00:00:00');
    DataHora? fim = dataFim == null ? null : DataHora.deString('$dataFim 23:59:59');

    List<Solicitacao> filtradas = _solicitacoes.where((solicitacao) {
      bool participa =
          solicitacao.emailUsuarioSolicitante == emailUsuario || solicitacao.emailUsuarioProprietario == emailUsuario;
      if (!participa) return false;

      bool historico = solicitacao.status == TipoStatusSolicitacao.FINALIZADA ||
          solicitacao.status == TipoStatusSolicitacao.CANCELADA ||
          solicitacao.status == TipoStatusSolicitacao.RECUSADA;
      if (!historico) return false;

      DataHora referencia = solicitacao.dataAtualizacao ?? solicitacao.dataCriacao ?? DataHora.hoje();
      if (inicio != null && referencia.ehAntesDe(inicio)) return false;
      if (fim != null && referencia.ehDepoisDe(fim)) return false;
      return true;
    }).toList();

    return _paginacaoResumo(filtradas, numeroPagina, limite);
  }

  Future<void> aceitarSolicitacao(int numero, LivrosSolicitacao? livrosTroca, Endereco? segundoEndereco) async {
    _inicializarSeNecessario();
    Solicitacao atual = await obterSolicitacao(numero);
    if (atual.status != TipoStatusSolicitacao.PENDENTE) throw SolicitacaoRecusada();

    _substituir(
      numero,
      Solicitacao.carregar(
        atual.numero,
        atual.emailUsuarioProprietario,
        atual.emailUsuarioSolicitante,
        atual.livrosSolicitante,
        livrosTroca ?? atual.livrosUsuarioReceptor,
        atual.formaEntrega,
        atual.dataCriacao,
        atual.dataEntrega,
        atual.dataDevolucao,
        DataHora.hoje(),
        atual.informacoesAdicionais,
        atual.enderecoSolicitante,
        atual.enderecoUsuarioCriador,
        atual.tipoSolicitacao,
        TipoStatusSolicitacao.EM_ANDAMENTO,
        DataHora.hoje(),
        null,
        atual.codigoRastreamento,
        segundoEndereco ?? atual.enderecoReceptor,
      ),
    );
  }

  Future<void> recusarSolicitacao(int numero, String motivo) async {
    _inicializarSeNecessario();
    Solicitacao atual = await obterSolicitacao(numero);
    if (atual.status != TipoStatusSolicitacao.PENDENTE) throw SolicitacaoRecusada();

    _substituir(
      numero,
      Solicitacao.carregar(
        atual.numero,
        atual.emailUsuarioProprietario,
        atual.emailUsuarioSolicitante,
        atual.livrosSolicitante,
        atual.livrosUsuarioReceptor,
        atual.formaEntrega,
        atual.dataCriacao,
        atual.dataEntrega,
        atual.dataDevolucao,
        DataHora.hoje(),
        atual.informacoesAdicionais,
        atual.enderecoSolicitante,
        atual.enderecoUsuarioCriador,
        atual.tipoSolicitacao,
        TipoStatusSolicitacao.RECUSADA,
        atual.dataAceite,
        motivo,
        atual.codigoRastreamento,
        atual.enderecoReceptor,
      ),
    );
  }

  Future<void> cancelarSolicitacao(int numero, String motivo) async {
    _inicializarSeNecessario();
    Solicitacao atual = await obterSolicitacao(numero);

    _substituir(
      numero,
      Solicitacao.carregar(
        atual.numero,
        atual.emailUsuarioProprietario,
        atual.emailUsuarioSolicitante,
        atual.livrosSolicitante,
        atual.livrosUsuarioReceptor,
        atual.formaEntrega,
        atual.dataCriacao,
        atual.dataEntrega,
        atual.dataDevolucao,
        DataHora.hoje(),
        atual.informacoesAdicionais,
        atual.enderecoSolicitante,
        atual.enderecoUsuarioCriador,
        atual.tipoSolicitacao,
        TipoStatusSolicitacao.CANCELADA,
        atual.dataAceite,
        motivo,
        atual.codigoRastreamento,
        atual.enderecoReceptor,
      ),
    );
  }

  Future<void> finalizarSolicitacao(int numero) async {
    _inicializarSeNecessario();
    Solicitacao atual = await obterSolicitacao(numero);
    if (atual.status == TipoStatusSolicitacao.FINALIZADA) throw SolicitacaoFinalizada();

    _substituir(
      numero,
      Solicitacao.carregar(
        atual.numero,
        atual.emailUsuarioProprietario,
        atual.emailUsuarioSolicitante,
        atual.livrosSolicitante,
        atual.livrosUsuarioReceptor,
        atual.formaEntrega,
        atual.dataCriacao,
        atual.dataEntrega,
        atual.dataDevolucao,
        DataHora.hoje(),
        atual.informacoesAdicionais,
        atual.enderecoSolicitante,
        atual.enderecoUsuarioCriador,
        atual.tipoSolicitacao,
        TipoStatusSolicitacao.FINALIZADA,
        atual.dataAceite,
        atual.motivoRecusa,
        atual.codigoRastreamento,
        atual.enderecoReceptor,
      ),
    );
  }

  List<ResumoSolicitacao> _paginacaoResumo(List<Solicitacao> filtradas, int numeroPagina, int limite) {
    List<ResumoSolicitacao> resumos = filtradas.map(_resumir).toList();

    int inicio = numeroPagina * limite;
    if (inicio >= resumos.length) return [];

    int fim = inicio + limite;
    if (fim > resumos.length) fim = resumos.length;

    return resumos.sublist(inicio, fim);
  }

  ResumoSolicitacao _resumir(Solicitacao solicitacao) {
    return ResumoSolicitacao.carregar(
      solicitacao.numero,
      solicitacao.enderecoSolicitante ?? solicitacao.enderecoReceptor,
      _nomeUsuarioPorEmail(solicitacao.emailUsuarioSolicitante),
      solicitacao.dataEntrega,
      solicitacao.dataDevolucao,
      solicitacao.tipoSolicitacao,
    );
  }

  String _nomeUsuarioPorEmail(String email) {
    String identificador = email.split('@').first;
    if (identificador.isEmpty) return email;
    return identificador;
  }

  Solicitacao _comNumero(Solicitacao solicitacao, int numero) {
    return Solicitacao.carregar(
      numero,
      solicitacao.emailUsuarioProprietario,
      solicitacao.emailUsuarioSolicitante,
      solicitacao.livrosSolicitante,
      solicitacao.livrosUsuarioReceptor,
      solicitacao.formaEntrega,
      solicitacao.dataCriacao,
      solicitacao.dataEntrega,
      solicitacao.dataDevolucao,
      solicitacao.dataAtualizacao,
      solicitacao.informacoesAdicionais,
      solicitacao.enderecoSolicitante,
      solicitacao.enderecoUsuarioCriador,
      solicitacao.tipoSolicitacao,
      solicitacao.status,
      solicitacao.dataAceite,
      solicitacao.motivoRecusa,
      solicitacao.codigoRastreamento,
      solicitacao.enderecoReceptor,
    );
  }

  Livro _livroBasico(int numero, String titulo, String email, String usuario) {
    return Livro.carregar(
      numero,
      titulo,
      'Autor',
      'Descricao',
      'Estado bom',
      1,
      [TipoSolicitacao.TROCA],
      email,
      DataHora.hoje(),
      DataHora.hoje(),
      TipoStatusLivro.DISPONIVEL,
      usuario,
      'Instituicao',
      'Cidade',
      'Categoria',
      null,
    );
  }

  void _substituir(int numero, Solicitacao solicitacao) {
    int indice = _solicitacoes.indexWhere((item) => item.numero == numero);
    if (indice == -1) return;
    _solicitacoes[indice] = solicitacao;
  }
}
