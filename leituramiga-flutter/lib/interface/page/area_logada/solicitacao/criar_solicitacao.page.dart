import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/comentario_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/notificacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.service.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/usuario_mock.repo.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/util/sobreposicao.util.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/calendario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_selecao_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/layout_flexivel.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/conteudo_endereco_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_informacoes_adicionais.widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/time_picker.widget.dart';

@RoutePage()
class CriarSolicitacaoPage extends StatefulWidget {
  final int? numeroLivro;
  final int tipoSolicitacao;

  const CriarSolicitacaoPage({
    super.key,
    @PathParam('numeroLivro') required this.numeroLivro,
    @PathParam('tipoSolicitacao') required this.tipoSolicitacao,
  });

  @override
  State<CriarSolicitacaoPage> createState() => _CriarSolicitacaoPageState();
}

class _CriarSolicitacaoPageState extends State<CriarSolicitacaoPage> {
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

  CriarSolicitacao estagioPagina = CriarSolicitacao.INFORMACOES_ADICIONAIS;

  TemaState get _temaState => TemaState.instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  Tema get tema => _temaState.temaSelecionado!;
  TipoSolicitacao _tipoSolicitacao = TipoSolicitacao.TROCA;

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
      await _usuarioComponent.obterUsuario(1);
      if (widget.numeroLivro != null) await _usuarioComponent.obterLivro(widget.numeroLivro!);
      await _obterUsuarioSolicitacao();
      await _usuarioComponent.obterLivrosUsuario();
      _tipoSolicitacao = TipoSolicitacao.deNumero(widget.tipoSolicitacao);
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
        carregando: _usuarioComponent.carregando ||
            _solicitacaoComponent.carregando ||
            _usuarioComponent.usuarioSolicitacao == null,
        alterarFonte: _alterarFonte,
        alterarTema: _alterarTema,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: paginaSelecionada,
        ),
      ),
    );
  }

  void atualizarPagina(CriarSolicitacao estagio) => setState(() => estagioPagina = estagio);

  Widget get paginaSelecionada {
    return switch (estagioPagina) {
      CriarSolicitacao.SELECIONAR_LIVROS => ConteudoSelecaoLivrosWidget(
          tema: tema,
          aoSelecionarLivro: _solicitacaoComponent.selecionarLivro,
          verificarSelecao: _solicitacaoComponent.verificarSelecao,
          livros: _usuarioComponent.itensPaginados,
          navegarParaSolicitacao: () => atualizarPagina(CriarSolicitacao.INFORMACOES_ADICIONAIS),
        ),
      CriarSolicitacao.INFORMACOES_ADICIONAIS => SingleChildScrollView(
          child: FormularioInformacoesAdicionaisWidget(
            tema: tema,
            controllerHoraDevolucao: controllerHoraDevolucao,
            controllerHoraEntrega: controllerHoraEntrega,
            abrirTimePicker: ([bool ehDevolucao = false]) => abrirTimePicker(ehDevolucao),
            livrosSolicitacao: _solicitacaoComponent.livrosSelecionados,
            controllerInformacoes: controllerInformacoes,
            aoClicarProximo: () => atualizarPagina(CriarSolicitacao.ENDERECO),
            controllerDataEntrega: controllerDataEntrega,
            removerLivro: _solicitacaoComponent.removerLivro,
            controllerDataDevolucao: controllerDataDevolucao,
            tipoSolicitacao: _tipoSolicitacao,
            abrirDatePicker: ([bool ehDevolucao = false]) => abrirDatePicker(ehDevolucao),
            aoClicarAdicionarLivro: () => atualizarPagina(CriarSolicitacao.SELECIONAR_LIVROS),
          ),
        ),
      CriarSolicitacao.ENDERECO => SingleChildScrollView(
          child: ConteudoEnderecoSolicitacaoWidget(
            tema: tema,
            aoSelecionarFormaEntrega: (forma) => setState(() => controllerFormaEntrega.text = forma),
            aoSelecionarFrete: (frete) => setState(() => controllerFrete.text = frete),
            estados: UF.values.map((e) => e.descricao).toList(),
            cidades: [],
            controllerFrete: controllerFrete,
            controllerFormaEntrega: controllerFormaEntrega,
            aoSelecionarEstado: (estado) => setState(() => controllerEstado.text = estado),
            aoSelecionarCidade: (cidade) => setState(() => controllerCidade.text = cidade),
            aoClicarProximo: () => atualizarPagina(CriarSolicitacao.CONCLUSAO),
            utilizarEnderecoPerfil: () {},
            aoClicarFormaEntrega: (formaEntrega) {},
            aoClicarFrete: (frete) {},
            controllerRua: controllerRua,
            controllerBairro: controllerBairro,
            controllerCep: controllerCep,
            controllerNumero: controllerNumero,
            controllerComplemento: controllerComplemento,
            controllerCidade: controllerCidade,
            usuarios: [_autenticacaoState.usuario!.nomeUsuario, _usuarioComponent.usuarioSolicitacao!.nomeUsuario],
            controllerEstado: controllerEstado,
          ),
        ),
      CriarSolicitacao.CONCLUSAO => Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: SvgWidget(
                altura: 350,
                nomeSvg: "solicitacao_fim",
              ),
            ),
            SizedBox(height: tema.espacamento * 2),
            Flexible(
              child: SizedBox(
                width: 400,
                child: TextoWidget(
                  align: TextAlign.center,
                  texto:
                      "Sua solicitação foi enviada! Quando @usuário respondê-la, você será notificado e receberá um e-mail.",
                  tema: tema,
                  maxLines: 5,
                ),
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            Flexible(
              child: BotaoWidget(
                tema: tema,
                texto: 'Conclusão',
                nomeIcone: "seta/arrow-long-right",
                aoClicar: () => Rota.navegar(context, Rota.HOME),
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
          ],
        ),
      _ => const SizedBox(),
    };
  }

  Future<void> _obterUsuarioSolicitacao() async {
    int numero = _usuarioComponent.livroSelecionado!.numeroUsuario;
    await _usuarioComponent.obterUsuarioSolicitacao(numero);
  }

  void _criarSolicitacao() {
    Solicitacao solicitacao = Solicitacao.criar(
      null,
      _autenticacaoState.usuario!.numero!,
      _usuarioComponent.livroSelecionado!.numeroUsuario,
      _solicitacaoComponent.formaEntregaSelecionada!,
      DataHora.deString(controllerDataEntrega.text),
      DataHora.deString(controllerDataDevolucao.text),
      DataHora.deString(controllerDataDevolucao.text),
      DataHora.deString(controllerDataDevolucao.text),
      controllerInformacoes.text,
      Endereco.criar(
        controllerRua.text,
        controllerBairro.text,
        controllerCep.text,
        controllerNumero.text,
        controllerComplemento.text,
        _solicitacaoComponent.municipioSelecionado!,
      ),
      _solicitacaoComponent.instituicaoSelecionada!,
      TipoStatusSolicitacao.PENDENTE,
      null,
      null,
      _autenticacaoState.usuario?.nomeUsuario ?? '',
      _tipoSolicitacao,
      _obterNumeroUsuarioFrete,
    );

    _solicitacaoComponent.atualizarSolicitacaoMemoria(solicitacao);
  }

  int get _obterNumeroUsuarioFrete {
    if (controllerFrete.text == "Sim") return _autenticacaoState.usuario!.numero!;
    return _usuarioComponent.usuarioSelecionado!.numero!;
  }

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }

  void abrirTimePicker(bool ehHoraDevolucao) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      barrierColor: Color(tema.neutral).withOpacity(.2),
      builder: (context, child) {
        return TimePickerWidget(tema: tema, child: child!);
      },
    );

    selectedTime.then((time) {
      if (time != null) {
        if (ehHoraDevolucao) {
          setState(() => controllerHoraDevolucao.text = time.format(context));
        } else {
          setState(() => controllerHoraEntrega.text = time.format(context));
        }
      }
    });
  }

  void abrirDatePicker(bool ehDataDevolucao) {
    SobreposicaoUtil.exibir(
      context,
      LayoutFlexivelWidget(
        tema: tema,
        overlayChild: _obterCalendario(ehDataDevolucao),
        drawerChild: _obterCalendario(ehDataDevolucao),
      ),
    );
  }

  Widget _obterCalendario(bool ehDataDevolucao) {
    return CalendarioWidget(
      tema: tema,
      aoSelecionarData: (data) async {
        if (ehDataDevolucao) {
          setState(() => controllerDataDevolucao.text = DataHora.criar(data).formatar("dd/MM/yyyy"));
        } else {
          setState(() => controllerDataEntrega.text = DataHora.criar(data).formatar("dd/MM/yyyy"));
        }
        await SobreposicaoUtil.fechar(context);
      },
    );
  }
}

enum CriarSolicitacao { SELECIONAR_LIVROS, INFORMACOES_ADICIONAIS, ENDERECO, CONCLUSAO }
