import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/repo/comentario.repo.dart';
import 'package:leituramiga/repo/endereco.repo.dart';
import 'package:leituramiga/repo/livro.repo.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:leituramiga/state/comentario.state.dart';
import 'package:leituramiga/state/endereco.state.dart';
import 'package:leituramiga/state/livro.state.dart';
import 'package:leituramiga/state/solicitacao.state.dart';
import 'package:leituramiga/state/super/paginacao.state.dart';
import 'package:leituramiga/state/super/state.dart';
import 'package:leituramiga/state/usuario.state.dart';
import 'package:leituramiga/usecase/comentario.usecase.dart';
import 'package:leituramiga/usecase/endereco.usecase.dart';
import 'package:leituramiga/usecase/livro.usecase.dart';
import 'package:leituramiga/usecase/paginacao_livro.usecase.dart';
import 'package:leituramiga/usecase/usuario.usecase.dart';

class UsuarioComponent extends State
    with UsuarioState, SolicitacaoState, ComentarioState, PaginacaoState<ResumoLivro>, EnderecoState, LivroState {
  late final UsuarioUseCase _usuarioUseCase;
  late final ComentarioUseCase _comentarioUseCase;
  late final PaginacaoLivroUseCase _paginacaoLivroUseCase;
  late final EnderecoUseCase _enderecoUseCase;
  late final LivroUseCase _livroUseCase;

  void inicializar(
    UsuarioRepo usuarioRepo,
    ComentarioRepo comentarioRpo,
    EnderecoRepo enderecoRepo,
    LivroRepo livroRepo,
    Function() atualizar,
  ) {
    _livroUseCase = LivroUseCase(livroRepo, this);
    _paginacaoLivroUseCase = PaginacaoLivroUseCase(this, livroRepo);
    _enderecoUseCase = EnderecoUseCase(this, enderecoRepo);
    _usuarioUseCase = UsuarioUseCase(usuarioRepo, this);
    _comentarioUseCase = ComentarioUseCase(comentarioRpo, this);
    super.atualizar = atualizar;
  }

  Future<void> obterUsuario(int numero) async {
    await executar(
      rotina: () async => _usuarioUseCase.obterUsuario(numero),
      mensagemErro: "Não foi possível obter o usuário",
    );
  }

  Future<void> obterUsuarioSolicitacao(int numero) async {
    await executar(
      rotina: () async => _usuarioUseCase.obterUsuarioSolicitacao(numero),
      mensagemErro: "Não foi possível obter o usuário",
    );
  }

  Future<void> obterComentarios(int numero) async {
    await executar(
      rotina: () async => _comentarioUseCase.obterComentarios(numero),
      mensagemErro: "Não foi possível obter os comentários",
    );
  }

  void cadastrarComentarioMemoria(ComentarioPerfil comentario) {
    executar(
      rotina: () async => _comentarioUseCase.cadastrarComentarioMemoria(comentario),
      mensagemErro: "Não foi possível cadastrar comentário em memória",
    );
  }

  Future<void> cadastrarComentario() async {
    executar(
      rotina: () async => _comentarioUseCase.cadastrarComentario(),
      mensagemErro: "Não foi possível cadastrar o comentário",
    );
  }

  Future<void> obterLivrosUsuario() async {
    await executar(
      rotina: () async {
        if (usuarioSelecionado == null) return;
        int numero = usuarioSelecionado!.numero!;
        return _paginacaoLivroUseCase.obterLivrosIniciais(numero);
      },
      mensagemErro: "Não foi possível obter os livros do usuário",
    );
  }

  Future<void> obterLivro(int numero) async {
    await executar(
      rotina: () async => _livroUseCase.obterLivro(numero),
      mensagemErro: "Não foi possível obter o livro",
    );
  }

  Future<void> obterLivrosUsuarioPaginado() async {
    await executar(
      rotina: () async {
        if (usuarioSelecionado == null) return;
        int numero = usuarioSelecionado!.numero!;
        return _paginacaoLivroUseCase.obterLivrosPaginados(limite: limite, numeroUsuario: numero);
      },
      mensagemErro: "Não foi possível obter os livros do usuário",
    );
  }

  void atualizarUsuarioMemoria(Usuario usuario) {
    executar(
      rotina: () async => _usuarioUseCase.atualizarUsuarioMemoria(usuario),
      mensagemErro: "Não foi possível editar o usuário",
    );
  }

  Future<void> atualizarUsuario() async {
    executar(
      rotina: () async => _usuarioUseCase.atualizarUsuario(),
      mensagemErro: "Não foi possível atualizar o usuário",
    );
  }

  Future<void> excluirUsuario(int numero) async {
    await executar(
      rotina: () async => _usuarioUseCase.excluirUsuario(numero),
      mensagemErro: "Não foi possível excluir o usuário",
    );
  }

  Future<void> atualizarEndereco(int numeroUsuario) async {
    await executar(
      rotina: () async => _enderecoUseCase.atualizarEndereco(numeroUsuario),
      mensagemErro: "Não foi possível atualizar o endereço",
    );
  }

  void atualizarEnderecoMemoria(Endereco endereco) {
    executar(
      rotina: () => _enderecoUseCase.atualizarEnderecoEmMemoria(endereco),
      mensagemErro: "Não foi possível atualizar o endereço",
    );
  }

  Future<void> obterCidades() async {
    executar(
      rotina: () => _enderecoUseCase.obterMunicipios(),
      mensagemErro: "Não foi possível atualizar o endereço",
    );
  }
}
