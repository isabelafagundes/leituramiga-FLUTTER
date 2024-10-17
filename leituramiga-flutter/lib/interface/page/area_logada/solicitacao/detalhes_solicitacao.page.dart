import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_livros_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_resumo_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_selecao_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/contudo_contato.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/tab.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class DetalhesSolicitacaoPage extends StatefulWidget {
  final int numeroSolicitacao;

  const DetalhesSolicitacaoPage({
    super.key,
    @PathParam('numeroSolicitacao') required this.numeroSolicitacao,
  });

  @override
  State<DetalhesSolicitacaoPage> createState() => _DetalhesSolicitacaoPageState();
}

class _DetalhesSolicitacaoPageState extends State<DetalhesSolicitacaoPage> {
  final SolicitacaoComponent _solicitacaoComponent = SolicitacaoComponent();
  final UsuarioComponent _usuarioComponent = UsuarioComponent();
  final TextEditingController controllerInformacoes = TextEditingController();
  final TextEditingController controllerRua = TextEditingController();
  final TextEditingController controllerBairro = TextEditingController();
  final TextEditingController controllerCep = TextEditingController();
  final TextEditingController controllerNumero = TextEditingController();
  final TextEditingController controllerComplemento = TextEditingController();
  final TextEditingController controllerCidade = TextEditingController();
  final TextEditingController controllerEstado = TextEditingController();
  final TextEditingController controllerDataEntrega = TextEditingController();
  final TextEditingController controllerDataDevolucao = TextEditingController();
  final TextEditingController controllerHoraEntrega = TextEditingController();
  final TextEditingController controllerHoraDevolucao = TextEditingController();
  final TextEditingController controllerFrete = TextEditingController();
  final TextEditingController controllerFormaEntrega = TextEditingController();
  final TextEditingController controllerMotivo = TextEditingController();

  Solicitacao? get solicitacao => _solicitacaoComponent.solicitacaoSelecionada;

  DetalhesSolicitacao _abaSelecionada = DetalhesSolicitacao.INFORMACOES;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  void initState() {
    super.initState();
    _solicitacaoComponent.inicializar(
      AppModule.solicitacaoRepo,
      AppModule.solicitacaoService,
      AppModule.notificacaoRepo,
      atualizar,
    );
    _usuarioComponent.inicializar(
      AppModule.usuarioRepo,
      AppModule.comentarioRepo,
      AppModule.enderecoRepo,
      AppModule.livroRepo,
      atualizar,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _solicitacaoComponent.obterSolicitacao(widget.numeroSolicitacao);
      await _usuarioComponent.obterUsuario(solicitacao!.emailUsuarioCriador);
      await _usuarioComponent.obterUsuarioSolicitacao(solicitacao!.emailUsuarioProprietario);
      await _usuarioComponent.obterLivrosUsuario();
      UF? uf = solicitacao?.endereco?.municipio.estado;
      await _usuarioComponent.obterCidades(uf!);
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
        carregando: _solicitacaoComponent.carregando || solicitacao == null || _usuarioComponent.carregando,
        voltar: () => Rota.navegar(context, Rota.HOME),
        child: SingleChildScrollView(
          physics:
              _abaSelecionada == DetalhesSolicitacao.SELECAO_LIVROS || _abaSelecionada == DetalhesSolicitacao.LIVROS
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
          child: _usuarioComponent.usuarioSelecionado == null || solicitacao == null
              ? SizedBox()
              : SizedBox(
                  height: Responsive.altura(context) * .88,
                  child: _abaSelecionada == DetalhesSolicitacao.SELECAO_LIVROS
                      ? ConteudoSelecaoLivrosWidget(
                          tema: tema,
                          aceitarSolicitacao: _aceitarSolicitacao,
                          textoPopUp: "Deseja selecionar os livros e aceitar a solicitação?",
                          aoClicarLivro: _solicitacaoComponent.selecionarLivro,
                          aoSelecionarLivro: _solicitacaoComponent.selecionarLivro,
                          verificarSelecao: _usuarioComponent.verificarSelecao,
                          livros: _usuarioComponent.itensPaginados,
                          navegarParaSolicitacao: () => _atualizarAbaSelecionada(DetalhesSolicitacao.LIVROS),
                        )
                      : Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (solicitacao?.status == TipoStatusSolicitacao.EM_ANDAMENTO) ...[
                              SizedBox(
                                child: BotaoWidget(
                                  tema: tema,
                                  corTexto: kCorFonte,
                                  altura: 45,
                                  largura: 140,
                                  texto: "Editar",
                                  aoClicar: () => Rota.navegarComArgumentos(
                                    context,
                                    VisualizarSolicitacaoRoute(
                                      numeroSolicitacao: widget.numeroSolicitacao,
                                    ),
                                  ),
                                  icone: Icon(
                                    Icons.edit,
                                    color: kCorFonte,
                                  ),
                                  corFundo: Color(tema.accent),
                                ),
                              ),
                              SizedBox(height: tema.espacamento * 4, width: tema.espacamento * 2),
                            ],
                            TabWidget(
                              tema: tema,
                              validarAtivo: (opcao) => _abaSelecionada.descricao != opcao,
                              opcoes: _opcoes,
                              aoSelecionar: (index) =>
                                  _atualizarAbaSelecionada(DetalhesSolicitacao.deDescricao(_opcoes[index])),
                            ),
                            if (solicitacao != null) Flexible(flex: 3, child: _obterAba),
                            if (_abaSelecionada == DetalhesSolicitacao.INFORMACOES &&
                                (solicitacao?.status.permiteEdicao ?? false))
                              Flexible(
                                child: Flex(
                                  direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _obterBotaoEsquerdo(context),
                                    SizedBox(height: tema.espacamento * 2, width: tema.espacamento * 2),
                                    _obterBotaoDireito,
                                  ],
                                ),
                              )
                          ],
                        ),
                ),
        ),
      ),
    );
  }

  List<String> get _opcoes => DetalhesSolicitacao.values.where((e) => e.aba).map((e) => e.descricao).toList();

  Widget get _obterAba {
    return switch (_abaSelecionada) {
      DetalhesSolicitacao.INFORMACOES => SizedBox(
          child: ConteudoResumoSolicitacaoWidget(
            tema: tema,
            usuarioSolicitante: _usuarioComponent.usuarioSelecionado!.nome,
            solicitacao: solicitacao!,
            edicao: true,
          ),
        ),
      DetalhesSolicitacao.LIVROS => ConteudoLivrosSolicitacaoWidget(
          tema: tema,
          nomeSolicitante: _usuarioComponent.usuarioSelecionado?.nome ?? "",
          nomeReceptor: _usuarioComponent.usuarioSolicitacao?.nome ?? "",
          usuarioCriador: solicitacao?.livrosSolicitante.livros ?? [],
          usuarioDoador: solicitacao?.livrosReceptor?.livros ?? [],
        ),
      DetalhesSolicitacao.CONTATO => Column(
          children: [
            !(solicitacao?.status.permiteEdicao ?? false)
                ? Column(
                    children: [
                      TextoWidget(
                        texto: "O status dessa solicitação não permite a exibição do contato",
                        tema: tema,
                      ),
                    ],
                  )
                : ConteudoContatoWidget(
                    tema: tema,
                    usuarioCriador: _usuarioComponent.usuarioSelecionado!,
                    usuarioDoador: _usuarioComponent.usuarioSolicitacao,
                  ),
          ],
        ),
      _ => Container(),
    };
  }

  Widget _obterBotaoEsquerdo(BuildContext context) {
    if (solicitacao?.tipoSolicitacao == TipoSolicitacao.TROCA) {
      return BotaoWidget(
        tema: tema,
        corTexto: kCorFonte,
        texto: "Escolher livros",
        aoClicar: () => _atualizarAbaSelecionada(DetalhesSolicitacao.SELECAO_LIVROS),
        icone: Icon(
          Icons.bookmark_add_outlined,
          color: kCorFonte,
        ),
        corFundo: Color(tema.accent),
      );
    }
    if (solicitacao?.status == TipoStatusSolicitacao.EM_ANDAMENTO && solicitacao!.validarPodeFinalizar) {
      return BotaoWidget(
        tema: tema,
        corTexto: kCorFonte,
        texto: "Finalizar",
        aoClicar: _finalizarSolicitacao,
        icone: Icon(
          Icons.done_all,
          color: kCorFonte,
        ),
        corFundo: Color(tema.success),
      );
    }
    if (solicitacao?.status == TipoStatusSolicitacao.PENDENTE)
      return BotaoWidget(
        tema: tema,
        corTexto: kCorFonte,
        texto: "Aceitar",
        aoClicar: _aceitarSolicitacao,
        icone: Icon(
          Icons.done,
          color: kCorFonte,
        ),
        corFundo: Color(tema.success),
      );

    return SizedBox();
  }

  Widget get _obterBotaoDireito {
    if (solicitacao?.status == TipoStatusSolicitacao.EM_ANDAMENTO) {
      return BotaoWidget(
        tema: tema,
        corTexto: kCorFonte,
        texto: "Cancelar",
        aoClicar: () async => showDialog(
          context: context,
          builder: (context) => obterPopUp(
            "Caso deseje cancelar a solicitação, informe o motivo e selecione 'Cancelar'.",
            "Cancelar",
            context,
            () async {
              await _solicitacaoComponent.cancelarSolicitacao(
                solicitacao!.numero!,
              );
              await _solicitacaoComponent.obterSolicitacao(widget.numeroSolicitacao);
              Navigator.pop(context);
            },
          ),
        ),
        icone: Icon(
          Icons.close,
          color: kCorFonte,
        ),
        corFundo: Color(tema.error),
      );
    }
    return BotaoWidget(
      tema: tema,
      corTexto: kCorFonte,
      texto: "Recusar",
      aoClicar: () async {
        await showDialog(
          context: context,
          builder: (context) => obterPopUp(
            "Caso deseje recusar a solicitação, informe o motivo e selecione 'Recusar'.",
            "Recusar",
            context,
            () => _solicitacaoComponent.recusarSolicitacao(
              solicitacao!.numero!,
              controllerMotivo.text,
            ),
          ),
        );
      },
      icone: Icon(
        Icons.close,
        color: kCorFonte,
      ),
      corFundo: Color(tema.error),
    );
  }

  Widget obterPopUp(String texto, String textoBotao, BuildContext context, Function() aoClicar) {
    return PopUpPadraoWidget(
      tema: tema,
      conteudo: Container(
        padding: EdgeInsets.all(tema.espacamento * 2),
        height: 380,
        width: 400,
        child: Column(
          children: [
            Icon(
              Icons.warning_rounded,
              color: Color(tema.baseContent),
              size: 50,
            ),
            SizedBox(height: tema.espacamento * 2),
            TextoWidget(
              texto: texto,
              tema: tema,
              align: TextAlign.center,
              tamanho: tema.tamanhoFonteM,
              weight: FontWeight.w500,
            ),
            SizedBox(height: tema.espacamento * 2),
            InputWidget(
              tema: tema,
              label: "Motivo",
              controller: controllerMotivo,
              onChanged: (valor) {},
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              corTexto: kCorFonte,
              texto: textoBotao,
              aoClicar: aoClicar,
              icone: Icon(
                Icons.close,
                color: kCorFonte,
              ),
              corFundo: Color(tema.error),
            ),
            SizedBox(height: tema.espacamento),
            BotaoWidget(
              tema: tema,
              corTexto: Color(tema.baseContent),
              texto: "Voltar",
              aoClicar: () => Navigator.pop(context),
              icone: SvgWidget(
                nomeSvg: 'seta/arrow-long-left',
                cor: Color(tema.baseContent),
              ),
              corFundo: Color(tema.base200),
            ),
          ],
        ),
      ),
    );
  }

  void _atualizarAbaSelecionada(DetalhesSolicitacao aba) {
    setState(() => _abaSelecionada = aba);
  }

  Future<void> _finalizarSolicitacao() async {
    notificarCasoErro(() async => await _solicitacaoComponent.finalizarSolicitacao(widget.numeroSolicitacao));
  }

  Future<void> _recusarSolicitacao() async {
    notificarCasoErro(() async {
      await _solicitacaoComponent.recusarSolicitacao(
        widget.numeroSolicitacao,
        controllerMotivo.text,
      );
    });
  }

  Future<void> _aceitarSolicitacao() async {
    notificarCasoErro(() async {
      await _solicitacaoComponent.aceitarSolicitacao(widget.numeroSolicitacao);
    });
  }

  Future<void> _cancelarSolicitacao() async {
    notificarCasoErro(() async {
      await _solicitacaoComponent.cancelarSolicitacao(widget.numeroSolicitacao);
    });
  }
}

enum DetalhesSolicitacao {
  INFORMACOES("Informações", true),
  LIVROS("Livros", true),
  SELECAO_LIVROS("", false),
  CONTATO("Contato", true);

  final String descricao;
  final bool aba;

  const DetalhesSolicitacao(this.descricao, this.aba);

  factory DetalhesSolicitacao.deDescricao(String descricao) {
    return DetalhesSolicitacao.values.firstWhere((e) => e.descricao == descricao);
  }
}
