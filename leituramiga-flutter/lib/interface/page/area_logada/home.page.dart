import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/livros.component.dart';
import 'package:leituramiga/component/usuarios.component.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:leituramiga/state/filtros.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/util/sobreposicao.util.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/barra_pesquisa/barra_pesquisa.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/filtro/layout_filtro.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_usuarios.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

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
  bool _carregando = false;
  final LivrosComponent _livrosComponent = LivrosComponent();
  final UsuariosComponent _usuariosComponent = UsuariosComponent();

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  FiltroState get _filtroState => FiltroState.instancia;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  void initState() {
    _livrosComponent.inicializar(
      AppModule.livroRepo,
      AppModule.categoriaRepo,
      AppModule.instituicaoEnsinoRepo,
      AppModule.enderecoRepo,
      atualizar,
    );
    _usuariosComponent.inicializar(
      AppModule.usuarioRepo,
      atualizar,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => _carregando = true);
      await _livrosComponent.obterLivrosIniciais();
      await _livrosComponent.obterCategorias();
      await _livrosComponent.obterInstituicoes();
      await _usuariosComponent.obterUsuariosIniciais();
      setState(() => _carregando = false);
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
        atualizar: atualizar,
        exibirPerfil: true,
        carregando: _livrosComponent.carregando || _usuariosComponent.carregando || _carregando,
        widgetNoCabecalho: IgnorePointer(
          ignoring: _livrosComponent.carregando || _usuariosComponent.carregando || _carregando,
          child: !Responsive.larguraM(context)
              ? SizedBox(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BarraPesquisaWidget(
                        tema: tema,
                        aoPesquisar: _pesquisar,
                        controller: _controllerPesquisa,
                      ),
                      SizedBox(width: tema.espacamento),
                      BotaoPequenoWidget(
                        tema: tema,
                        altura: 40,
                        label: "Filtrar",
                        corFonte: Color(tema.baseContent),
                        corFundo: Color(tema.base200),
                        icone: SvgWidget(nomeSvg: 'filtro', cor: Color(tema.baseContent), altura: 16),
                        aoClicar: () => SobreposicaoUtil.exibir(context, obterFiltros),
                      ),
                      if (_livrosComponent.filtroState.temFiltros) ...[
                        SizedBox(width: tema.espacamento),
                        BotaoRedondoWidget(
                          tema: tema,
                          aoClicar: _limparFiltros,
                          nomeSvg: "limpar_icon",
                          tamanhoIcone: 22,
                        ),
                      ]
                    ],
                  ),
                )
              : null,
        ),
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
                        tamanhoIcone: 22,
                        nomeSvg: 'filtro',
                        aoClicar: () => SobreposicaoUtil.exibir(context, obterFiltros),
                      ),
                    ],
                  ),
                SizedBox(height: tema.espacamento * 2),
                Center(
                  child: DuasEscolhasWidget(
                    tema: tema,
                    chave: _exibindoLivros ? 0 : 1,
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
                  tamanho: tema.tamanhoFonteXG + 4,
                  weight: FontWeight.w500,
                ),
                SizedBox(height: tema.espacamento * 2),
                if (_exibindoLivros) ...[
                  GridLivroWidget(
                    tema: tema,
                    aoClicarLivro: (livro) async {
                      if (_autenticacaoState.usuario == null) {
                        return Notificacoes.mostrar("Efetue o login para acessar o livro.");
                      }

                      await _livrosComponent.obterLivro(livro.numero);
                      if (livro.emailUsuario.endereco == _autenticacaoState.usuario!.email.endereco) {
                        return Rota.navegarComArgumentos(
                          context,
                          EditarLivroRoute(
                            codigoLivro: _livrosComponent.livroSelecionado!.numero!,
                          ),
                        );
                      }
                      Rota.navegarComArgumentos(
                        context,
                        LivrosRoute(
                          numeroLivro: _livrosComponent.livroSelecionado!.numero!,
                        ),
                      );
                    },
                    livros: _livrosComponent.itensPaginados,
                  ),
                ],
                if (!_exibindoLivros)
                  GridUsuariosWidget(
                    tema: tema,
                    aoClicarUsuario: (username) {
                      if (_autenticacaoState.usuario == null) {
                        return Notificacoes.mostrar("Efetue o login para acessar o perfil do usuário.");
                      }

                      if (username == _autenticacaoState.usuario!.nomeUsuario) {
                        return Rota.navegar(context, Rota.PERFIL);
                      }
                      Rota.navegarComArgumentos(
                        context,
                        UsuarioRoute(identificador: username),
                      );
                    },
                    usuarios: _usuariosComponent.itensPaginados,
                  ),
                SizedBox(height: tema.espacamento * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pesquisar(String valor) async {
    await notificarCasoErro(() async {
      _exibindoLivros
          ? await _livrosComponent.realizarPesquisaLivros(valor)
          : await _usuariosComponent.realizarPesquisaDeUsuarios(valor);
    });
  }

  Future<void> _limparFiltros() async {
    setState(() => _carregando = true);
    _filtroState.limparFiltros();
    _controllerPesquisa.clear();
    setState(() {
      _usuariosComponent.reiniciar();
      _livrosComponent.reiniciar();
    });
    await _livrosComponent.obterLivrosIniciais();
    await _usuariosComponent.obterUsuariosIniciais();
    _controllerPesquisa.clear();
    setState(() => _carregando = false);
  }

  Future<void> selecionarUsuarios() async {
    _controllerPesquisa.clear();
    await _limparFiltros();
    setState(() => _exibindoLivros = false);
  }

  Future<void> selecionarLivros() async {
    setState(() => _carregando = true);
    _controllerPesquisa.clear();
    await _limparFiltros();
    setState(() => _exibindoLivros = true);
  }

  Widget get obterFiltros {
    return LayoutFiltroWidget(
      tema: tema,
      limparFiltros: _limparFiltros,
      selecionarEstado: _selecionarEstado,
      carrergando: _livrosComponent.carregando,
      categoriaSelecionada: _livrosComponent.filtroState.numeroCategoria,
      categoriasPorId: _livrosComponent.categoriasPorNumero,
      selecionarCategoria: _livrosComponent.selecionarCategoriaFiltro,
      instituicoesPorId: _livrosComponent.instituicoesPorNumero,
      selecionarInstituicao: _livrosComponent.selecionarInstituicao,
      selecionarMunicipio: _livrosComponent.selecionarMunicipio,
      municipiosPorId: _livrosComponent.municipiosPorNumero,
      selecionarTipoSolicitacao: _livrosComponent.selecionarTipoSolicitacao,
      aplicarFiltros: _aplicarFiltros,
      usuario: !_exibindoLivros,
    );
  }

  Future<void> _aplicarFiltros() async {
    setState(() => _carregando = true);
    _exibindoLivros
        ? await _livrosComponent.obterLivrosPaginados(true)
        : await _usuariosComponent.obterUsuariosPaginados(true);
    setState(() => _carregando = false);
    return SobreposicaoUtil.fechar(context);
  }

  Future<void> _selecionarEstado(UF uf) async {
    _livrosComponent.selecionarEstado(uf);
    await _livrosComponent.obterMunicipios(uf);
    setState(() {});
  }
}
