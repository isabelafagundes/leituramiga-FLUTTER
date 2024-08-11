import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/conteudo_endereco_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_endereco.widget.dart';
import 'package:projeto_leituramiga/interface/widget/solicitacao/formulario_informacoes_adicionais.widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class CriarSolicitacaoPage extends StatefulWidget {
  const CriarSolicitacaoPage({super.key});

  @override
  State<CriarSolicitacaoPage> createState() => _CriarSolicitacaoPageState();
}

class _CriarSolicitacaoPageState extends State<CriarSolicitacaoPage> {
  CriarSolicitacao estagioPagina = CriarSolicitacao.INFORMACOES_ADICIONAIS;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

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
          controllerInformacoes: TextEditingController(),
          aoClicarProximo: () => atualizarPagina(CriarSolicitacao.ENDERECO),
        ),
      CriarSolicitacao.ENDERECO => ConteudoEnderecoSolicitacaoWidget(
          tema: tema,
          aoClicarProximo: () => atualizarPagina(CriarSolicitacao.CONCLUSAO),
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

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }
}

enum CriarSolicitacao { INFORMACOES_ADICIONAIS, ENDERECO, CONCLUSAO }
