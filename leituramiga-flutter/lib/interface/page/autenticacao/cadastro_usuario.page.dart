import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/component/instituicao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/senha.dart';
import 'package:leituramiga/domain/usuario/email.dart';
import 'package:leituramiga/domain/usuario/telefone.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_codigo_seguranca.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_criacao_senha.widget.dart';
import 'package:projeto_leituramiga/interface/widget/etapas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/logo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class CadastroUsuarioPage extends StatefulWidget {
  const CadastroUsuarioPage({super.key});

  @override
  State<CadastroUsuarioPage> createState() => _CadastroUsuarioPageState();
}

class _CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  final UsuarioComponent _usuarioComponent = UsuarioComponent();
  final AutenticacaoComponent _autenticacaoComponent = AutenticacaoComponent();
  final InstituicaoComponent _instituicaoComponent = InstituicaoComponent();
  final TextEditingController controllerRua = TextEditingController();
  final TextEditingController controllerBairro = TextEditingController();
  final TextEditingController controllerCep = TextEditingController();
  final TextEditingController controllerNumero = TextEditingController();
  final TextEditingController controllerComplemento = TextEditingController();
  final TextEditingController controllerCidade = TextEditingController();
  final TextEditingController controllerEstado = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerNomeUsuario = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerConfirmacaoSenha = TextEditingController();
  final TextEditingController controllerCodigoSeguranca = TextEditingController();
  final TextEditingController controllerTelefone = TextEditingController();
  final TextEditingController controllerInstituicao = TextEditingController();
  Telefone? telefone;
  Email? email;
  EtapaCadastro? _etapaCadastro = EtapaCadastro.DADOS_GERAIS;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  void atualizar() {
    setState(() {});
  }

  @override
  void initState() {
    _usuarioComponent.inicializar(
      AppModule.usuarioRepo,
      AppModule.comentarioRepo,
      AppModule.enderecoRepo,
      AppModule.livroRepo,
      atualizar,
    );
    _autenticacaoComponent.inicializar(
      AppModule.autenticacaoService,
      AppModule.sessaoService,
      AppModule.usuarioRepo,
      atualizar,
    );
    _instituicaoComponent.inicializar(
      AppModule.instituicaoEnsinoRepo,
      atualizar,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _instituicaoComponent.obterInstituicoes();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_instituicaoComponent.carregando || _usuarioComponent.carregando || _autenticacaoComponent.carregando) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return BackgroundWidget(
      tema: tema,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
                child: CardBaseWidget(
                  largura: 640,
                  altura: obterAltura(context),
                  cursorDeClick: false,
                  padding: EdgeInsets.symmetric(
                    horizontal: tema.espacamento * 2,
                    vertical: tema.espacamento * 2,
                  ),
                  tema: tema,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_etapaCadastro != EtapaCadastro.REDIRECIONAMENTO)
                        Column(
                          children: [
                            Container(
                              width: 235,
                              child: LogoWidget(
                                tema: tema,
                                tamanho: tema.tamanhoFonteM * 2,
                              ),
                            ),
                            SizedBox(height: tema.espacamento * 2),
                            EtapasWidget(
                              tema: tema,
                              possuiQuatroEtapas: true,
                              etapaSelecionada: _etapaCadastro == null ? 1 : _etapaCadastro!.index + 1,
                            ),
                          ],
                        ),
                      Flexible(
                        flex: 12,
                        child: Padding(
                          padding: EdgeInsets.all(tema.espacamento * 2),
                          child: _obterPaginaAtual(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _obterPaginaAtual() {
    return switch (_etapaCadastro) {
      EtapaCadastro.DADOS_GERAIS => SizedBox(
          height: !Responsive.larguraP(context) ? 810 : 618,
          child: Column(
            children: [
              SizedBox(
                height: !Responsive.larguraP(context) ? 450 : 500,
                child: FormularioUsuarioWidget(
                  tema: tema,
                  atualizar: () => setState(() {}),
                  controllerConfirmacaoSenha: controllerConfirmacaoSenha,
                  controllerEmail: controllerEmail,
                  controllerNome: controllerNome,
                  controllerSenha: controllerSenha,
                  controllerTelefone: controllerTelefone,
                  controllerInstituicao: controllerInstituicao,
                  instituicoes: _instituicaoComponent.instituicoesPorNumero.values.map((e) => e.nome).toList(),
                  aoSelecionarInstituicao: (instituicao) => setState(() => controllerInstituicao.text = instituicao),
                  controllerUsuario: controllerNomeUsuario,
                  botaoInferior: SizedBox(),
                  aoCadastrar: () => atualizarPagina(EtapaCadastro.ENDERECO),
                ),
              ),
              BotaoWidget(
                tema: tema,
                texto: 'Próximo',
                nomeIcone: "seta/arrow-long-right",
                aoClicar: () async {
                  await notificarCasoErro(() async {
                    telefone = _obterTelefone;
                    email = Email.criar(controllerEmail.text.trim());
                    Usuario.validarNomeUsuario(controllerNomeUsuario.text.trim());
                    bool camposValidos = _validarCamposDadosGerais();
                    if (!camposValidos) return Notificacoes.mostrar("Preencha todos os campos corretamente!");
                    await _autenticacaoComponent.validarIdentificador(controllerNomeUsuario.text, controllerEmail.text);
                    atualizarPagina(EtapaCadastro.SENHA);
                  });
                },
              ),
              SizedBox(height: tema.espacamento * 2),
              BotaoWidget(
                tema: tema,
                texto: 'Voltar',
                corFundo: Color(tema.base100),
                corTexto: Color(tema.baseContent),
                nomeIcone: "seta/arrow-long-left",
                aoClicar: () => Rota.navegar(context, Rota.LOGIN),
              ),
            ],
          ),
        ),
      EtapaCadastro.SENHA => ConteudoCriacaoSenhaWidget(
          tema: tema,
          controllerSenha: controllerSenha,
          titulo: "Crie uma senha",
          controllerConfirmacaoSenha: controllerConfirmacaoSenha,
          atualizar: atualizar,
          navegarParaProximo: () {
            notificarCasoErro(() async {
              bool camposValidos = _validarCamposDadosGerais();
              if (!camposValidos) return Notificacoes.mostrar("Preencha todos os campos corretamente!");
              _autenticacaoComponent.atualizarSenha(controllerSenha.text);
              _autenticacaoComponent.atualizarConfirmacaoSenha(controllerConfirmacaoSenha.text);
              _autenticacaoState.validarSenha();
              atualizarPagina(EtapaCadastro.ENDERECO);
            });
          },
          navegarParaAnterior: () => atualizarPagina(EtapaCadastro.DADOS_GERAIS),
          mensagemErro: _mensagemErro,
        ),
      EtapaCadastro.ENDERECO => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormularioEnderecoWidget(
              tema: tema,
              atualizar: () => setState(() {}),
              estados: UF.values.map((e) => e.descricao).toList(),
              cidades: _usuarioComponent.municipiosPorNumero.values.map((e) => e.nome.toString()).toList(),
              aoSelecionarEstado: _selecionarEstado,
              aoSelecionarCidade: (cidade) => setState(() => controllerCidade.text = cidade),
              controllerRua: controllerRua,
              controllerBairro: controllerBairro,
              controllerCep: controllerCep,
              controllerNumero: controllerNumero,
              controllerComplemento: controllerComplemento,
              controllerCidade: controllerCidade,
              controllerEstado: controllerEstado,
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              texto: 'Próximo',
              nomeIcone: "seta/arrow-long-right",
              aoClicar: _criarUsuario,
            ),
            SizedBox(height: tema.espacamento * 2),
            BotaoWidget(
              tema: tema,
              texto: 'Voltar',
              corFundo: Color(tema.base100),
              corTexto: Color(tema.baseContent),
              nomeIcone: "seta/arrow-long-left",
              aoClicar: () => atualizarPagina(EtapaCadastro.DADOS_GERAIS),
            ),
          ],
        ),
      EtapaCadastro.CODIGO => ConteudoCodigoSegurancaWidget(
          tema: tema,
          controllerEmail: controllerEmail,
          controllerCodigoSeguranca: controllerCodigoSeguranca,
          atualizarPagina: () => atualizarPagina(EtapaCadastro.ENDERECO),
          validarCodigoSeguranca: _validarCodigoSeguranca,
          enviarNovoCodigo: enviarCodigoCriacao,
        ),
      _ => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextoWidget(
              texto: "Usuário criado com sucesso!",
              tema: tema,
              tamanho: tema.tamanhoFonteXG,
              align: TextAlign.center,
              weight: FontWeight.w500,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento * 2),
            const SvgWidget(
              nomeSvg: "pessoas_com_livro",
              altura: 280,
            ),
            SizedBox(height: tema.espacamento * 4),
            TextoWidget(
              texto: "Sua conta foi criada com sucesso!\nFaça o login e comece a compartilhar livros!",
              tema: tema,
              align: TextAlign.center,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              texto: 'Ir para login',
              nomeIcone: "seta/arrow-long-right",
              aoClicar: () => Rota.navegar(context, Rota.LOGIN),
            ),
          ],
        ),
    };
  }

  String get _mensagemErro {
    try {
      return Senha.obterErro(controllerSenha.text, controllerConfirmacaoSenha.text);
    } on SenhaInvalida catch (e) {
      return e.mensagem;
    }
  }

  Future<void> enviarCodigoCriacao() async {
    await notificarCasoErro(() async {
      await _autenticacaoComponent.enviarCodigoCriacaoUsuario(controllerEmail.text);
      Notificacoes.mostrar("Código enviado com sucesso!", Emoji.SUCESSO);
      atualizarPagina(EtapaCadastro.CODIGO);
    });
  }

  Future<void> _criarUsuario() async {
    notificarCasoErro(() async {
      _autenticacaoState.validarSenha();
      if (!_todosOsCamposEnderecoVazios()) {
        bool camposValidos = _validarCamposEndereco();
        if (!camposValidos) return Notificacoes.mostrar("Preencha todos os campos corretamente!");
      }
      _usuarioComponent.atualizarUsuarioMemoria(_obterUsuario());
      await _usuarioComponent.atualizarUsuario();
      atualizarPagina(EtapaCadastro.CODIGO);
    });
  }

  Future<void> _validarCodigoSeguranca() async {
    await notificarCasoErro(() async {
      if (controllerCodigoSeguranca.text.isEmpty)
        return Notificacoes.mostrar("Preencha o campo de código de segurança!");
      await _autenticacaoComponent.validarCodigoSeguranca(controllerCodigoSeguranca.text, controllerEmail.text);
      atualizarPagina(EtapaCadastro.REDIRECIONAMENTO);
    });
  }

  Future<void> _selecionarEstado(String estado) async {
    setState(() => controllerEstado.text = estado);
    await _usuarioComponent.obterCidades(UF.deDescricao(estado));
  }

  void atualizarPagina(EtapaCadastro? etapa) {
    setState(() => _etapaCadastro = etapa);
  }

  bool _validarCamposDadosGerais() {
    return controllerNome.text.isNotEmpty && controllerNomeUsuario.text.isNotEmpty && controllerEmail.text.isNotEmpty;
  }

  bool _todosOsCamposEnderecoVazios() {
    return controllerRua.text.isEmpty &&
        controllerBairro.text.isEmpty &&
        controllerCep.text.isEmpty &&
        controllerNumero.text.isEmpty &&
        (controllerCidade.text.isEmpty || controllerCidade.text == "Selecione") &&
        (controllerEstado.text.isEmpty || controllerEstado.text == "Selecione");
  }

  bool _validarCamposEndereco() {
    return controllerRua.text.isNotEmpty &&
        controllerBairro.text.isNotEmpty &&
        controllerCep.text.isNotEmpty &&
        controllerNumero.text.isNotEmpty &&
        controllerCidade.text.isNotEmpty &&
        controllerEstado.text.isNotEmpty;
  }

  Endereco? get endereco {
    Municipio? municipio = _usuarioComponent.municipiosPorNumero.values
        .where(
          (element) => element.nome == controllerCidade.text,
        )
        .firstOrNull;

    if (municipio == null) return null;

    return Endereco.criar(
      controllerNumero.text,
      controllerComplemento.text,
      controllerRua.text,
      controllerCep.text,
      controllerBairro.text,
      municipio,
      true,
    );
  }

  Usuario _obterUsuario() {
    InstituicaoDeEnsino? instituicao = _instituicaoComponent.instituicoesPorNumero.values
        .where(
          (element) => element.nome == controllerInstituicao.text,
        )
        .firstOrNull;

    return Usuario.criar(
      controllerNome.text.trim(),
      controllerNomeUsuario.text.trim(),
      Email.criar(controllerEmail.text.trim()),
      _obterTelefone,
      0,
      "",
      instituicao,
      null,
      "",
      "",
      endereco,
      _autenticacaoState.senha,
    );
  }

  double obterAltura(BuildContext context) {
    if (Responsive.larguraP(context) && _etapaCadastro == EtapaCadastro.ENDERECO) return 940;
    if (Responsive.larguraP(context) && _etapaCadastro == EtapaCadastro.DADOS_GERAIS) return 780;
    if (Responsive.larguraP(context)) return 682;

    return 750;
  }

  Telefone? get _obterTelefone {
    String telefone = controllerTelefone.text.replaceAll("(", "").replaceAll(")", "");
    telefone = telefone.replaceAll("-", "").replaceAll(" ", "");
    if (telefone.length < 11) throw TelefoneInvalido("Tente novamente!");

    return controllerTelefone.text.isNotEmpty
        ? Telefone.criar(
            telefone.trim().substring(2, 11),
            telefone.trim().substring(0, 2),
          )
        : null;
  }
}

enum EtapaCadastro {
  DADOS_GERAIS,
  SENHA,
  ENDERECO,
  CODIGO,
  REDIRECIONAMENTO,
}
