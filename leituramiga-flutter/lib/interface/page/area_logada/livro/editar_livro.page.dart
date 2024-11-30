import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/livros.component.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/livro/tipo_status_livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_livro.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

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
                  widgetInferior: BotaoWidget(
                    tema: tema,
                    texto: 'Excluir livro',
                    nomeIcone: "seta/arrow-long-right",
                    corFundo: Color(tema.error),
                    icone: Icon(Icons.delete, color: Color(tema.base200)),
                    aoClicar: _excluirLivro,
                  ),
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

  Future<void> _excluirLivro() async {
    bool? excluir = await showDialog(
        context: context, builder: (context) => _obterPopUpPadrao(context, "Deseja realmente excluir o livro?"));
    if (excluir == null) return;
    if (excluir)
      await notificarCasoErro(() async {
        await _livrosComponent.excluirLivro(_livrosComponent.livroSelecionado!.numero!);
        Notificacoes.mostrar("Livro excluído com sucesso!", Emoji.SUCESSO);
        Rota.navegar(context, Rota.HOME);
      });
  }

  Widget _obterPopUpPadrao(BuildContext context, String texto) {
    return PopUpPadraoWidget(
      tema: tema,
      naoRedimensionar: true,
      conteudo: Container(
        height: 320,
        width: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: tema.espacamento * 4),
            Icon(
              Icons.warning_rounded,
              color: Color(tema.baseContent),
              size: 80,
            ),
            SizedBox(height: tema.espacamento * 3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
              child: TextoWidget(
                tema: tema,
                texto: texto,
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BotaoWidget(
                  tema: tema,
                  icone: Icon(
                    Icons.delete,
                    color: Color(tema.base200),
                  ),
                  corFundo: Color(tema.error),
                  texto: "Excluir",
                  aoClicar: () => Navigator.of(context).pop(true),
                ),
                SizedBox(height: tema.espacamento * 2),
                BotaoWidget(
                  tema: tema,
                  icone: SvgWidget(
                    nomeSvg: 'seta/arrow-long-left',
                    cor: Color(tema.baseContent),
                  ),
                  texto: "Voltar",
                  corFundo: Color(tema.base200),
                  corTexto: Color(tema.baseContent),
                  aoClicar: () => Navigator.of(context).pop(false),
                ),
              ],
            ),
          ],
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
