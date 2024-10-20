import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/util/sobreposicao.util.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/calendario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_selecao_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/layout_flexivel.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/conteudo_endereco_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_informacoes_adicionais.widget.dart';
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
  FormaEntrega? formaEntregaSelecionada;

  CriarSolicitacao estagioPagina = CriarSolicitacao.INFORMACOES_ADICIONAIS;

  TemaState get _temaState => TemaState.instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  Tema get tema => _temaState.temaSelecionado!;
  TipoSolicitacao _tipoSolicitacao = TipoSolicitacao.TROCA;

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
      await _usuarioComponent.obterPerfil();
      if (widget.numeroLivro != null) await _usuarioComponent.obterLivro(widget.numeroLivro!);
      await _obterUsuarioSolicitacao();
      ResumoLivro? livro = _usuarioComponent.livroSelecionado?.criarResumoLivro();
      if (livro != null) _solicitacaoComponent.selecionarLivro(livro);
      await _usuarioComponent.obterLivrosUsuarioSolicitacao();
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
        atualizar: atualizar,
        voltar: () => Rota.navegar(context, Rota.HOME),
        carregando: _usuarioComponent.carregando || _solicitacaoComponent.carregando,
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
          aoClicarLivro: _solicitacaoComponent.selecionarLivro,
          aoSelecionarLivro: _solicitacaoComponent.selecionarLivro,
          verificarSelecao: _solicitacaoComponent.verificarSelecao,
          livros: _usuarioComponent.itensPaginados.where((e) => e.tiposSolicitacao.contains(_tipoSolicitacao)).toList(),
          textoPopUp: "Deseja adicionar os livros selecionados na solicitação?",
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
            controllerFormaEntrega: controllerFormaEntrega,
            aoClicarFormaEntrega: (formaEntrega) {
              formaEntrega;
              setState(() {
                formaEntregaSelecionada = formaEntrega;
                controllerFormaEntrega.text = formaEntrega.descricao;
              });
            },
            abrirDatePicker: ([bool ehDevolucao = false]) => abrirDatePicker(ehDevolucao),
            aoClicarAdicionarLivro: () {
              _validarDatas();
              atualizarPagina(CriarSolicitacao.SELECIONAR_LIVROS);
            },
          ),
        ),
      CriarSolicitacao.ENDERECO => SingleChildScrollView(
          child: ConteudoEnderecoSolicitacaoWidget(
            tema: tema,
            utilizaEnderecoPerfil: _solicitacaoComponent.utilizarEnderecoPerfil,
            aoSelecionarFormaEntrega: (forma) => setState(() => controllerFormaEntrega.text = forma),
            aoSelecionarFrete: (frete) => setState(() => controllerFrete.text = frete),
            estados: UF.values.map((e) => e.descricao).toList(),
            cidades: _usuarioComponent.municipiosPorNumero.values.map((e) => e.nome).toList(),
            controllerFrete: controllerFrete,
            aoSelecionarEstado: _selecionarEstado,
            aoSelecionarCidade: (cidade) => setState(() => controllerCidade.text = cidade),
            aoClicarProximo: salvarSolicitacao,
            utilizarEnderecoPerfil: _utilizarEnderecoPerfil,
            aoClicarFrete: (frete) {},
            controllerRua: controllerRua,
            controllerBairro: controllerBairro,
            controllerCep: controllerCep,
            controllerNumero: controllerNumero,
            controllerComplemento: controllerComplemento,
            controllerCidade: controllerCidade,
            controllerEstado: controllerEstado,
          ),
        ),
      CriarSolicitacao.CONCLUSAO => SingleChildScrollView(
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        "Sua solicitação foi enviada! Quando ${_usuarioComponent.usuarioSolicitacao?.nome} respondê-la, você será notificado e receberá um e-mail.",
                    tema: tema,
                    maxLines: 5,
                  ),
                ),
              ),
              SizedBox(height: tema.espacamento * 4),
              Flexible(
                child: BotaoWidget(
                  tema: tema,
                  texto: 'Finalizar',
                  nomeIcone: "seta/arrow-long-right",
                  icone: Icon(Icons.check, color: Color(tema.base200)),
                  aoClicar: () => Rota.navegar(context, Rota.HOME),
                ),
              ),
              SizedBox(height: tema.espacamento * 4),
            ],
          ),
        ),
      _ => const SizedBox(),
    };
  }

  Future<void> salvarSolicitacao() async {
    await notificarCasoErro(() async {
      if (!validarCamposPreenchidos()) throw Exception("Preencha todos os campos");
      _solicitacaoComponent.atualizarSolicitacaoMemoria(solicitacao);
      await _solicitacaoComponent.atualizarSolicitacao();
      atualizarPagina(CriarSolicitacao.CONCLUSAO);
      Notificacoes.mostrar("Solicitação criada com sucesso", Emoji.SUCESSO);
    });
  }

  bool validarCamposPreenchidos() {
    return controllerRua.text.isNotEmpty &&
        controllerBairro.text.isNotEmpty &&
        controllerCep.text.isNotEmpty &&
        controllerNumero.text.isNotEmpty &&
        controllerCidade.text.isNotEmpty &&
        controllerEstado.text.isNotEmpty;
  }

  Future<void> _selecionarEstado(String estado) async {
    UF uf = UF.deDescricao(estado);
    await _usuarioComponent.obterCidades(uf);
    setState(() => controllerEstado.text = estado);
  }

  Future<void> _utilizarEnderecoPerfil() async {
    notificarCasoErro(() async {
      await _usuarioComponent.obterEndereco();
      if (_usuarioComponent.enderecoEdicao != null) _solicitacaoComponent.utilizarEnderecoDoPerfil();
      if (_solicitacaoComponent.utilizarEnderecoPerfil) {
        _preencherControllersEndereco(_usuarioComponent.enderecoEdicao!);
        setState(() {});
      } else {
        controllerRua.text = "";
        controllerBairro.text = "";
        controllerCep.text = "";
        controllerNumero.text = "";
        controllerComplemento.text = "";
        controllerCidade.text = "";
        controllerEstado.text = "";
      }
    });
  }

  Solicitacao get solicitacao {
    try {
      DataHora? dataEntrega = controllerDataEntrega.text.isEmpty && controllerHoraEntrega.text.isEmpty
          ? null
          : DataHora.deString("${controllerDataEntrega.text} ${controllerHoraEntrega.text}", "dd/MM/yyyy HH:mm");
      DataHora? dataDevolucao = controllerDataDevolucao.text.isEmpty && controllerHoraDevolucao.text.isEmpty
          ? null
          : DataHora.deString("${controllerDataDevolucao.text} ${controllerHoraDevolucao.text}", "dd/MM/yyyy HH:mm");
      formaEntregaSelecionada;

      return Solicitacao.criar(
        null,
        _usuarioComponent.livroSelecionado!.emailUsuario,
        _autenticacaoState.usuario!.email.endereco,
        formaEntregaSelecionada ?? FormaEntrega.CORREIOS,
        null,
        dataEntrega,
        dataDevolucao,
        null,
        controllerInformacoes.text,
        _solicitacaoComponent.utilizarEnderecoPerfil ? null : endereco!,
        TipoStatusSolicitacao.PENDENTE,
        null,
        null,
        _tipoSolicitacao,
        null,
        LivrosSolicitacao.criar(
          _autenticacaoState.usuario!.email.endereco,
          _solicitacaoComponent.livrosSelecionados,
        ),
        null,
      );
    } catch (e) {
      rethrow;
    }
  }

  Endereco? get endereco {
    Municipio? municipio = _usuarioComponent.municipiosPorNumero.values
        .where(
          (element) => element.nome == controllerCidade.text,
        )
        .firstOrNull;

    if (municipio == null) return null;

    return Endereco.criar(
      controllerNumero.text.trim(),
      controllerComplemento.text.trim(),
      controllerRua.text.trim(),
      controllerCep.text.replaceAll("-", "").replaceAll(" ", "").trim(),
      controllerBairro.text.trim(),
      municipio,
      false,
    );
  }

  Future<void> _obterUsuarioSolicitacao() async {
    String email = _usuarioComponent.livroSelecionado!.emailUsuario;
    await _usuarioComponent.obterUsuarioSolicitacao(email);
  }

  void _preencherControllersEndereco(Endereco endereco) {
    controllerRua.text = endereco.rua;
    controllerBairro.text = endereco.bairro;
    controllerCep.text = endereco.cep;
    controllerNumero.text = endereco.numeroResidencial?.toString() ?? "";
    controllerComplemento.text = endereco.complemento?.toString() ?? "";
    controllerCidade.text = endereco.municipio.nome ?? "";
    controllerEstado.text = endereco.municipio.estado.descricao ?? "";
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

  void _validarDatas() {
    if (controllerDataEntrega.text.isNotEmpty &&
        controllerDataDevolucao.text.isNotEmpty &&
        formaEntregaSelecionada == FormaEntrega.PRESENCIAL) {
      DataHora dataEntrega = DataHora.deString(controllerDataEntrega.text, "dd/MM/yyyy");
      DataHora dataDevolucao = DataHora.deString(controllerDataDevolucao.text, "dd/MM/yyyy");
      if (dataDevolucao.ehAntesDe(dataEntrega)) {
        Notificacoes.mostrar("A data de devolução não pode ser anterior à data de entrega");
        throw DataInvalida();
      }
    }
  }
}

enum CriarSolicitacao { SELECIONAR_LIVROS, INFORMACOES_ADICIONAIS, ENDERECO, CONCLUSAO }
