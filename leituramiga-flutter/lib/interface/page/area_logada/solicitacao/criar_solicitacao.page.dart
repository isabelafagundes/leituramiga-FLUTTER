import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/notificacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/solicitacao_mock.service.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/conteudo_endereco_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_informacoes_adicionais.widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class CriarSolicitacaoPage extends StatefulWidget {
  final Livro livro;
  final TipoSolicitacao tipoSolicitacao;

  const CriarSolicitacaoPage({super.key, required this.livro, required this.tipoSolicitacao});

  @override
  State<CriarSolicitacaoPage> createState() => _CriarSolicitacaoPageState();
}

class _CriarSolicitacaoPageState extends State<CriarSolicitacaoPage> {
  final SolicitacaoComponent _solicitacaoComponent = SolicitacaoComponent();
  final TextEditingController controllerInformacoes = TextEditingController();
  final TextEditingController controllerRua = TextEditingController();
  final TextEditingController controllerBairro = TextEditingController();
  final TextEditingController controllerCep = TextEditingController();
  final TextEditingController controllerNumero = TextEditingController();
  final TextEditingController controllerComplemento = TextEditingController();
  final TextEditingController controllerCidade = TextEditingController();
  final TextEditingController controllerEstado = TextEditingController();
  final TextEditingController controllerDataEntrega = TextEditingController();
  final TextEditingController controllerDataDevolucao = TextEditingController();

  CriarSolicitacao estagioPagina = CriarSolicitacao.INFORMACOES_ADICIONAIS;

  TemaState get _temaState => TemaState.instancia;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  void initState() {
    super.initState();
    _solicitacaoComponent.inicializar(
      SolicitacaoMockRepo(),
      SolicitacaoMockService(),
      NotificacaoMockRepo(),
      atualizar,
    );
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
        alterarFonte: _alterarFonte,
        alterarTema: _alterarTema,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: paginaSelecionada,
          ),
        ),
      ),
    );
  }

  void atualizarPagina(CriarSolicitacao estagio) => setState(() => estagioPagina = estagio);

  Widget get paginaSelecionada {
    return switch (estagioPagina) {
      CriarSolicitacao.INFORMACOES_ADICIONAIS => FormularioInformacoesAdicionaisWidget(
          tema: tema,
          controllerInformacoes: controllerInformacoes,
          aoClicarProximo: () => atualizarPagina(CriarSolicitacao.ENDERECO),
          controllerDataEntrega: controllerDataEntrega,
          controllerDataDevolucao: controllerDataDevolucao,
          tipoSolicitacao: TipoSolicitacao.EMPRESTIMO,
        ),
      CriarSolicitacao.ENDERECO => ConteudoEnderecoSolicitacaoWidget(
          tema: tema,
          aoClicarProximo: () => atualizarPagina(CriarSolicitacao.CONCLUSAO),
          utilizarEnderecoPerfil: () {},
          aoClicarFormaEntrega: (formaEntrega) {},
          aoClicarFrete: (frete) {},
          controllerRua: controllerRua,
          controllerBairro: controllerBairro,
          controllerCep: controllerCep,
          controllerNumero: controllerNumero,
          controllerComplemento: controllerComplemento,
          controllerCidade: controllerCidade,
          controllerEstado: controllerEstado,
        ),
      CriarSolicitacao.CONCLUSAO => Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Flexible(
              child: SvgWidget(
                altura: 350,
                nomeSvg: "solicitacao_fim",
              ),
            ),
            SizedBox(height: tema.espacamento * 2),
            Flexible(
              child: SizedBox(
                width: 400,
                child: TextoWidget(
                  align: TextAlign.center,
                  texto:
                      "Sua solicitação foi enviada! Quando @usuário respondê-la, você será notificado e receberá um e-mail.",
                  tema: tema,
                  maxLines: 5,
                ),
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
            Flexible(
              child: BotaoWidget(
                tema: tema,
                texto: 'Conclusão',
                nomeIcone: "seta/arrow-long-right",
                aoClicar: () => Rota.navegar(context, Rota.HOME),
              ),
            ),
            SizedBox(height: tema.espacamento * 4),
          ],
        ),
      _ => const SizedBox(),
    };
  }

  void _criarSolicitacao() {
    Solicitacao solicitacao = Solicitacao.criar(
      null,
      _autenticacaoState.usuario!.numero!,
      widget.livro.numeroUsuario,
      _solicitacaoComponent.formaEntregaSelecionada!,
      DataHora.deString(controllerDataEntrega.text),
      DataHora.deString(controllerDataDevolucao.text),
      DataHora.deString(controllerDataDevolucao.text),
      DataHora.deString(controllerDataDevolucao.text),
      controllerInformacoes.text,
      Endereco.criar(
        controllerRua.text,
        controllerBairro.text,
        controllerCep.text,
        controllerNumero.text,
        controllerComplemento.text,
        _solicitacaoComponent.municipioSelecionado!,
      ),
      _solicitacaoComponent.instituicaoSelecionada!,
      TipoStatusSolicitacao.PENDENTE,
      null,
      null,
    );

    _solicitacaoComponent.atualizarSolicitacaoMemoria(solicitacao);
  }

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }
}

enum CriarSolicitacao { INFORMACOES_ADICIONAIS, ENDERECO, CONCLUSAO }
