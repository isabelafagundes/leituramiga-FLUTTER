import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_comentarios.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';

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
      AppModule.usuarioRepo,
      AppModule.comentarioRepo,
      AppModule.enderecoRepo,
      AppModule.livroRepo,
      atualizar,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String email = AutenticacaoState.instancia.usuario!.email.endereco;
      await _usuarioComponent.obterPerfil();
      await _usuarioComponent.obterLivrosUsuario();
      await _usuarioComponent.obterComentarios(email);
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
        carregando: _usuarioComponent.carregando || _usuarioComponent.usuarioSelecionado == null,
        voltar: () => Rota.navegar(context, Rota.HOME),
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              children: _usuarioComponent.usuarioSelecionado == null
                  ? []
                  : [
                      ConteudoUsuarioWidget(
                        usuario: _usuarioComponent.usuarioSelecionado!,
                        tema: tema,
                        widgetInferior: Row(
                          children: [
                            BotaoPequenoWidget(
                              tema: tema,
                              icone: Icon(
                                Icons.edit,
                                color: Color(tema.base200),
                              ),
                              corFonte: Color(tema.base200),
                              padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 1.5),
                              aoClicar: () => Rota.navegar(context, Rota.EDITAR_PERFIL),
                              label: "Editar",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: tema.espacamento * 4),
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
                                  corFonte: Color(tema.base200),
                                  icone: Icon(Icons.add, color: Color(tema.base200)),
                                  padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
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
                          aoClicarLivro: (livro) async => Rota.navegarComArgumentos(
                            context,
                            EditarLivroRoute(codigoLivro: livro.numero),
                          ),
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
