import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/component/usuario.component.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/conteudo_codigo_seguranca.widget.dart';
import 'package:projeto_leituramiga/interface/widget/etapas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/logo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class AtivarUsuarioPage extends StatefulWidget {
  final String identificadorUsuario;

  const AtivarUsuarioPage({
    super.key,
    @PathParam("usuario") required this.identificadorUsuario,
  });

  @override
  State<AtivarUsuarioPage> createState() => _AtivarUsuarioPageState();
}

class _AtivarUsuarioPageState extends State<AtivarUsuarioPage> {
  AutenticacaoComponent _autenticacaoComponent = AutenticacaoComponent();
  UsuarioComponent _usuarioComponent = UsuarioComponent();
  final TextEditingController controllerCodigoSeguranca = TextEditingController();
  EtapaAtivacaoUsuario? _etapaSenha = EtapaAtivacaoUsuario.CODIGO;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  String get _email => _usuarioComponent.email?.endereco ?? "";

  @override
  void initState() {
    _autenticacaoComponent.inicializar(
      AppModule.autenticacaoService,
      AppModule.sessaoService,
      AppModule.usuarioRepo,
      atualizar,
    );
    _usuarioComponent.inicializar(
      AppModule.usuarioRepo,
      AppModule.comentarioRepo,
      AppModule.enderecoRepo,
      AppModule.livroRepo,
      atualizar,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await notificarCasoErro(() async {
        await _usuarioComponent.obterIdentificadorUsuario(widget.identificadorUsuario);
        await _autenticacaoComponent.enviarCodigoCriacaoUsuario(_email);
      });
    });
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
              Padding(
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
                      if (_etapaSenha != EtapaAtivacaoUsuario.REDIRECIONAMENTO)
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
                          padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
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
      EtapaAtivacaoUsuario.CODIGO => ConteudoCodigoSegurancaWidget(
          tema: tema,
          controllerEmail: TextEditingController(text: _email),
          controllerCodigoSeguranca: controllerCodigoSeguranca,
          atualizarPagina: () => Rota.navegar(context, Rota.LOGIN),
          validarCodigoSeguranca: verificarCodigoSeguranca,
          enviarNovoCodigo: enviarCodigoRecuperacao,
        ),
      EtapaAtivacaoUsuario.REDIRECIONAMENTO => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextoWidget(
              texto: "Usuário ativado com sucesso!",
              tema: tema,
              tamanho: tema.tamanhoFonteXG,
              align: TextAlign.center,
              weight: FontWeight.w500,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento * 2),
            const SvgWidget(
              nomeSvg: "garota_lendo_com_oculos",
              altura: 280,
            ),
            SizedBox(height: tema.espacamento * 3),
            TextoWidget(
              texto: "Usuário ativado com sucesso!\nFaça o login e comece a compartilhar livros!",
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
      await _autenticacaoComponent.enviarCodigoCriacaoUsuario(_email);
      Notificacoes.mostrar("Código enviado com sucesso!", Emoji.SUCESSO);
      atualizarPagina(EtapaAtivacaoUsuario.CODIGO);
    });
  }

  Future<void> verificarCodigoSeguranca() async {
    await notificarCasoErro(() async {
      await _autenticacaoComponent.validarCodigoSeguranca(controllerCodigoSeguranca.text, _email);
      atualizarPagina(EtapaAtivacaoUsuario.REDIRECIONAMENTO);
    });
  }

  void atualizarPagina(EtapaAtivacaoUsuario? etapa) {
    setState(() => _etapaSenha = etapa);
  }
}

enum EtapaAtivacaoUsuario {
  CODIGO,
  REDIRECIONAMENTO,
}
