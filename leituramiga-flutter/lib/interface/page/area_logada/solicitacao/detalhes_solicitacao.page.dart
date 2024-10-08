import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/comentario_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/notificacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.service.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';
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
import 'package:auto_route/auto_route.dart';
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

  DetalhesSolicitacao _abaSelecionada = DetalhesSolicitacao.INFORMACOES;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  void initState() {
    super.initState();
    _solicitacaoComponent.inicializar(
      SolicitacaoMockRepo(),
      SolicitacaoMockService(),
      NotificacaoMockRepo(),
      atualizar,
    );
    _usuarioComponent.inicializar(
      UsuarioMockRepo(),
      ComentarioMockRepo(),
      EnderecoMockRepo(),
      LivroMockRepo(),
      atualizar,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _solicitacaoComponent.obterSolicitacao(widget.numeroSolicitacao);
      await _usuarioComponent.obterUsuario(_solicitacaoComponent.solicitacaoSelecionada!.emailUsuarioCriador);
      await _usuarioComponent.obterLivrosUsuario();
      await _usuarioComponent.obterCidades();
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
        carregando: _solicitacaoComponent.carregando || _solicitacaoComponent.solicitacaoSelecionada == null,
        voltar: () => Rota.navegar(context, Rota.HOME),
        child: SingleChildScrollView(
          physics:
              _abaSelecionada == DetalhesSolicitacao.SELECAO_LIVROS || _abaSelecionada == DetalhesSolicitacao.LIVROS
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: Responsive.altura(context) * .88,
            child: _abaSelecionada == DetalhesSolicitacao.SELECAO_LIVROS
                ? ConteudoSelecaoLivrosWidget(
                    tema: tema,
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
                      TabWidget(
                        tema: tema,
                        validarAtivo: (opcao) => _abaSelecionada.descricao != opcao,
                        opcoes: _opcoes,
                        aoSelecionar: (index) =>
                            _atualizarAbaSelecionada(DetalhesSolicitacao.deDescricao(_opcoes[index])),
                      ),
                      if (_solicitacaoComponent.solicitacaoSelecionada != null) _obterAba,
                      if (_abaSelecionada == DetalhesSolicitacao.INFORMACOES)
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
            aoAceitar: () {},
            aoEscolher: () {},
            solicitacao: _solicitacaoComponent.solicitacaoSelecionada!,
            edicao: true,
            aoCancelar: () {},
            aoEditar: () {},
            aoRecusar: () {},
          ),
        ),
      DetalhesSolicitacao.LIVROS => ConteudoLivrosSolicitacaoWidget(
          tema: tema,
          usuarioCriador: [],
        ),
      DetalhesSolicitacao.CONTATO => ConteudoContatoWidget(
          tema: tema,
          usuarioCriador: _usuarioComponent.usuarioSelecionado!,
          usuarioDoador: _usuarioComponent.usuarioSolicitacao,
        ),
      _ => Container(),
    };
  }

  Widget _obterBotaoEsquerdo(BuildContext context) {
    if (_solicitacaoComponent.solicitacaoSelecionada?.status == TipoStatusSolicitacao.EM_ANDAMENTO) {
      return BotaoWidget(
        tema: tema,
        corTexto: kCorFonte,
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
      );
    }

    if (_solicitacaoComponent.solicitacaoSelecionada?.tipoSolicitacao == TipoSolicitacao.TROCA) {
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

    return BotaoWidget(
      tema: tema,
      corTexto: kCorFonte,
      texto: "Aceitar",
      aoClicar: () {},
      icone: Icon(
        Icons.done,
        color: kCorFonte,
      ),
      corFundo: Color(tema.success),
    );
  }

  Widget get _obterBotaoDireito {
    if (_solicitacaoComponent.solicitacaoSelecionada?.status == TipoStatusSolicitacao.EM_ANDAMENTO) {
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

  Widget obterPopUp(String texto, String textoBotao, BuildContext context) {
    return PopUpPadraoWidget(
      tema: tema,
      conteudo: Container(
        padding: EdgeInsets.all(tema.espacamento * 2),
        height: 350,
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
              controller: TextEditingController(),
              onChanged: (valor) {},
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              corTexto: kCorFonte,
              texto: textoBotao,
              aoClicar: () {},
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
