import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_perfil_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_comentarios.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
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
                    horizontal: Responsive.larguraP(context) ? tema.espacamento : tema.espacamento * 8,
                  ),
                  child: Stack(
                    children: [
                      CardPerfilUsuarioWidget(
                        tema: tema,
                        descricao: "Sou estudante de ADS e tenho interesse em engenharia de software.",
                        nomeUsuario: "@usuario",
                        nomeInstituicao: "FATEC Satana de Parnaíba",
                        nomeCidade: "Cajamar",
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: BotaoRedondoWidget(
                          tema: tema,
                          nomeSvg: 'filtro',
                          icone: Icon(
                            Icons.edit,
                            color: Color(tema.baseContent),
                          ),
                          aoClicar: () => Rota.navegar(context, Rota.EDITAR_PERFIL),
                        ),
                      ),
                    ],
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
                    escolhas: const ["Livros", "Comentários"],
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
                        if (_exibindoLivros)
                          BotaoPequenoWidget(
                            tema: tema,
                            aoClicar: _exibindoLivros ? () => Rota.navegar(context, Rota.CRIAR_LIVRO) : () {},
                            label: _exibindoLivros ? "Adicionar livro" : "Criar comentário",
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: tema.espacamento * 2),
                if (_exibindoLivros) ...[
                  GridLivroWidget(
                    tema: tema,
                    livros: [],
                    aoClicarLivro: (numeroLivro) async {},
                  ),
                ],
                if (!_exibindoLivros) ...[
                  GridComentarioWidget(
                    tema: tema,
                    comentariosPorId: {},
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
