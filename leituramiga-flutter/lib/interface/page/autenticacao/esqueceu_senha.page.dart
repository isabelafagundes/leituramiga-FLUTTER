import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/domain/senha.dart';
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
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/logo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class EsqueceSenhaPage extends StatefulWidget {
  const EsqueceSenhaPage({super.key});

  @override
  State<EsqueceSenhaPage> createState() => _EsqueceSenhaPageState();
}

class _EsqueceSenhaPageState extends State<EsqueceSenhaPage> {
  AutenticacaoComponent _autenticacaoComponent = AutenticacaoComponent();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerCodigoSeguranca = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerConfirmacaoSenha = TextEditingController();
  EtapaSenha? _etapaSenha = EtapaSenha.EMAIL;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  @override
  void initState() {
    _autenticacaoComponent.inicializar(
      AppModule.autenticacaoService,
      AppModule.sessaoService,
      AppModule.usuarioRepo,
      atualizar,
    );
    super.initState();
  }

  void atualizar() => setState(() {});

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
              if (_etapaSenha != EtapaSenha.REDIRECIONAMENTO && Responsive.larguraP(context)) ...[
                SizedBox(height: tema.espacamento * 2),
                Container(
                  width: 235,
                  child: LogoWidget(
                    tema: tema,
                    tamanho: tema.tamanhoFonteM * 2,
                  ),
                ),
                SizedBox(height: tema.espacamento * 3),
                EtapasWidget(
                  tema: tema,
                  possuiQuatroEtapas: true,
                  corFundo: Color(tema.base200),
                  etapaSelecionada: _etapaSenha == null ? 1 : _etapaSenha!.index + 1,
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
                        largura: 640,
                        altura: 740,
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
                            if (_etapaSenha != EtapaSenha.REDIRECIONAMENTO)
                              Column(
                                children: [
                                  SizedBox(height: tema.espacamento * 2),
                                  Container(
                                    width: 235,
                                    child: LogoWidget(
                                      tema: tema,
                                      tamanho: tema.tamanhoFonteM * 2,
                                    ),
                                  ),
                                  SizedBox(height: tema.espacamento * 3),
                                  EtapasWidget(
                                    tema: tema,
                                    possuiQuatroEtapas: true,
                                    etapaSelecionada: _etapaSenha == null ? 1 : _etapaSenha!.index + 1,
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
    return switch (_etapaSenha) {
      EtapaSenha.EMAIL => Column(
          children: [
            SvgWidget(
              nomeSvg: 'moca_esqueceu_senha',
              altura: 220,
            ),
            SizedBox(height: tema.espacamento),
            TextoWidget(
              texto: "Esqueceu sua senha?",
              tema: tema,
              weight: FontWeight.w500,
              tamanho: tema.tamanhoFonteG,
              align: TextAlign.center,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento * 2),
            TextoWidget(
              texto: "Informe o email cadastrado para \nreceber um código de segurança",
              tema: tema,
              align: TextAlign.center,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento * 2),
            SizedBox(
              width: 300,
              child: InputWidget(
                tema: tema,
                label: "Email",
                tipoInput: const TextInputType.numberWithOptions(decimal: false),
                controller: controllerEmail,
                alturaCampo: 40,
                formatters: [LengthLimitingTextInputFormatter(260)],
                onChanged: (texto) {},
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              texto: 'Próximo',
              nomeIcone: "seta/arrow-long-right",
              aoClicar:iniciarRecuperacaoSenha ,
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
      EtapaSenha.CODIGO => ConteudoCodigoSegurancaWidget(
          tema: tema,
          controllerEmail: controllerEmail,
          controllerCodigoSeguranca: controllerCodigoSeguranca,
          atualizarPagina: () => atualizarPagina(EtapaSenha.CODIGO),
          validarCodigoSeguranca: verificarCodigoSeguranca,
          enviarNovoCodigo: enviarCodigoRecuperacao,
        ),
      EtapaSenha.CONFIRMACAO_SENHA => ConteudoCriacaoSenhaWidget(
          tema: tema,
          controllerSenha: controllerSenha,
          controllerConfirmacaoSenha: controllerConfirmacaoSenha,
          mensagemErro: _mensagemErro,
          navegarParaAnterior: () => atualizarPagina(EtapaSenha.CONFIRMACAO_SENHA),
          navegarParaProximo: atualizarSenha,
          atualizar: atualizar,
        ),
      EtapaSenha.REDIRECIONAMENTO => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SvgWidget(
              nomeSvg: "garota_lendo_com_oculos",
              altura: 280,
            ),
            SizedBox(height: tema.espacamento * 6),
            TextoWidget(
              texto: "Senha recuperada com sucesso!\nFaça o login e comece a compartilhar livros!",
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
      _ => Container(),
    };
  }

  Future<void> enviarCodigoRecuperacao() async {
    await notificarCasoErro(() async {
      await _autenticacaoComponent.enviarCodigoRecuperacao(controllerEmail.text);
      Notificacoes.mostrar("Código enviado com sucesso!", Emoji.SUCESSO);
      atualizarPagina(EtapaSenha.CODIGO);
    });
  }

  Future<void> verificarCodigoSeguranca() async {
    await notificarCasoErro(() async {
      await _autenticacaoComponent.validarCodigoRecuperacao(controllerCodigoSeguranca.text, controllerEmail.text);
      atualizarPagina(EtapaSenha.CONFIRMACAO_SENHA);
    });
  }

  Future<void> iniciarRecuperacaoSenha() async {
    await notificarCasoErro(() async {
      if(controllerEmail.text.isEmpty) throw Exception("Informe o email");
      await _autenticacaoComponent.iniciarRecuperacaoSenha(controllerEmail.text);
      atualizarPagina(EtapaSenha.CODIGO);
    });
  }

  Future<void> atualizarSenha() async {
    await notificarCasoErro(() async {
      _autenticacaoComponent.atualizarSenha(controllerSenha.text);
      _autenticacaoComponent.atualizarConfirmacaoSenha(controllerConfirmacaoSenha.text);
      _autenticacaoState.validarSenha();
      await _autenticacaoComponent.atualizarRecuperacaoSenha();
      atualizarPagina(EtapaSenha.REDIRECIONAMENTO);
    });
  }

  String get _mensagemErro {
    try {
      return Senha.obterErro(controllerSenha.text, controllerConfirmacaoSenha.text);
    } on SenhaInvalida catch (e) {
      return e.mensagem;
    }
  }

  void atualizarPagina(EtapaSenha? etapa) {
    setState(() => _etapaSenha = etapa);
  }
}

enum EtapaSenha {
  EMAIL,
  CODIGO,
  CONFIRMACAO_SENHA,
  REDIRECIONAMENTO,
}
