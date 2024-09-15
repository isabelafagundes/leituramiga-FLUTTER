import 'package:flutter/material.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/comentario_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';
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
      int numeroUsuario = AutenticacaoState.instancia.usuario!.numero!;
      await _usuarioComponent.obterUsuario(numeroUsuario);
      await _usuarioComponent.obterLivrosUsuario();
      await _usuarioComponent.obterComentarios(numeroUsuario);
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
        carregando: false,
        voltar: ()=> Rota.navegar(context, Rota.HOME),
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
                        descricao: _usuarioComponent.usuarioSelecionado?.descricao??'',
                        nomeUsuario: _usuarioComponent.usuarioSelecionado?.nomeUsuario??'',
                        nomeInstituicao: _usuarioComponent.usuarioSelecionado?.instituicaoDeEnsino.nome??'',
                        nomeCidade: _usuarioComponent.usuarioSelecionado?.nomeMunicipio??"",
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
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
                    livros: _usuarioComponent.itensPaginados,
                    aoClicarLivro: (numeroLivro) async {},
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

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }
}
