import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_base.widget.dart';
import 'package:projeto_leituramiga/interface/widget/etapas.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class EsqueceSenhaPage extends StatefulWidget {
  const EsqueceSenhaPage({super.key});

  @override
  State<EsqueceSenhaPage> createState() => _EsqueceSenhaPageState();
}

class _EsqueceSenhaPageState extends State<EsqueceSenhaPage> {
  final TextEditingController controllerRua = TextEditingController();
  final TextEditingController controllerBairro = TextEditingController();
  final TextEditingController controllerCep = TextEditingController();
  final TextEditingController controllerNumero = TextEditingController();
  final TextEditingController controllerComplemento = TextEditingController();
  final TextEditingController controllerCidade = TextEditingController();
  final TextEditingController controllerEstado = TextEditingController();
  EtapaSenha? _etapaCadastro = EtapaSenha.EMAIL;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

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
              if (_etapaCadastro != EtapaSenha.REDIRECIONAMENTO && Responsive.larguraP(context)) ...[
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
                            if (_etapaCadastro != EtapaSenha.REDIRECIONAMENTO)
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
      EtapaSenha.EMAIL => SizedBox(
          height: 600,
          child: FormularioUsuarioWidget(
            tema: tema,
            atualizar: () => setState(() {}),
            controllerConfirmacaoSenha: TextEditingController(),
            controllerEmail: TextEditingController(),
            controllerNome: TextEditingController(),
            controllerSenha: TextEditingController(),
            controllerUsuario: TextEditingController(),
            aoCadastrar: () => atualizarPagina(EtapaSenha.CODIGO),
            controllerTelefone: TextEditingController(),
            controllerInstituicao: TextEditingController(),
            instituicoes: [],
            aoSelecionarInstituicao: (String) {},
          ),
        ),
      EtapaSenha.CODIGO => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormularioEnderecoWidget(
              atualizar: () => setState(() {}),
              tema: tema,
              estados: [],
              cidades: [],
              aoSelecionarEstado: (estado) => setState(() => controllerEstado.text = estado),
              aoSelecionarCidade: (cidade) => setState(() => controllerCidade.text = cidade),
              controllerRua: TextEditingController(),
              controllerBairro: TextEditingController(),
              controllerCep: TextEditingController(),
              controllerNumero: TextEditingController(),
              controllerComplemento: TextEditingController(),
              controllerCidade: TextEditingController(),
              controllerEstado: TextEditingController(),
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              texto: 'Próximo',
              nomeIcone: "seta/arrow-long-right",
              aoClicar: () => atualizarPagina(EtapaSenha.CODIGO),
            ),
          ],
        ),
      EtapaSenha.CODIGO => Column(
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
                controller: TextEditingController(),
                onChanged: (texto) {},
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            BotaoWidget(
              tema: tema,
              texto: 'Próximo',
              nomeIcone: "seta/arrow-long-right",
              aoClicar: () => atualizarPagina(EtapaSenha.REDIRECIONAMENTO),
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

  void atualizarPagina(EtapaSenha? etapa) {
    setState(() => _etapaCadastro = etapa);
  }
}

enum EtapaSenha {
  EMAIL,
  CODIGO,
  CONFIRMACAO_SENHA,
  REDIRECIONAMENTO,
}
