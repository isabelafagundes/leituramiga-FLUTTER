import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_selecao_livros.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/conteudo_endereco_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/tab.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class AceiteSolicitacaoPage extends StatefulWidget {
  final int numeroSolicitacao;

  const AceiteSolicitacaoPage({super.key, required this.numeroSolicitacao});

  @override
  State<AceiteSolicitacaoPage> createState() => _AceiteSolicitacaoPageState();
}

class _AceiteSolicitacaoPageState extends State<AceiteSolicitacaoPage> {
  final SolicitacaoComponent _solicitacaoComponent = SolicitacaoComponent();
  final UsuarioComponent _usuarioComponent = UsuarioComponent();
  final TextEditingController controllerRua = TextEditingController();
  final TextEditingController controllerBairro = TextEditingController();
  final TextEditingController controllerCep = TextEditingController();
  final TextEditingController controllerNumero = TextEditingController();
  final TextEditingController controllerComplemento = TextEditingController();
  final TextEditingController controllerCidade = TextEditingController();
  final TextEditingController controllerEstado = TextEditingController();

  TemaState get _temaState => TemaState.instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  Tema get tema => _temaState.temaSelecionado!;
  TipoSolicitacao _tipoSolicitacao = TipoSolicitacao.DOACAO;
  FormaEntrega? formaEntregaSelecionada;
  AceitarSolicitacao _abaSelecionada = AceitarSolicitacao.SELECIONAR_LIVROS;
  bool _carregando = false;

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
      setState(() => _carregando = true);
      await _solicitacaoComponent.obterSolicitacao(widget.numeroSolicitacao);
      Solicitacao? solicitacao = _solicitacaoComponent.solicitacaoSelecionada;
      setState(() {
        _tipoSolicitacao = _solicitacaoComponent.solicitacaoSelecionada!.tipoSolicitacao;
        _abaSelecionada = AceitarSolicitacao.deDescricao(_opcoes.first);
      });
      await _usuarioComponent.obterUsuario(solicitacao!.emailUsuarioSolicitante);
      await _usuarioComponent.obterUsuarioSolicitacao(solicitacao.emailUsuarioProprietario);
      await _usuarioComponent.obterLivrosUsuario();
      await _usuarioComponent.obterEndereco();
      if (_usuarioComponent.enderecoEdicao!.principal) _preencherControllersEndereco(_usuarioComponent.enderecoEdicao!);
      UF? uf = _solicitacaoComponent.solicitacaoSelecionada?.enderecoSolicitante?.municipio.estado;
      await _usuarioComponent.obterCidades(uf!);
      setState(() => _carregando = false);
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
            _solicitacaoComponent.solicitacaoSelecionada == null ||
            _carregando,
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
                    corTexto: Color(tema.base200),
                    altura: 45,
                    largura: 140,
                    texto: "Aceitar",
                    aoClicar: () async {
                      notificarCasoErro(() async {
                        if (!_enderecoValido) return Notificacoes.mostrar("Preencha todos os campos do endereço!");
                        if (_solicitacaoComponent.livrosSelecionados.isEmpty)
                          return Notificacoes.mostrar("Selecione um livro!");
                        _solicitacaoComponent.validarNumeroLivrosSelecionados();

                        bool? navegarParaSolicitacoes = await showDialog(
                          context: context,
                          builder: (BuildContext context) => _obterPopUpPadrao(context),
                        );

                        if (navegarParaSolicitacoes ?? false) {
                          await _aceitarSolicitacao(enderecoSolicitacao);
                          Rota.navegarComArgumentos(
                            context,
                            DetalhesSolicitacaoRoute(
                              numeroSolicitacao: widget.numeroSolicitacao,
                            ),
                          );
                        }
                      });
                    },
                    icone: Icon(
                      Icons.check,
                      color: Color(tema.base200),
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
              aoSelecionar: (index) => _atualizarAbaSelecionada(AceitarSolicitacao.deDescricao(_opcoes[index])),
            ),
            SizedBox(height: tema.espacamento * 2),
            Expanded(child: paginaSelecionada),
          ],
        ),
      ),
    );
  }

  bool get _enderecoValido =>
      controllerRua.text.isNotEmpty &&
      controllerBairro.text.isNotEmpty &&
      controllerCep.text.isNotEmpty &&
      controllerNumero.text.isNotEmpty &&
      controllerCidade.text.isNotEmpty &&
      controllerEstado.text.isNotEmpty;

  Widget _obterPopUpPadrao(BuildContext context) {
    return PopUpPadraoWidget(
      tema: tema,
      conteudo: Container(
        height: 320,
        child: Column(
          children: [
            SizedBox(height: tema.espacamento * 4),
            Icon(
              Icons.warning_rounded,
              color: Color(tema.baseContent),
              size: 80,
            ),
            SizedBox(height: tema.espacamento * 3),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
              child: TextoWidget(
                tema: tema,
                texto: "Confirmar endereço e aceitar a solicitação?",
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BotaoWidget(
                  tema: tema,
                  icone: Icon(
                    Icons.close,
                    color: Color(tema.base200),
                  ),
                  texto: "Cancelar",
                  corFundo: Color(tema.error),
                  aoClicar: () => Navigator.of(context).pop(false),
                ),
                SizedBox(height: tema.espacamento * 2),
                BotaoWidget(
                  tema: tema,
                  icone: Icon(
                    Icons.check,
                    color: Color(tema.base200),
                  ),
                  texto: "Aceitar",
                  aoClicar: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _atualizarAbaSelecionada(AceitarSolicitacao aba) {
    setState(() => _abaSelecionada = aba);
  }

  Endereco? get enderecoSolicitacao {
    Municipio? municipio = _usuarioComponent.municipiosPorNumero.values
        .where(
          (element) => element.nome == controllerCidade.text,
        )
        .firstOrNull;

    if (_solicitacaoComponent.utilizarEnderecoPerfil) {
      return _usuarioComponent.enderecoEdicao;
    }

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

  Widget get paginaSelecionada {
    return switch (_abaSelecionada) {
      AceitarSolicitacao.SELECIONAR_LIVROS => ConteudoSelecaoLivrosWidget(
          tema: tema,
          exibirBotao: false,
          aoClicarLivro: _solicitacaoComponent.selecionarLivro,
          aoSelecionarLivro: _solicitacaoComponent.selecionarLivro,
          verificarSelecao: _solicitacaoComponent.verificarSelecao,
          livros: _usuarioComponent.itensPaginados.where((e) => e.tiposSolicitacao.contains(_tipoSolicitacao)).toList(),
          textoPopUp: "Deseja adicionar os livros selecionados na solicitação?",
          navegarParaSolicitacao: () => _atualizarAbaSelecionada(AceitarSolicitacao.ENDERECO),
        ),
      AceitarSolicitacao.ENDERECO => SingleChildScrollView(
          child: ConteudoEnderecoSolicitacaoWidget(
            tema: tema,
            textoAjuda: _solicitacaoComponent.solicitacaoSelecionada!.tipoSolicitacao == TipoSolicitacao.EMPRESTIMO
                ? "Preencha com o endereço que será feita a devolução!"
                : "Preencha com o endereço que será feita a entrega!",
            utilizaEnderecoPerfil: _solicitacaoComponent.utilizarEnderecoPerfil,
            aoSelecionarFormaEntrega: (forma) {},
            aoSelecionarFrete: (frete) {},
            estados: UF.values.map((e) => e.descricao).toList(),
            cidades: _usuarioComponent.municipiosPorNumero.values.map((e) => e.nome).toList(),
            controllerFrete: TextEditingController(),
            aoSelecionarEstado: _selecionarEstado,
            aoSelecionarCidade: (cidade) => setState(() => controllerCidade.text = cidade),
            aoClicarProximo: () {},
            semBotaoProximo: true,
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
    };
  }

  void _atualizarCarregamento() {
    setState(() => _carregando = !_carregando);
  }

  Future<void> _aceitarSolicitacao([Endereco? endereco]) async {
    _atualizarCarregamento();
    await notificarCasoErro(() async {
      setState(() => _carregando = true);
      await _solicitacaoComponent.aceitarSolicitacao(widget.numeroSolicitacao, enderecoSolicitacao);
    });
    _atualizarCarregamento();
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

  void _preencherControllersEndereco(Endereco endereco) {
    controllerRua.text = endereco.rua;
    controllerBairro.text = endereco.bairro;
    controllerCep.text = endereco.cep;
    controllerNumero.text = endereco.numeroResidencial?.toString() ?? "";
    controllerComplemento.text = endereco.complemento?.toString() ?? "";
    controllerCidade.text = endereco.municipio.nome;
    controllerEstado.text = endereco.municipio.estado.descricao;
  }

  Future<void> _selecionarEstado(String estado) async {
    UF uf = UF.deDescricao(estado);
    await _usuarioComponent.obterCidades(uf);
    setState(() => controllerEstado.text = estado);
  }

  Future<void> _obterUsuarioSolicitacao() async {
    String emailoUsuarioCriador = _solicitacaoComponent.solicitacaoSelecionada!.emailUsuarioSolicitante;
    String emailUsuarioProprietario = _solicitacaoComponent.solicitacaoSelecionada!.emailUsuarioProprietario;
    if (emailoUsuarioCriador == _autenticacaoState.usuario!.email) {
      await _usuarioComponent.obterUsuarioSolicitacao(emailUsuarioProprietario);
    } else {
      await _usuarioComponent.obterUsuarioSolicitacao(emailoUsuarioCriador);
    }
  }

  List<String> get _opcoes => AceitarSolicitacao.values
      .where((e) {
        if (e == AceitarSolicitacao.SELECIONAR_LIVROS && _tipoSolicitacao == TipoSolicitacao.EMPRESTIMO) return false;
        return e.aba;
      })
      .map((e) => e.descricao)
      .toList();
}

enum AceitarSolicitacao {
  SELECIONAR_LIVROS("Livros", true),
  ENDERECO("Endereço", true);

  final String descricao;
  final bool aba;

  const AceitarSolicitacao(this.descricao, this.aba);

  factory AceitarSolicitacao.deDescricao(String descricao) {
    return AceitarSolicitacao.values.firstWhere((e) => e.descricao == descricao);
  }
}
