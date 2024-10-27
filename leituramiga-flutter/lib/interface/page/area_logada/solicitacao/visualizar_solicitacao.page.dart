import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/util/sobreposicao.util.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/calendario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_livros_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/layout_flexivel.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/conteudo_endereco_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_informacoes_adicionais.widget.dart';
import 'package:projeto_leituramiga/interface/widget/tab.widget.dart';
import 'package:projeto_leituramiga/interface/widget/time_picker.widget.dart';

@RoutePage()
class VisualizarSolicitacaoPage extends StatefulWidget {
  final int numeroSolicitacao;

  const VisualizarSolicitacaoPage({
    super.key,
    @PathParam('numeroSolicitacao') required this.numeroSolicitacao,
  });

  @override
  State<VisualizarSolicitacaoPage> createState() => _VisualizarSolicitacaoPageState();
}

class _VisualizarSolicitacaoPageState extends State<VisualizarSolicitacaoPage> {
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
  final TextEditingController controllerCodigoRastreio = TextEditingController();
  final TextEditingController controllerFormaEntrega = TextEditingController();
  EditarSolicitacao _abaSelecionada = EditarSolicitacao.INFORMACOES;
  CriarSolicitacao estagioPagina = CriarSolicitacao.INFORMACOES_ADICIONAIS;

  TemaState get _temaState => TemaState.instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  Tema get tema => _temaState.temaSelecionado!;
  TipoSolicitacao _tipoSolicitacao = TipoSolicitacao.DOACAO;
  FormaEntrega? formaEntregaSelecionada;

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
      await _obterUsuarioSolicitacao();
      await _usuarioComponent.obterUsuario(_autenticacaoState.usuario!.email.endereco);
      await _usuarioComponent.obterLivrosUsuario();
      _preencherControllers();
      UF? uf = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.municipio.estado;
      await _usuarioComponent.obterCidades(uf!);
      setState(() => _tipoSolicitacao = _solicitacaoComponent.solicitacaoSelecionada!.tipoSolicitacao);
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
        voltar: () => Navigator.pop(context),
        atualizar: atualizar,
        carregando: _usuarioComponent.carregando ||
            _solicitacaoComponent.carregando ||
            _usuarioComponent.usuarioSolicitacao == null ||
            _solicitacaoComponent.solicitacaoSelecionada == null,
        child: Column(
          children: [
            SizedBox(
              child: Flex(
                direction: Responsive.larguraPP(context) ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BotaoWidget(
                    tema: tema,
                    corTexto: kCorFonte,
                    altura: 45,
                    largura: 140,
                    texto: "Salvar",
                    aoClicar: salvarSolicitacao,
                    icone: Icon(
                      Icons.check,
                      color: kCorFonte,
                    ),
                    corFundo: Color(tema.accent),
                  ),
                  SizedBox(width: tema.espacamento * 2, height: tema.espacamento * 2),
                  BotaoWidget(
                    tema: tema,
                    corTexto: Color(tema.baseContent),
                    altura: 45,
                    largura: 140,
                    texto: "Cancelar",
                    aoClicar: () => Navigator.pop(context),
                    icone: Icon(
                      Icons.close,
                      color: Color(tema.baseContent),
                    ),
                    corFundo: Color(tema.base200),
                  ),
                ],
              ),
            ),
            SizedBox(height: tema.espacamento * 4, width: tema.espacamento * 2),
            TabWidget(
              tema: tema,
              validarAtivo: (opcao) => _abaSelecionada.descricao != opcao,
              opcoes: _opcoes,
              aoSelecionar: (index) => _atualizarAbaSelecionada(EditarSolicitacao.deDescricao(_opcoes[index])),
            ),
            SizedBox(height: tema.espacamento * 2),
            Expanded(child: paginaSelecionada),
          ],
        ),
      ),
    );
  }

  void atualizarPagina(CriarSolicitacao estagio) => setState(() => estagioPagina = estagio);

  Widget get paginaSelecionada {
    return switch (_abaSelecionada) {
      EditarSolicitacao.INFORMACOES => SingleChildScrollView(
          child: FormularioInformacoesAdicionaisWidget(
            tema: tema,
            controllerCodigoRastreio: controllerCodigoRastreio,
            controllerHoraDevolucao: controllerHoraDevolucao,
            controllerHoraEntrega: controllerHoraEntrega,
            abrirTimePicker: ([bool ehDevolucao = false]) => abrirTimePicker(ehDevolucao),
            livrosSolicitacao: _solicitacaoComponent.livrosSelecionados,
            controllerInformacoes: controllerInformacoes,
            aoClicarProximo: () => atualizarPagina(CriarSolicitacao.ENDERECO),
            controllerDataEntrega: controllerDataEntrega,
            removerLivro: _solicitacaoComponent.removerLivro,
            controllerFormaEntrega: controllerFormaEntrega,
            controllerDataDevolucao: controllerDataDevolucao,
            tipoSolicitacao: _tipoSolicitacao,
            semSelecaoLivros: true,
            aoClicarFormaEntrega: (formaEntrega) {},
            abrirDatePicker: ([bool ehDevolucao = false]) => abrirDatePicker(ehDevolucao),
            aoClicarAdicionarLivro: () => atualizarPagina(CriarSolicitacao.SELECIONAR_LIVROS),
          ),
        ),
      EditarSolicitacao.ENDERECO => SingleChildScrollView(
          child: ConteudoEnderecoSolicitacaoWidget(
            tema: tema,
            semBotaoProximo: true,
            aoSelecionarFormaEntrega: (forma) => setState(() => controllerFormaEntrega.text = forma),
            aoSelecionarFrete: (frete) => setState(() => controllerCodigoRastreio.text = frete),
            estados: UF.values.map((e) => e.descricao).toList(),
            cidades: _usuarioComponent.municipiosPorNumero.values.map((e) => e.nome).toList(),
            controllerFrete: controllerCodigoRastreio,
            aoSelecionarEstado: (estado) => setState(() => controllerEstado.text = estado),
            aoSelecionarCidade: (cidade) => setState(() => controllerCidade.text = cidade),
            aoClicarProximo: () => atualizarPagina(CriarSolicitacao.CONCLUSAO),
            utilizarEnderecoPerfil: () {},
            aoClicarFrete: (frete) {},
            controllerRua: controllerRua,
            controllerBairro: controllerBairro,
            controllerCep: controllerCep,
            controllerNumero: controllerNumero,
            controllerComplemento: controllerComplemento,
            controllerCidade: controllerCidade,
            controllerEstado: controllerEstado,
            permitirUsarEnderecoPerfil: false,
            utilizaEnderecoPerfil: _solicitacaoComponent.solicitacaoSelecionada?.endereco?.principal ?? false,
          ),
        ),
      EditarSolicitacao.LIVROS => ConteudoLivrosSolicitacaoWidget(
          tema: tema,
          nomeSolicitante: _usuarioComponent.usuarioSelecionado?.nome ?? "",
          nomeReceptor: _usuarioComponent.usuarioSolicitacao?.nome ?? "",
          usuarioCriador: _solicitacaoComponent.solicitacaoSelecionada?.livrosSolicitante.livros ?? [],
          usuarioDoador: _solicitacaoComponent.solicitacaoSelecionada?.livrosReceptor?.livros ?? [],
        ),
      _ => const SizedBox(),
    };
  }

  Future<void> salvarSolicitacao() async {
    await notificarCasoErro(() async {
      if (!validarCamposPreenchidos()) throw Exception("Preencha todos os campos");
      _solicitacaoComponent.atualizarSolicitacaoMemoria(solicitacao);
      await _solicitacaoComponent.atualizarSolicitacao();
      Navigator.pop(context);
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

  void _preencherControllers() {
    controllerRua.text = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.rua ?? '';
    controllerBairro.text = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.bairro ?? '';
    controllerCep.text = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.cep ?? '';
    controllerNumero.text = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.numeroResidencial ?? '';
    controllerComplemento.text = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.complemento ?? '';
    controllerCidade.text = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.municipio.nome ?? '';
    controllerEstado.text = _solicitacaoComponent.solicitacaoSelecionada?.endereco?.municipio.estado.descricao ?? '';
    controllerDataEntrega.text =
        _solicitacaoComponent.solicitacaoSelecionada?.dataEntrega?.formatar("dd/MM/yyyy") ?? '';
    controllerDataDevolucao.text =
        _solicitacaoComponent.solicitacaoSelecionada?.dataDevolucao?.formatar("dd/MM/yyyy") ?? '';
    controllerHoraEntrega.text = _solicitacaoComponent.solicitacaoSelecionada?.dataEntrega?.formatar("HH:mm") ?? '';
    controllerHoraDevolucao.text = _solicitacaoComponent.solicitacaoSelecionada?.dataDevolucao?.formatar("HH:mm") ?? '';
    controllerFormaEntrega.text = _solicitacaoComponent.solicitacaoSelecionada?.formaEntrega.descricao ?? "Selecione";
    controllerInformacoes.text = _solicitacaoComponent.solicitacaoSelecionada?.informacoesAdicionais ?? "";
    controllerCodigoRastreio.text = _solicitacaoComponent.solicitacaoSelecionada?.codigoRastreamento ?? "";
    setState(() {});
  }

  Future<void> _obterUsuarioSolicitacao() async {
    String emailoUsuarioCriador = _solicitacaoComponent.solicitacaoSelecionada!.emailUsuarioCriador;
    String emailUsuarioProprietario = _solicitacaoComponent.solicitacaoSelecionada!.emailUsuarioProprietario;
    if (emailoUsuarioCriador == _autenticacaoState.usuario!.email) {
      await _usuarioComponent.obterUsuarioSolicitacao(emailUsuarioProprietario);
    } else {
      await _usuarioComponent.obterUsuarioSolicitacao(emailoUsuarioCriador);
    }
  }

  Solicitacao get solicitacao {
    try {
      DataHora? dataEntrega = controllerDataEntrega.text.isEmpty && controllerHoraEntrega.text.isEmpty
          ? null
          : DataHora.deString("${controllerDataEntrega.text} ${controllerHoraEntrega.text}", "dd/MM/yyyy HH:mm");
      DataHora? dataDevolucao = controllerDataDevolucao.text.isEmpty && controllerHoraDevolucao.text.isEmpty
          ? null
          : DataHora.deString("${controllerDataDevolucao.text} ${controllerHoraDevolucao.text}", "dd/MM/yyyy HH:mm");

      return Solicitacao.criar(
        _solicitacaoComponent.solicitacaoSelecionada!.numero,
        _solicitacaoComponent.solicitacaoSelecionada!.emailUsuarioCriador,
        _solicitacaoComponent.solicitacaoSelecionada!.emailUsuarioProprietario,
        formaEntregaSelecionada ?? FormaEntrega.CORREIOS,
        _solicitacaoComponent.solicitacaoSelecionada!.dataCriacao,
        dataEntrega,
        dataDevolucao,
        _solicitacaoComponent.solicitacaoSelecionada!.dataAtualizacao,
        controllerInformacoes.text,
        _solicitacaoComponent.solicitacaoSelecionada!.endereco!.principal
            ? _solicitacaoComponent.solicitacaoSelecionada!.endereco
            : endereco,
        _solicitacaoComponent.solicitacaoSelecionada!.status,
        _solicitacaoComponent.solicitacaoSelecionada!.dataAceite,
        "",
        _tipoSolicitacao,
        controllerCodigoRastreio.text,
        _solicitacaoComponent.solicitacaoSelecionada!.livrosSolicitante,
        _solicitacaoComponent.solicitacaoSelecionada!.livrosReceptor,
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

    Solicitacao solicitacaoEdicao = _solicitacaoComponent.solicitacaoSelecionada!;

    if (solicitacaoEdicao.endereco != null && municipio == null) return solicitacaoEdicao.endereco;

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
      dataInicial: ehDataDevolucao
          ? _solicitacaoComponent.solicitacaoSelecionada?.dataDevolucao?.valor ?? DataHora.hoje().valor
          : _solicitacaoComponent.solicitacaoSelecionada?.dataEntrega?.valor ?? DataHora.hoje().valor,
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

  void _atualizarAbaSelecionada(EditarSolicitacao aba) {
    setState(() => _abaSelecionada = aba);
  }

  List<String> get _opcoes => EditarSolicitacao.values.where((e) => e.aba).map((e) => e.descricao).toList();
}

enum CriarSolicitacao { SELECIONAR_LIVROS, INFORMACOES_ADICIONAIS, ENDERECO, CONCLUSAO }

enum EditarSolicitacao {
  INFORMACOES("Informações", true),
  ENDERECO("Endereço", true),
  LIVROS("Livros", true);

  final String descricao;
  final bool aba;

  const EditarSolicitacao(this.descricao, this.aba);

  factory EditarSolicitacao.deDescricao(String descricao) {
    return EditarSolicitacao.values.firstWhere((e) => e.descricao == descricao);
  }
}
