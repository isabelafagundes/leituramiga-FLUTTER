import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/livros.component.dart';
import 'package:leituramiga/state/filtros.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/categoria_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/instituicao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_livro.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CriarLivroPage extends StatefulWidget {
  const CriarLivroPage({super.key});

  @override
  State<CriarLivroPage> createState() => _CriarLivroPageState();
}

class _CriarLivroPageState extends State<CriarLivroPage> {
  final LivrosComponent _livrosComponent = LivrosComponent();
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerAutor = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerEstadoFisico = TextEditingController();

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  FiltroState get _filtroState => FiltroState.instancia;

  @override
  void initState() {
    super.initState();
    _livrosComponent.inicializar(
      LivroMockRepo(),
      CategoriaMockRepo(),
      InstituicaoMockRepo(),
      EnderecoMockRepo(),
      atualizar,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _livrosComponent.obterCategorias();
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
        voltar: ()=> Rota.navegar(context, Rota.HOME),
        carregando: _livrosComponent.carregando || _livrosComponent.categoriasPorNumero.isEmpty,
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
                  controllerNome: controllerNome,
                  controllerDescricao: controllerDescricao,
                  controllerEstadoFisico: controllerEstadoFisico,
                  categoriasPorId: _livrosComponent.categoriasPorNumero,
                  salvarImagem: (imagem64) => print(imagem64),
                  selecionarCategoria: (categoria) => setState(() => _livrosComponent.selecionarCategoria(categoria)),
                  numeroCategoria: _filtroState.numeroCategoria,
                  controllerAutor: controllerAutor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
