import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/logo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AutenticacaoComponent autenticacaoComponent = AutenticacaoComponent();

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    autenticacaoComponent.inicializar(
      AppModule.autenticacaoService,
      AppModule.sessaoService,
      AppModule.usuarioRepo,
      atualizar,
    );
  }

  void atualizar() {
    if (mounted) setState(() {});
  }

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: SingleChildScrollView(
        child: SizedBox(
          height: Responsive.altura(context),
          width: Responsive.largura(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: tema.espacamento * 2),
                  child: CardBaseWidget(
                    largura: 850,
                    altura: 550,
                    cursorDeClick: false,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.larguraP(context) ? tema.espacamento * 3 : tema.espacamento * 6,
                      vertical: tema.espacamento * 3,
                    ),
                    tema: tema,
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (Responsive.largura(context) > 700)
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgWidget(
                                  nomeSvg: "garota_login",
                                  altura: 350,
                                ),
                                SizedBox(height: tema.espacamento * 2),
                                SizedBox(
                                  child: TextoWidget(
                                    tema: tema,
                                    align: TextAlign.center,
                                    texto:
                                        "Descubra, troque, e doe livros enquanto transforma sua experiência de leitura ainda mais incrivel!",
                                    cor: Color(tema.baseContent),
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (Responsive.largura(context) > 1200) ...[
                          SizedBox(width: tema.espacamento * 6),
                          Container(
                            width: 2,
                            color: Color(tema.neutral).withOpacity(.1),
                            height: 450,
                          ),
                          SizedBox(width: tema.espacamento * 6),
                        ],
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 235,
                                    child: LogoWidget(
                                      tema: tema,
                                      tamanho: tema.tamanhoFonteM * 2,
                                    ),
                                  ),
                                  SizedBox(height: tema.espacamento),
                                  TextoWidget(
                                    texto: "Bem-vindo(a)! ",
                                    tamanho: tema.tamanhoFonteG,
                                    tema: tema,
                                    align: TextAlign.center,
                                    cor: Color(tema.baseContent),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InputWidget(
                                tema: tema,
                                controller: emailController,
                                label: "Email ou usuário",
                                tamanho: tema.tamanhoFonteM,
                                onChanged: (valor) {},
                              ),
                              SizedBox(height: tema.espacamento * 2),
                              InputWidget(
                                tema: tema,
                                controller: senhaController,
                                label: "Senha",
                                senha: true,
                                tamanho: tema.tamanhoFonteM,
                                onChanged: (valor) {},
                              ),
                              SizedBox(height: tema.espacamento / 1.5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () => Rota.navegar(context, Rota.SENHA),
                                  child: TextoWidget(
                                    texto: "Esqueceu sua senha?",
                                    tamanho: tema.tamanhoFonteM,
                                    tema: tema,
                                    weight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    align: TextAlign.center,
                                    cor: Color(tema.baseContent),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              BotaoWidget(
                                tema: tema,
                                texto: 'Login',
                                nomeIcone: "seta/arrow-long-right",
                                aoClicar: _logar,
                              ),
                              SizedBox(height: tema.espacamento * 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextoWidget(
                                    tema: tema,
                                    texto: "Não tem uma conta?",
                                    tamanho: tema.tamanhoFonteM,
                                    align: TextAlign.center,
                                    cor: Color(tema.baseContent),
                                  ),
                                  SizedBox(width: tema.espacamento),
                                  GestureDetector(
                                    onTap: () => Rota.navegar(context, Rota.CADASTRO_USUARIO),
                                    child: TextoWidget(
                                      texto: "Crie já!",
                                      tamanho: tema.tamanhoFonteM,
                                      weight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      align: TextAlign.center,
                                      tema: tema,
                                      cor: Color(tema.accent),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: tema.espacamento * 2),
                            ],
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
      ),
    );
  }

  void _validarCredenciais() {
    if (emailController.text.isEmpty || senhaController.text.isEmpty) {
      Notificacoes.mostrar("Preencha todos os campos", Emoji.ALERTA);
      throw Exception("Preencha todos os campos");
    }
  }

  Future<void> _logar() async {
    _validarCredenciais();
    await notificarCasoErro(() async {
      try {
        await autenticacaoComponent.logar(emailController.text, senhaController.text);
        Rota.navegar(context, Rota.AREA_LOGADA);
      } on UsuarioNaoAtivo catch (e) {
        Notificacoes.mostrar(e.toString(), Emoji.ERRO);
        Rota.navegarComArgumentos(
            context,
            AtivarUsuarioRoute(
              identificadorUsuario: emailController.text,
            ));
      } catch (e) {
        Notificacoes.mostrar(e.toString(), Emoji.ERRO);
      }
    });
  }
}
