import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/usuario/comentario_perfil.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/duas_escolhas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_comentarios.widget.dart';
import 'package:projeto_leituramiga/interface/widget/grid/grid_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class UsuarioPage extends StatefulWidget {
  final String identificador;

  const UsuarioPage({super.key, @PathParam("username") required this.identificador});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final UsuarioComponent _usuarioComponent = UsuarioComponent();
  TextEditingController controllerComentario = TextEditingController();

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

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
      await _buscarDados();
    });
  }

  void atualizar() => setState(() {});

  Usuario? get _usuario => _usuarioComponent.usuarioSelecionado;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        voltar: () => Rota.navegar(context, Rota.HOME),
        carregando: _usuarioComponent.carregando || _usuario == null || _temaState.temaSelecionado == null,
        atualizar: atualizar,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              children: _usuario == null
                  ? []
                  : [
                      ConteudoUsuarioWidget(
                        usuario: _usuario!,
                        tema: tema,
                      ),
                      SizedBox(height: tema.espacamento * 4),
                      Center(
                        child: DuasEscolhasWidget(
                          tema: tema,
                          aoClicarPrimeiraEscolha: () => setState(() => _exibindoLivros = true),
                          aoClicarSegundaEscolha: () => setState(() => _exibindoLivros = false),
                          escolhas: ["Livros", "Comentários"],
                        ),
                      ),
                      SizedBox(height: tema.espacamento * 2),
                      if (!_exibindoLivros)
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
                                  padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
                                  aoClicar: _exibirPopUpComentario,
                                  corFundo:Color(tema.base200),
                                  icone: Icon(
                                    Icons.add,
                                    color: Color(tema.baseContent),
                                    size: 20,
                                  ),
                                  corFonte: Color(tema.baseContent),
                                  label: "Criar comentário",
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
                            if (_usuarioComponent.livroSelecionado != null)
                              Rota.navegarComArgumentos(
                                context,
                                LivrosRoute(
                                  numeroLivro: _usuarioComponent.livroSelecionado!.numero!,
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

  Widget obterPopUp(BuildContext context, Function() aoClicar) {
    return PopUpPadraoWidget(
      tema: tema,
      conteudo: Container(
        padding: EdgeInsets.all(tema.espacamento * 2),
        height: Responsive.larguraM(context) ? Responsive.altura(context) : 690,
        width: 450,
        child: Column(
          children: [
            Responsive.larguraM(context)
                ? Row(
                    children: [
                      BotaoRedondoWidget(
                        tema: tema,
                        nomeSvg: 'seta/chevron-left',
                        aoClicar: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      TextoWidget(
                        texto: "Comentário",
                        tamanho: tema.tamanhoFonteXG,
                        weight: FontWeight.w500,
                        tema: tema,
                      ),
                      const Spacer(),
                      Opacity(
                        opacity: 0,
                        child: IgnorePointer(
                          child: BotaoRedondoWidget(
                            tema: tema,
                            nomeSvg: 'filtro',
                            icone: Icon(
                              Icons.edit,
                              color: Color(tema.baseContent),
                            ),
                            aoClicar: () {},
                          ),
                        ),
                      ),
                    ],
                  )
                : TextoWidget(
                    texto: "Comentário",
                    tamanho: tema.tamanhoFonteXG + 4,
                    weight: FontWeight.w500,
                    tema: tema,
                  ),
            SvgWidget(
              nomeSvg: "garota_comentando",
              altura: 300,
            ),
            SizedBox(height: tema.espacamento * 2),
            TextoWidget(
              texto: "Que tal compartilhar sua opinião sobre esse usuário?",
              tema: tema,
              align: TextAlign.center,
              tamanho: tema.tamanhoFonteM,
              weight: FontWeight.w500,
            ),
            SizedBox(height: tema.espacamento * 2),
            InputWidget(
              tema: tema,
              label: "Comentário",
              controller: controllerComentario,
              onChanged: (valor) {},
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              corTexto: Color(tema.baseContent),
              texto: "Fechar",
              aoClicar: () => Navigator.pop(context),
              icone: Icon(
                Icons.close,
                color: Color(tema.baseContent),
              ),
              corFundo: Color(tema.base200),
            ),
            SizedBox(height: tema.espacamento * 2),
            BotaoWidget(
              tema: tema,
              corTexto: Color(tema.base200),
              texto: "Enviar",
              aoClicar: aoClicar,
              icone: Icon(
                Icons.send,
                color: Color(tema.base200),
              ),
              corFundo: Color(tema.accent),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exibirPopUpComentario() async {
    await showDialog(
      context: context,
      builder: (context) => obterPopUp(
        context,
        () async {
          await _enviarComentario();
          Navigator.pop(context);
        },
      ),
    );
    await _buscarDados();
  }

  Future<void> _buscarDados() async {
    await _usuarioComponent.obterUsuario(widget.identificador);
    await _usuarioComponent.obterComentarios(_usuarioComponent.usuarioSelecionado!.email.endereco);
    await _usuarioComponent.obterLivrosUsuario();
  }

  Future<void> _enviarComentario() async {
    await notificarCasoErro(() async {
      _usuarioComponent.cadastrarComentarioMemoria(_obterComentario);
      await _usuarioComponent.cadastrarComentario();
      controllerComentario.clear();
      atualizar();
    });
  }

  ComentarioPerfil get _obterComentario {
    return ComentarioPerfil.criar(
      _autenticacaoState.usuario!.email.endereco,
      _usuarioComponent.usuarioSelecionado!.email.endereco,
      controllerComentario.text,
    );
  }
}
