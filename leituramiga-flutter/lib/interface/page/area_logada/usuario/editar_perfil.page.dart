import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/component/instituicao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/usuario/telefone.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_edicao_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/pop_up_padrao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class EditarPefilPage extends StatefulWidget {
  const EditarPefilPage({super.key});

  @override
  State<EditarPefilPage> createState() => _EditarPefilPageState();
}

class _EditarPefilPageState extends State<EditarPefilPage> {
  UsuarioComponent _usuarioComponent = UsuarioComponent();
  InstituicaoComponent _instituicaoComponent = InstituicaoComponent();
  AutenticacaoComponent _autenticacaoComponent = AutenticacaoComponent();
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
  final TextEditingController controllerTelefone = TextEditingController();
  final TextEditingController controllerInstituicaoEnsino = TextEditingController();
  final TextEditingController controllerDescricao = TextEditingController();
  EditarPerfil? _estagioAtual = EditarPerfil.DADOS_GERAIS;
  bool _carregando = false;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

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
    _instituicaoComponent.inicializar(
      AppModule.instituicaoEnsinoRepo,
      atualizar,
    );
    _autenticacaoComponent.inicializar(
      AppModule.autenticacaoService,
      AppModule.sessaoService,
      AppModule.usuarioRepo,
      atualizar,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => _carregando = true);
      await _usuarioComponent.obterPerfil();
      await _instituicaoComponent.obterInstituicoes();
      await notificarCasoErro(() async => await _usuarioComponent.obterEndereco(), false);
      if (_usuarioComponent.enderecoEdicao != null)
        await _usuarioComponent.obterCidades(_usuarioComponent.enderecoEdicao!.municipio.estado);
      _preencherControllers();
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
        atualizar: () => setState(() {}),
        carregando: _usuarioComponent.carregando ||
            _instituicaoComponent.carregando ||
            _autenticacaoComponent.carregando ||
            _carregando ||
            _usuarioComponent.usuarioSelecionado == null,
        voltar: () => Rota.navegar(context, Rota.HOME),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Responsive.larguraP(context) ? 1000 : Responsive.altura(context) * .8,
            child: Flex(
              direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Responsive.larguraP(context) ? Responsive.largura(context) : 350,
                  height: 185,
                  child: Column(
                    children: [
                      TextoWidget(
                        tema: tema,
                        texto: "Configurações",
                        tamanho: tema.tamanhoFonteXG,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: tema.espacamento),
                      BotaoMenuWidget(
                        tema: tema,
                        iconeAEsquerda: false,
                        textoLabel: "Editar dados gerais",
                        nomeSvg: "usuario/user",
                        executar: () => atualizarPagina(EditarPerfil.DADOS_GERAIS),
                        ativado: _estagioAtual == EditarPerfil.DADOS_GERAIS,
                      ),
                      SizedBox(height: tema.espacamento),
                      BotaoMenuWidget(
                        tema: tema,
                        iconeAEsquerda: false,
                        textoLabel: "Editar endereço",
                        nomeSvg: "menu/map-pin",
                        executar: () => atualizarPagina(EditarPerfil.ENDERECO),
                        ativado: _estagioAtual == EditarPerfil.ENDERECO,
                      ),
                      SizedBox(height: tema.espacamento),
                      BotaoMenuWidget(
                        tema: tema,
                        iconeAEsquerda: false,
                        textoLabel: "Excluir usuário",
                        nomeSvg: "exclusao/trash",
                        executar: () => atualizarPagina(EditarPerfil.EXCLUIR),
                        ativado: _estagioAtual == EditarPerfil.EXCLUIR,
                      ),
                      SizedBox(height: tema.espacamento * 2),
                    ],
                  ),
                ),
                SizedBox(width: tema.espacamento * 2),
                Expanded(
                  child: SizedBox(height: Responsive.altura(context), child: _obterPagina),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _obterPagina {
    return switch (_estagioAtual) {
      EditarPerfil.DADOS_GERAIS => FormularioEdicaoUsuarioWidget(
          tema: tema,
          atualizar: () => setState(() {}),
          controllerDescricao: controllerDescricao,
          controllerConfirmacaoSenha: controllerConfirmacaoSenha,
          controllerEmail: controllerEmail,
          controllerNome: controllerNome,
          controllerInstituicao: controllerInstituicaoEnsino,
          controllerTelefone: controllerTelefone,
          instituicoes: _instituicaoComponent.instituicoesPorNumero.values.map((e) => e.nome.toString()).toList(),
          controllerSenha: controllerSenha,
          controllerUsuario: controllerNomeUsuario,
          aoCadastrar: () {},
          botaoInferior: BotaoWidget(
            tema: tema,
            texto: 'Salvar',
            nomeIcone: "seta/arrow-long-right",
            icone: Icon(Icons.check, color: Color(tema.base200)),
            aoClicar: _salvarUsuario,
          ),
          aoSelecionarInstituicao: (instituicao) => setState(() => controllerInstituicaoEnsino.text = instituicao),
        ),
      EditarPerfil.ENDERECO => FormularioEnderecoWidget(
          tema: tema,
          aoSalvar: () {},
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
          botaoInferior: Column(
            children: [
              BotaoWidget(
                tema: tema,
                texto: 'Salvar',
                nomeIcone: "seta/arrow-long-right",
                icone: Icon(Icons.check, color: Color(tema.base200)),
                aoClicar: _salvarEndereco,
              ),
              SizedBox(height: tema.espacamento * 2),
              if (_usuarioComponent.enderecoEdicao != null)
                BotaoWidget(
                  tema: tema,
                  texto: 'Excluir endereço',
                  nomeIcone: "seta/arrow-long-right",
                  corFundo: Color(tema.error),
                  icone: Icon(Icons.delete, color: Color(tema.base200)),
                  aoClicar: _excluirEndereco,
                ),
            ],
          ),
        ),
      EditarPerfil.EXCLUIR => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextoWidget(
              texto: "Excluir usuário",
              tema: tema,
              tamanho: tema.tamanhoFonteXG,
              weight: FontWeight.w500,
            ),
            SizedBox(height: tema.espacamento * 2),
            SvgWidget(
              nomeSvg: "",
              caminhoCompleto: Emoji.ERRO.icone,
              altura: 90,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento * 2),
            TextoWidget(
              texto:
                  "Ao selecionar \"excluir\", sua conta será desativada e você não poderá mais usar o LeiturAmiga :(\nTem certeza que deseja continuar? ",
              tema: tema,
              tamanho: tema.tamanhoFonteG,
              align: TextAlign.center,
            ),
            SizedBox(height: tema.espacamento * 4),
            SizedBox(height: tema.espacamento * 2),
            BotaoWidget(
              tema: tema,
              texto: 'Sim, excluir',
              nomeIcone: "seta/arrow-long-right",
              corFundo: Color(tema.error),
              icone: Icon(Icons.delete, color: Color(tema.base200)),
              aoClicar: _excluirUsuario,
            ),
          ],
        ),
      _ => SizedBox(),
    };
  }

  Future<void> _salvarUsuario() async {
    try {
      setState(() => _carregando = true);
      _usuarioComponent.atualizarUsuarioMemoria(usuario);
      await notificarCasoErro(() async => await _usuarioComponent.atualizarUsuario());
      Notificacoes.mostrar("Usuário atualizado com sucesso", Emoji.SUCESSO);
    } catch (e) {
      Notificacoes.mostrar("Erro ao atualizar usuário", Emoji.ERRO);
    }
    setState(() => _carregando = false);
  }

  Future<void> _salvarEndereco() async {
    try {
      setState(() => _carregando = true);
      if (!_validarCamposEndereco() || endereco == null) {
        return Notificacoes.mostrar("Preencha todos os campos do endereço");
      }
      _usuarioComponent.atualizarEnderecoMemoria(endereco!);
      await notificarCasoErro(() async => await _usuarioComponent.atualizarEndereco());
      Notificacoes.mostrar("Endereço atualizado com sucesso", Emoji.SUCESSO);
    } catch (e) {
      Notificacoes.mostrar("Erro ao atualizar usuário", Emoji.ERRO);
    }

    setState(() => _carregando = false);
  }

  Future<void> _excluirEndereco() async {
    try {
      setState(() => _carregando = true);
      bool? excluir = await showDialog(
          context: context, builder: (context) => _obterPopUpPadrao(context, "Deseja realmente excluir o endereço?"));
      if (excluir == null) return;
      if (excluir)
        await notificarCasoErro(() async {
          await _usuarioComponent.desativarEndereco(_usuarioComponent.enderecoEdicao!.numero!);
          Notificacoes.mostrar("Endereço excluído com sucesso!", Emoji.SUCESSO);
          Rota.navegar(context, Rota.PERFIL);
        });
    } catch (e) {
      Notificacoes.mostrar("Erro ao excluir endereço", Emoji.ERRO);
    }
    setState(() => _carregando = false);
  }

  Future<void> _excluirUsuario() async {
    bool? excluir = await showDialog(
        context: context,
        builder: (context) {
          return _obterPopUpPadrao(context, "Deseja realmente excluir sua conta?");
        });
    if (excluir == null) return;
    if (excluir)
      await notificarCasoErro(() async {
        await _usuarioComponent.desativarUsuario();
        await _autenticacaoComponent.deslogar();
        Rota.navegar(context, Rota.AUTENTICACAO);
      });
  }

  Future<void> _selecionarEstado(String estado) async {
    setState(() => controllerEstado.text = estado);
    await _usuarioComponent.obterCidades(UF.deDescricao(estado));
  }

  bool _validarCamposDadosGerais() {
    return controllerNome.text.isNotEmpty &&
        controllerNomeUsuario.text.isNotEmpty &&
        controllerEmail.text.isNotEmpty &&
        controllerSenha.text.isNotEmpty &&
        controllerConfirmacaoSenha.text.isNotEmpty &&
        controllerSenha.text == controllerConfirmacaoSenha.text;
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

    return Endereco.carregar(
      _usuarioComponent.enderecoEdicao?.numero,
      controllerNumero.text,
      controllerComplemento.text,
      controllerRua.text,
      controllerCep.text,
      controllerBairro.text,
      municipio,
      true,
    );
  }

  Usuario get usuario {
    InstituicaoDeEnsino? instituicao = _instituicaoComponent.instituicoesPorNumero.values
        .where(
          (element) => element.nome == controllerInstituicaoEnsino.text,
        )
        .firstOrNull;

    return Usuario.criar(
      controllerNome.text,
      _usuarioComponent.usuarioSelecionado!.nomeUsuario,
      _usuarioComponent.usuarioSelecionado!.email,
      _obterTelefone,
      0,
      controllerDescricao.text,
      instituicao,
      null,
      "",
      "",
      endereco,
      null,
    );
  }

  Telefone? get _obterTelefone {
    String telefone = controllerTelefone.text.replaceAll("(", "").replaceAll(")", "");
    telefone = telefone.replaceAll("-", "").replaceAll(" ", "");

    return controllerTelefone.text.isNotEmpty
        ? Telefone.criar(
            telefone.trim().substring(2, 11),
            telefone.trim().substring(0, 2),
          )
        : null;
  }

  void _preencherControllers() {
    controllerNome.text = _usuarioComponent.usuarioSelecionado!.nome;
    controllerNomeUsuario.text = _usuarioComponent.usuarioSelecionado!.nomeUsuario;
    controllerEmail.text = _usuarioComponent.usuarioSelecionado!.email.endereco;
    controllerTelefone.text = _usuarioComponent.usuarioSelecionado?.telefone?.telefoneFormatado ?? "";
    controllerInstituicaoEnsino.text = _usuarioComponent.usuarioSelecionado!.nomeInstituicao;
    controllerRua.text = _usuarioComponent.enderecoEdicao?.rua ?? "";
    controllerBairro.text = _usuarioComponent.enderecoEdicao?.bairro ?? "";
    controllerCep.text = _usuarioComponent.enderecoEdicao?.cep ?? "";
    controllerNumero.text = _usuarioComponent.enderecoEdicao?.numeroResidencial?.toString() ?? "";
    controllerComplemento.text = _usuarioComponent.enderecoEdicao?.complemento ?? "";
    controllerCidade.text = _usuarioComponent.enderecoEdicao?.municipio.nome ?? "";
    controllerEstado.text = _usuarioComponent.enderecoEdicao?.municipio.estado.descricao ?? "";
    String descricao = _usuarioComponent.usuarioSelecionado?.descricao ?? "";
    controllerDescricao.text = descricao.isEmpty ? "Olá! Estou usando o LeiturAmiga!" : descricao;
    setState(() {});
  }

  void atualizarPagina(EditarPerfil? etapa) {
    setState(() => _estagioAtual = etapa);
  }

  Widget _obterPopUpPadrao(BuildContext context, String texto) {
    return PopUpPadraoWidget(
      tema: tema,
      naoRedimensionar: true,
      conteudo: Container(
        height: 320,
        width: 320,
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
                texto: texto,
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
                    Icons.delete,
                    color: Color(tema.base200),
                  ),
                  corFundo: Color(tema.error),
                  texto: "Excluir",
                  aoClicar: () => Navigator.of(context).pop(true),
                ),
                SizedBox(height: tema.espacamento * 2),
                BotaoWidget(
                  tema: tema,
                  icone: SvgWidget(
                    nomeSvg: 'seta/arrow-long-left',
                    cor: Color(tema.baseContent),
                  ),
                  texto: "Voltar",
                  corFundo: Color(tema.base200),
                  corTexto: Color(tema.baseContent),
                  aoClicar: () => Navigator.of(context).pop(false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum EditarPerfil {
  DADOS_GERAIS,
  ENDERECO,
  EXCLUIR,
}
