import 'package:flutter/material.dart';
import 'package:leituramiga/component/livros.component.dart';
import 'package:leituramiga/component/usuarios.component.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/categoria_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/instituicao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/util/sobreposicao.util.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/barra_pesquisa/barra_pesquisa.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/filtro/layout_filtro.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_usuarios.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controllerPesquisa = TextEditingController();
  bool _exibindoLivros = true;

  final LivrosComponent _livrosComponent = LivrosComponent();
  final UsuariosComponent _usuariosComponent = UsuariosComponent();

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  void initState() {
    _livrosComponent.inicializar(
      LivroMockRepo(),
      CategoriaMockRepo(),
      InstituicaoMockRepo(),
      EnderecoMockRepo(),
      atualizar,
    );
    _usuariosComponent.inicializar(UsuarioMockRepo(), atualizar);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Notificacoes.mostrar("Bem-vindo ao LeiturAmiga!", Emoji.SUCESSO);
      await _livrosComponent.obterLivrosIniciais();
      await _livrosComponent.obterCategorias();
      await _livrosComponent.obterInstituicoes();
      await _livrosComponent.obterMunicipios();
      await _usuariosComponent.obterUsuariosIniciais();
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
        widgetNoCabecalho: _livrosComponent.carregando || _usuariosComponent.carregando
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !Responsive.larguraM(context)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BarraPesquisaWidget(
                        tema: tema,
                        aoPesquisar: (valor) {},
                        controller: _controllerPesquisa,
                      ),
                      SizedBox(width: tema.espacamento),
                      BotaoRedondoWidget(
                        tema: tema,
                        nomeSvg: 'filtro',
                        aoClicar: () => SobreposicaoUtil.exibir(context, obterFiltros),
                      ),
                    ],
                  )
                : null,
        alterarFonte: _alterarFonte,
        alterarTema: _alterarTema,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.larguraM(context))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BarraPesquisaWidget(
                        tema: tema,
                        aoPesquisar: (valor) {},
                        controller: _controllerPesquisa,
                      ),
                      SizedBox(width: tema.espacamento),
                      BotaoRedondoWidget(
                        tema: tema,
                        nomeSvg: 'filtro',
                        aoClicar: () => SobreposicaoUtil.exibir(context, obterFiltros),
                      ),
                    ],
                  ),
                SizedBox(height: tema.espacamento * 2),
                Center(
                  child: DuasEscolhasWidget(
                    tema: tema,
                    aoClicarPrimeiraEscolha: selecionarLivros,
                    aoClicarSegundaEscolha: selecionarUsuarios,
                    escolhas: const ["Livros", "Usuários"],
                  ),
                ),
                SizedBox(height: tema.espacamento * 2),
                TextoWidget(
                  tema: tema,
                  texto: "Encontre seu livro",
                  cor: Color(tema.baseContent),
                  tamanho: tema.tamanhoFonteXG,
                  weight: FontWeight.w500,
                ),
                SizedBox(height: tema.espacamento * 2),
                if (_exibindoLivros) ...[
                  Padding(
                    padding: EdgeInsets.only(right: tema.espacamento + 4),
                    child: GridLivroWidget(
                      tema: tema,
                      aoClicarLivro: (numeroLivro) async {
                        await _livrosComponent.obterLivro(numeroLivro);
                        Rota.navegarComArgumentos(
                          context,
                          LivrosRoute(
                            livro: _livrosComponent.livroSelecionado!,
                          ),
                        );
                      },
                      livros: _livrosComponent.itensPaginados,
                    ),
                  ),
                ],
                if (!_exibindoLivros)
                  Padding(
                    padding: EdgeInsets.only(right: tema.espacamento + 4),
                    child: GridUsuariosWidget(
                      tema: tema,
                      aoClicarUsuario: (numero) => Rota.navegarComArgumentos(
                        context,
                        UsuarioRoute(
                          numeroUsuario: 1,
                        ),
                      ),
                      usuarios: _usuariosComponent.itensPaginados,
                    ),
                  ),
                SizedBox(height: tema.espacamento * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selecionarUsuarios() async {
    setState(() => _exibindoLivros = false);
    await _usuariosComponent.obterUsuariosIniciais();
  }

  Future<void> selecionarLivros() async {
    setState(() => _exibindoLivros = true);
    await _livrosComponent.obterLivrosIniciais();
  }

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }

  Widget get obterFiltros {
    return LayoutFiltroWidget(
      tema: tema,
      carrergando: _livrosComponent.carregando,
      categoriaSelecionada: _livrosComponent.filtroState.numeroCategoria,
      categoriasPorId: _livrosComponent.categoriasPorNumero,
      selecionarCategoria: _livrosComponent.selecionarCategoria,
      instituicoesPorId: _livrosComponent.instituicoesPorNumero,
      selecionarInstituicao: _livrosComponent.selecionarInstituicao,
      selecionarMunicipio: _livrosComponent.selecionarMunicipio,
      municipiosPorId: _livrosComponent.municipiosPorNumero,
      selecionarTipoSolicitacao: _livrosComponent.selecionarTipoSolicitacao,
      aplicarFiltros: () => SobreposicaoUtil.fechar(context),
      usuario: !_exibindoLivros,
    );
  }
}
