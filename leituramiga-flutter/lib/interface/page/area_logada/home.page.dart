import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
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
  bool _exibindoLivros = true;
  final TextEditingController _controllerPesquisa = TextEditingController();

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        widgetNoCabecalho: !Responsive.larguraM(context)
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
                    aoClicar: () {
                      SobreposicaoUtil.exibir(
                        context,
                        LayoutFiltroWidget(
                          tema: tema,
                          aplicarFiltros: () {},
                          usuario: !_exibindoLivros,
                        ),
                      );
                    },
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
                        aoClicar: () {
                          SobreposicaoUtil.exibir(
                            context,
                            LayoutFiltroWidget(
                              tema: tema,
                              aplicarFiltros: () {},
                              usuario: !_exibindoLivros,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                SizedBox(height: tema.espacamento * 2),
                Center(
                  child: DuasEscolhasWidget(
                    tema: tema,
                    aoClicarPrimeiraEscolha: () => setState(() => _exibindoLivros = true),
                    aoClicarSegundaEscolha: () => setState(() => _exibindoLivros = false),
                    escolhas: ["Livros", "Usuários"],
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
                  GridLivroWidget(
                    tema: tema,
                    aoClicarLivro: () => Rota.navegar(context, Rota.LIVRO),
                  ),
                ],
                if (!_exibindoLivros)
                  GridUsuariosWidget(
                    tema: tema,
                    aoClicarUsuario: () => Rota.navegar(context, Rota.USUARIO),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }
}
