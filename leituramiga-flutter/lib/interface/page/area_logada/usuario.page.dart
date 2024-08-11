import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_perfil_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_comentarios.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  bool _exibindoLivros = true;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        alterarFonte: _alterarFonte,
        alterarTema: _alterarTema,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 170,
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.larguraP(context) ? tema.espacamento * 2 : tema.espacamento * 8,
                  ),
                  child: CardPerfilUsuarioWidget(
                    tema: tema,
                    descricao: "Sou estudante de ADS e tenho interesse em engenharia de software.",
                    nomeUsuario: "@usuario",
                    nomeInstituicao: "FATEC Satana de Parnaíba",
                    nomeCidade: "Cajamar",
                  ),
                ),
                SizedBox(
                  height: tema.espacamento * 2,
                ),
                Center(
                  child: DuasEscolhasWidget(
                    tema: tema,
                    aoClicarPrimeiraEscolha: () => setState(() => _exibindoLivros = true),
                    aoClicarSegundaEscolha: () => setState(() => _exibindoLivros = false),
                    escolhas: ["Livros", "Comentários"],
                  ),
                ),
                SizedBox(height: tema.espacamento * 2),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 3),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(tema.neutral).withOpacity(.1),
                                offset: const Offset(0, 2),
                                blurRadius: 2,
                              ),
                            ],
                            color: Color(tema.accent),
                            borderRadius: BorderRadius.circular(tema.borderRadiusXG),
                          ),
                          child: Center(
                            child: TextoWidget(
                              tema: tema,
                              weight: FontWeight.w500,
                              cor: Color(tema.base200),
                              texto: _exibindoLivros ? "Criar solicitação" : "Criar comentário",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: tema.espacamento * 2),
                if (_exibindoLivros) ...[
                  GridLivroWidget(
                    tema: tema,
                    aoClicarLivro: () => Rota.navegar(context, Rota.LIVRO),
                  ),
                ],
                if (!_exibindoLivros) ...[
                  GridComentarioWidget(
                    tema: tema,
                    aoClicarComentario: () {},
                  ),
                ]
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
