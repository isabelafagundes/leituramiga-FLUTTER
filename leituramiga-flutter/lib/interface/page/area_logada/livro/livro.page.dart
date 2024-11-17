import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/livros.component.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao_pequeno.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/imagem.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';

@RoutePage()
class LivrosPage extends StatefulWidget {
  final int numeroLivro;

  const LivrosPage({super.key, @PathParam('numeroLivro') required this.numeroLivro});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  TipoSolicitacao? _tipoSolicitacaoSelecionado;
  final LivrosComponent _livrosComponent = LivrosComponent();
  String? imagemLivro;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  @override
  void initState() {
    _livrosComponent.inicializar(
      AppModule.livroRepo,
      AppModule.categoriaRepo,
      AppModule.instituicaoEnsinoRepo,
      AppModule.enderecoRepo,
      atualizar,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _livrosComponent.obterLivro(widget.numeroLivro);
      List<TipoSolicitacao>? tiposSolicitacao = _livrosComponent.livroSelecionado?.tiposSolicitacao;
      if (_livrosComponent.livroSelecionado != null && tiposSolicitacao?.length == 1) {
        _tipoSolicitacaoSelecionado = _livrosComponent.livroSelecionado!.tiposSolicitacao.first;
      }
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
        voltar: () => Rota.navegar(context, Rota.HOME),
        carregando: _livrosComponent.carregando || _livrosComponent.livroSelecionado == null,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: _livrosComponent.livroSelecionado == null
                ? const SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flex(
                        direction: Responsive.larguraM(context) ? Axis.vertical : Axis.horizontal,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                            Responsive.larguraM(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                ImagemWidget(
                                  tema: tema,
                                  visualizacao: true,
                                  imagemBase64: _livrosComponent.livroSelecionado!.imagemLivro,
                                  salvarImagem: (imagem64) => setState(() => imagemLivro = imagem64),
                                ),
                                SizedBox(height: tema.espacamento * 2),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextoWidget(
                                      texto: _livrosComponent.livroSelecionado?.nome ?? '',
                                      tema: tema,
                                      tamanho:
                                          Responsive.larguraP(context) ? tema.tamanhoFonteXG : tema.tamanhoFonteM * 2,
                                      weight: FontWeight.w500,
                                      cor: Color(tema.baseContent),
                                    ),
                                    SizedBox(height: tema.espacamento),
                                    TextoWidget(
                                      texto: _livrosComponent.livroSelecionado?.nomeAutor ?? '',
                                      tema: tema,
                                      tamanho:
                                      Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteXG,
                                      cor: Color(tema.baseContent),
                                    ),
                                    SizedBox(height: tema.espacamento / 2),
                                    if (Responsive.larguraM(context))
                                      SizedBox(
                                        width: 200,
                                        child: Divider(
                                          color: Color(tema.accent),
                                        ),
                                      ),
                                    SizedBox(height: tema.espacamento),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: tema.espacamento * 5),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextoWidget(
                                  texto: "Descrição: ",
                                  tema: tema,
                                  tamanho:
                                      Responsive.larguraP(context) ? tema.tamanhoFonteM + 2 : tema.tamanhoFonteM + 4,
                                  weight: FontWeight.w500,
                                ),
                                TextoWidget(
                                  texto: _livrosComponent.livroSelecionado?.descricao ?? '',
                                  tema: tema,
                                  align: TextAlign.justify,
                                  tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteM + 2,
                                  maxLines: 10,
                                  cor: Color(tema.baseContent),
                                ),
                                SizedBox(height: tema.espacamento * 2),
                                TextoWidget(
                                  texto: "Estado do livro: ",
                                  tema: tema,
                                  tamanho:
                                      Responsive.larguraP(context) ? tema.tamanhoFonteM + 2 : tema.tamanhoFonteM + 4,
                                  weight: FontWeight.w500,
                                ),
                                TextoWidget(
                                  texto: _livrosComponent.livroSelecionado?.descricaoEstado ?? '',
                                  tema: tema,
                                  tamanho: Responsive.larguraP(context) ? tema.tamanhoFonteM : tema.tamanhoFonteM + 2,
                                  cor: Color(tema.baseContent),
                                ),
                                SizedBox(height: tema.espacamento * 2),
                                Row(
                                  children: [
                                    TextoWidget(
                                      texto: "Categoria: ",
                                      tema: tema,
                                      tamanho: Responsive.larguraP(context)
                                          ? tema.tamanhoFonteM + 2
                                          : tema.tamanhoFonteM + 4,
                                      weight: FontWeight.w500,
                                    ),
                                    SizedBox(width: tema.espacamento),
                                    ChipWidget(
                                      tema: tema,
                                      texto: _livrosComponent.livroSelecionado?.nomeCategoria ?? '',
                                      cor: kCorPessego,
                                      corTexto: const Color(0xff464A52),
                                    ),
                                  ],
                                ),
                                SizedBox(height: tema.espacamento),
                                SizedBox(
                                  child: Divider(
                                    color: Color(tema.accent),
                                  ),
                                ),
                                SizedBox(height: tema.espacamento),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: Responsive.largura(context),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: tema.espacamento / 2),
                                        Flex(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: SizedBox(
                                                height: 30,
                                                child: TextoComIconeWidget(
                                                  tema: tema,
                                                  nomeSvg: 'usuario/user',
                                                  texto: _livrosComponent.livroSelecionado?.nomeUsuario ?? '',
                                                  tamanhoFonte: tema.tamanhoFonteM + 2,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: tema.espacamento / 2),
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  BotaoPequenoWidget(
                                                    tema: tema,
                                                    icone: Icon(
                                                      Icons.person,
                                                      color: Color(tema.baseContent),
                                                      size: 20,
                                                    ),
                                                    corFonte: Color(tema.baseContent),
                                                    corFundo: Color(tema.base200),
                                                    padding: EdgeInsets.symmetric(horizontal: tema.espacamento),
                                                    tamanhoFonte: tema.tamanhoFonteM,
                                                    aoClicar: () => Rota.navegarComArgumentos(
                                                      context,
                                                      UsuarioRoute(
                                                        identificador:
                                                            _livrosComponent.livroSelecionado?.emailUsuario ?? '',
                                                      ),
                                                    ),
                                                    label: "Ver perfil",
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: tema.espacamento / 2),
                                        TextoComIconeWidget(
                                          tema: tema,
                                          nomeSvg: 'academico/academic-cap',
                                          texto: _livrosComponent.livroSelecionado?.nomeInstituicao ?? 'Não informado',
                                          tamanhoFonte: tema.tamanhoFonteM + 2,
                                        ),
                                        SizedBox(height: tema.espacamento * 1.5),
                                        TextoComIconeWidget(
                                          tema: tema,
                                          nomeSvg: 'menu/map-pin-fill',
                                          texto: _livrosComponent.livroSelecionado?.nomeMunicipio ?? 'Não informado',
                                          tamanhoFonte: tema.tamanhoFonteM + 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: tema.espacamento * 2),
                      if (_livrosComponent.livroSelecionado?.emailUsuario != _autenticacaoState.usuario?.email.endereco)
                        Column(
                          children: [
                            TextoWidget(
                              texto: "Selecione o tipo de solicitação que deseja efetuar",
                              tema: tema,
                              cor: Color(tema.baseContent),
                            ),
                            SizedBox(height: tema.espacamento),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (_livrosComponent.livroSelecionado?.tiposSolicitacao
                                        .contains(TipoSolicitacao.TROCA) ??
                                    false) ...[
                                  Opacity(
                                    opacity: _autenticacaoState.usuario!.numeroDeLivros == 0 ? 0.5 : 1,
                                    child: IgnorePointer(
                                      ignoring: _autenticacaoState.usuario!.numeroDeLivros == 0,
                                      child: ChipWidget(
                                        tema: tema,
                                        cor: kCorPessego,
                                        texto: "Troca",
                                        corTexto: kCorFonte,
                                        ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.TROCA,
                                        aoClicar: () => _selecionarTipoSolicitacao(TipoSolicitacao.TROCA),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: tema.espacamento * 2),
                                ],
                                if (_livrosComponent.livroSelecionado!.tiposSolicitacao
                                    .contains(TipoSolicitacao.EMPRESTIMO)) ...[
                                  ChipWidget(
                                    tema: tema,
                                    cor: kCorVerde,
                                    texto: "Empréstimo",
                                    ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.EMPRESTIMO,
                                    corTexto: kCorFonte,
                                    aoClicar: () => _selecionarTipoSolicitacao(TipoSolicitacao.EMPRESTIMO),
                                  ),
                                  SizedBox(width: tema.espacamento * 2),
                                ],
                                if (_livrosComponent.livroSelecionado!.tiposSolicitacao
                                    .contains(TipoSolicitacao.DOACAO))
                                  ChipWidget(
                                    tema: tema,
                                    cor: kCorAzul,
                                    texto: "Doação",
                                    corTexto: kCorFonte,
                                    ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.DOACAO,
                                    aoClicar: () => _selecionarTipoSolicitacao(TipoSolicitacao.DOACAO),
                                  ),
                              ],
                            ),
                            SizedBox(height: tema.espacamento * 2),
                            BotaoWidget(
                              tema: tema,
                              texto: 'Criar solicitação',
                              icone: Icon(
                                Icons.chevron_right,
                                color: Color(tema.base200),
                              ),
                              aoClicar: () {
                                if (_tipoSolicitacaoSelecionado == null) {
                                  Notificacoes.mostrar("Selecione um tipo de solicitação", Emoji.ALERTA);
                                  return;
                                }
                                Rota.navegarComArgumentos(
                                  context,
                                  CriarSolicitacaoRoute(
                                    numeroLivro: _livrosComponent.livroSelecionado!.numero,
                                    tipoSolicitacao: _tipoSolicitacaoSelecionado!.id,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: tema.espacamento * 4),
                          ],
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _selecionarTipoSolicitacao(TipoSolicitacao tipo) {
    setState(() => _tipoSolicitacaoSelecionado = _tipoSolicitacaoSelecionado == tipo ? null : tipo);
  }
}
