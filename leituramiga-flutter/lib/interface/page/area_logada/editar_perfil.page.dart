import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
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
  final TextEditingController controllerTelefone = TextEditingController();
  final TextEditingController controllerInstituicaoEnsino = TextEditingController();
  EditarPerfil? _estagioAtual = EditarPerfil.DADOS_GERAIS;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        atualizar: () => setState(() {}),
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
      EditarPerfil.DADOS_GERAIS => FormularioUsuarioWidget(
          tema: tema,
          controllerConfirmacaoSenha: controllerConfirmacaoSenha,
          controllerEmail: controllerEmail,
          controllerNome: controllerNome,
          controllerInstituicao: controllerInstituicaoEnsino,
          controllerTelefone: controllerTelefone,
          instituicoes: [],
          controllerSenha: controllerSenha,
          controllerUsuario: controllerNomeUsuario,
          aoCadastrar: () {},
          botaoInferior: BotaoWidget(
            tema: tema,
            texto: 'Salvar',
            nomeIcone: "seta/arrow-long-right",
            icone: Icon(Icons.check, color: kCorFonte),
            aoClicar: () {},
          ),
          aoSelecionarInstituicao: (instituicao) => setState(() => controllerInstituicaoEnsino.text = instituicao),
        ),
      EditarPerfil.ENDERECO => FormularioEnderecoWidget(
          tema: tema,
          aoSalvar: () {},
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
          botaoInferior: BotaoWidget(
            tema: tema,
            texto: 'Salvar',
            nomeIcone: "seta/arrow-long-right",
            icone: Icon(Icons.check, color: kCorFonte),
            aoClicar: () {},
          ),
        ),
      _ => const SizedBox(),
    };
  }

  void atualizarPagina(EditarPerfil? etapa) {
    setState(() => _estagioAtual = etapa);
  }
}

enum EditarPerfil {
  DADOS_GERAIS,
  ENDERECO,
  EXCLUIR,
}
