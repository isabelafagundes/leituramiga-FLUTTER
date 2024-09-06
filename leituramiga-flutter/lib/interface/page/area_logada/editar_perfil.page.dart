import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/formulario/formulario_usuario.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class EditarPefilPage extends StatefulWidget {
  const EditarPefilPage({super.key});

  @override
  State<EditarPefilPage> createState() => _EditarPefilPageState();
}

class _EditarPefilPageState extends State<EditarPefilPage> {
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
  EditarPerfil? _estagioAtual = EditarPerfil.DADOS_GERAIS;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        alterarTema: _alterarTema,
        alterarFonte: _alterarFonte,
        child: SizedBox(
          height: 1200,
          child: Flex(
            mainAxisSize: MainAxisSize.max,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
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
                  ],
                ),
              ),
              SizedBox(width: tema.espacamento * 2),
              Flexible(flex: 2, child: _obterPagina),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _obterPagina {
    return switch (_estagioAtual) {
      EditarPerfil.DADOS_GERAIS => Column(
          children: [
            FormularioUsuarioWidget(
              tema: tema,
              controllerConfirmacaoSenha: controllerConfirmacaoSenha,
              controllerEmail: controllerEmail,
              controllerNome: controllerNome,
              controllerSenha: controllerSenha,
              controllerUsuario: controllerNomeUsuario,
              aoCadastrar: () {},
            ),
          ],
        ),
      EditarPerfil.ENDERECO => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormularioEnderecoWidget(
              tema: tema,
              estados: [],
              cidades: [],
              aoSelecionarEstado: (estado) => setState(() => controllerEstado.text = estado),
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
              texto: 'Salvar',
              nomeIcone: "seta/arrow-long-right",
              aoClicar: () {},
            ),
          ],
        ),
      _ => const SizedBox(),
    };
  }

  void atualizarPagina(EditarPerfil? etapa) {
    setState(() => _estagioAtual = etapa);
  }

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }
}

enum EditarPerfil {
  DADOS_GERAIS,
  ENDERECO,
  EXCLUIR,
}
