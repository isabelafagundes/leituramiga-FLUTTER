import 'package:flutter/material.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/comentario_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_perfil_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_comentarios.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class UsuarioPage extends StatefulWidget {
  final String identificador;

  const UsuarioPage({super.key, @PathParam("username") required this.identificador});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final UsuarioComponent _usuarioComponent = UsuarioComponent();

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  bool _exibindoLivros = true;

  @override
  void initState() {
    super.initState();
    _usuarioComponent.inicializar(
      UsuarioMockRepo(),
      ComentarioMockRepo(),
      EnderecoMockRepo(),
      LivroMockRepo(),
      atualizar,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _usuarioComponent.obterUsuario(widget.identificador);
      await _usuarioComponent.obterComentarios(widget.identificador);
      await _usuarioComponent.obterLivrosUsuario();
    });
  }

  void atualizar() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        atualizar: atualizar,
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
                  child: CardPerfilUsuarioWidget(
                    tema: tema,
                    descricao: _usuarioComponent.usuarioSelecionado?.descricao ?? "",
                    nomeUsuario: _usuarioComponent.usuarioSelecionado?.nome ?? "",
                    nomeInstituicao: _usuarioComponent.usuarioSelecionado?.nomeInstituicao ?? "",
                    nomeCidade: _usuarioComponent.usuarioSelecionado?.nomeMunicipio ?? "",
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
                        BotaoPequenoWidget(
                          tema: tema,
                          aoClicar: () {},
                          label: _exibindoLivros ? "Criar solicitação" : "Criar comentário",
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: tema.espacamento * 2),
                if (_exibindoLivros) ...[
                  GridLivroWidget(
                    tema: tema,
                    livros: _usuarioComponent.itensPaginados,
                    aoClicarLivro: (livro) async {
                      await _usuarioComponent.obterLivro(livro.numero);
                      Rota.navegarComArgumentos(
                        context,
                        LivrosRoute(
                          numeroLivro: _usuarioComponent.livroSelecionado!.numero,
                        ),
                      );
                    },
                  ),
                ],
                if (!_exibindoLivros) ...[
                  GridComentarioWidget(
                    tema: tema,
                    comentariosPorId: _usuarioComponent.comentariosPorNumero,
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
}
