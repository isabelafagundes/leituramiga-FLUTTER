import 'package:flutter/material.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/usuario/email.dart';
import 'package:leituramiga/component/instituicao.component.dart';
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
import 'package:projeto_leituramiga/interface/widget/etapas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:auto_route/auto_route.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_etapaCadastro != EtapaCadastro.REDIRECIONAMENTO && Responsive.larguraP(context)) ...[
                SizedBox(height: tema.espacamento * 2),
                EtapasWidget(
                  tema: tema,
                  corFundo: Color(tema.base200),
                  etapaSelecionada: _etapaCadastro == null ? 1 : _etapaCadastro!.index + 1,
                ),
                SizedBox(height: tema.espacamento * 4),
              ],
              Responsive.larguraP(context)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: tema.espacamento * 2,
                        vertical: tema.espacamento,
                      ),
                      child: _obterPaginaAtual(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
                      child: CardBaseWidget(
                        largura: 650,
                        altura: 560,
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
                              Flexible(
                                child: EtapasWidget(
                                  tema: tema,
                                  etapaSelecionada: _etapaCadastro == null ? 1 : _etapaCadastro!.index + 1,
                                ),
                              ),
                            SizedBox(height: tema.espacamento * 2),
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
          height: 600,
          child: FormularioUsuarioWidget(
            tema: tema,
            controllerConfirmacaoSenha: controllerConfirmacaoSenha,
            controllerEmail: controllerEmail,
            controllerNome: controllerNome,
            controllerSenha: controllerSenha,
            controllerTelefone: controllerTelefone,
            controllerInstituicao: controllerInstituicao,
            instituicoes: _instituicaoComponent.instituicoesPorNumero.values.map((e) => e.nome).toList(),
            aoSelecionarInstituicao: (instituicao) => setState(() => controllerInstituicao.text = instituicao),
            controllerUsuario: controllerNomeUsuario,
            aoCadastrar: () => atualizarPagina(EtapaCadastro.ENDERECO),
          ),
        ),
      EtapaCadastro.ENDERECO => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormularioEnderecoWidget(
              tema: tema,
              estados: UF.values.map((e) => e.descricao).toList(),
              cidades: _usuarioComponent.municipiosPorNumero.values.map((e) => e.toString()).toList(),
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
          ],
        ),
      EtapaCadastro.CODIGO => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SvgWidget(
              nomeSvg: "codigo_verificacao",
              altura: 220,
            ),
            SizedBox(height: tema.espacamento * 4),
            TextoWidget(
              texto: "Informe o código de segurança enviado no email email@email.com!",
              tema: tema,
              align: TextAlign.center,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento * 2),
            SizedBox(
              width: 300,
              child: InputWidget(
                tema: tema,
                tipoInput: const TextInputType.numberWithOptions(decimal: false),
                controller: controllerCodigoSeguranca,
                alturaCampo: 35,
                onChanged: (texto) {},
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              texto: 'Próximo',
              nomeIcone: "seta/arrow-long-right",
              aoClicar: _validarCodigoSeguranca,
            ),
          ],
        ),
      _ => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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

  Future<void> _criarUsuario() async {
    notificarCasoErro(() async {
      _autenticacaoState.validarSenha();
      _usuarioComponent.atualizarUsuarioMemoria(_obterUsuario());
      atualizarPagina(EtapaCadastro.CODIGO);
      await _usuarioComponent.atualizarUsuario();
    });
  }

  Future<void> _validarCodigoSeguranca() async {
    await notificarCasoErro(() async {
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

  Endereco get endereco {
    Municipio municipio = _usuarioComponent.municipiosPorNumero.values.firstWhere(
      (element) => element.toString() == controllerCidade.text,
    );

    return Endereco.criar(
      controllerRua.text,
      controllerBairro.text,
      controllerCep.text,
      controllerNumero.text,
      controllerComplemento.text,
      municipio,
    );
  }

  Usuario _obterUsuario() {
    return Usuario.criar(
      controllerNome.text,
      controllerNomeUsuario.text,
      Email.criar(controllerEmail.text),
      controllerTelefone.text.isNotEmpty
          ? Telefone.criar(
              controllerTelefone.text.substring(0, 1),
              controllerTelefone.text.substring(2, 11),
            )
          : null,
      0,
      "",
      null,
      null,
      "",
      "",
      endereco,
      _autenticacaoState.senha,
    );
  }
}

enum EtapaCadastro {
  DADOS_GERAIS,
  ENDERECO,
  CODIGO,
  REDIRECIONAMENTO,
}
