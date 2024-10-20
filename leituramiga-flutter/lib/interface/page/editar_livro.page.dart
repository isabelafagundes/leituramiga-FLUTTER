import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/livros.component.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:leituramiga/state/filtros.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_livro.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';

@RoutePage()
class EditarLivroPage extends StatefulWidget {
  final int codigoLivro;

  const EditarLivroPage({super.key, @PathParam("codigoLivro") required this.codigoLivro});

  @override
  State<EditarLivroPage> createState() => _EditarLivroPageState();
}

class _EditarLivroPageState extends State<EditarLivroPage> {
  final LivrosComponent _livrosComponent = LivrosComponent();
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerAutor = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerEstadoFisico = TextEditingController();
  List<TipoSolicitacao> tiposSolicitacao = [];
  String? imagemLivro;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  FiltroState get _filtroState => FiltroState.instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  @override
  void initState() {
    super.initState();
    _livrosComponent.inicializar(
      AppModule.livroRepo,
      AppModule.categoriaRepo,
      AppModule.instituicaoEnsinoRepo,
      AppModule.enderecoRepo,
      atualizar,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _livrosComponent.obterCategorias();
      await _livrosComponent.obterLivro(widget.codigoLivro);
      _preencherControllers(_livrosComponent.livroSelecionado!);
    });
  }

  void atualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        voltar: () => Rota.navegar(context, Rota.HOME),
        carregando: _livrosComponent.carregando ||
            _livrosComponent.categoriasPorNumero.isEmpty ||
            _temaState.temaSelecionado == null ||
            _livrosComponent.livroSelecionado == null,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormularioLivroWidget(
                  tema: tema,
                  edicao: true,
                  imagem: imagemLivro,
                  criarLivro: _criarLivro,
                  controllerNome: controllerNome,
                  controllerDescricao: controllerDescricao,
                  controllerEstadoFisico: controllerEstadoFisico,
                  categoriasPorId: _livrosComponent.categoriasPorNumero,
                  salvarImagem: (imagem64) => setState(() => imagemLivro = imagem64),
                  selecionarCategoria: (categoria) => setState(() => _livrosComponent.selecionarCategoria(categoria)),
                  numeroCategoria: _livrosComponent.categoriaSelecionada?.numero,
                  controllerAutor: controllerAutor,
                  tiposSolicitacao: tiposSolicitacao,
                  selecionarTipoSolicitacao: (tipo) => setState(
                    () => tiposSolicitacao.contains(tipo) ? tiposSolicitacao.remove(tipo) : tiposSolicitacao.add(tipo),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _preencherControllers(Livro livro) {
    controllerNome.text = livro.nome;
    controllerAutor.text = livro.nomeAutor;
    controllerDescricao.text = livro.descricao;
    controllerEstadoFisico.text = livro.descricaoEstado;
    tiposSolicitacao = livro.tiposSolicitacao;
    imagemLivro = livro.imagemLivro;
    _livrosComponent.selecionarCategoria(_livrosComponent.categoriasPorNumero[livro.numeroCategoria]!);
    setState(() {});
  }

  bool get camposPreenchidos =>
      controllerNome.text.isNotEmpty &&
      controllerAutor.text.isNotEmpty &&
      controllerDescricao.text.isNotEmpty &&
      controllerEstadoFisico.text.isNotEmpty;

  Livro get livro => Livro.carregar(
        widget.codigoLivro,
        controllerNome.text,
        controllerAutor.text,
        controllerDescricao.text,
        controllerEstadoFisico.text,
        _livrosComponent.categoriaSelecionada!.numero,
        tiposSolicitacao,
        _autenticacaoState.usuario!.email.endereco,
        _livrosComponent.livroSelecionado!.dataCriacao,
        _livrosComponent.livroSelecionado!.dataUltimaSolicitacao,
        TipoStatusLivro.DISPONIVEL,
        "",
        "",
        "",
        _livrosComponent.categoriaSelecionada!.descricao,
        imagemLivro,
      );

  Future<void> _criarLivro() async {
    notificarCasoErro(() async {
      if (camposPreenchidos) {
        _livrosComponent.salvarLivroMemoria(livro);
        await _livrosComponent.atualizarLivro();
        Rota.navegar(context, Rota.PERFIL);
      } else {
        Notificacoes.mostrar("Preencha todos os campos");
      }
    });
  }
}
