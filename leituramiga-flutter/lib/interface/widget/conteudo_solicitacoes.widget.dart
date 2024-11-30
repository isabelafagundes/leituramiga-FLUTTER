import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao_redondo.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/dica.widget.dart';
import 'package:projeto_leituramiga/interface/widget/empty_state.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoSolicitacoesWidget extends StatefulWidget {
  final Tema tema;
  final Function() aoVisualizarSolicitacao;

  const ConteudoSolicitacoesWidget({
    super.key,
    required this.tema,
    required this.aoVisualizarSolicitacao,
  });

  @override
  State<ConteudoSolicitacoesWidget> createState() => _ConteudoSolicitacoesWidgetState();
}

class _ConteudoSolicitacoesWidgetState extends State<ConteudoSolicitacoesWidget> {
  SolicitacaoComponent solicitacaoComponent = SolicitacaoComponent();
  bool _carregando = false;

  AutenticacaoState get _autenticacaoState => AutenticacaoState.instancia;

  @override
  void initState() {
    super.initState();
    solicitacaoComponent.inicializar(
      AppModule.solicitacaoRepo,
      AppModule.solicitacaoService,
      AppModule.notificacaoRepo,
      atualizar,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => _carregando = true);
      await solicitacaoComponent.obterSolicitacoesIniciais(_autenticacaoState.usuario!.email.endereco);
      setState(() => _carregando = false);
    });
  }

  void atualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (solicitacaoComponent.carregando || _carregando) {
      return SizedBox(
        height: 800,
        width: Responsive.largura(context) <= 800 ? Responsive.largura(context) : 800,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: Responsive.largura(context) <= 800 ? Responsive.largura(context) : 800,
      height: 800,
      padding: EdgeInsets.all(widget.tema.espacamento * 2),
      child: Column(
        children: [
          Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Responsive.larguraM(context)
                        ? Row(
                            children: [
                              BotaoRedondoWidget(
                                tema: widget.tema,
                                nomeSvg: 'seta/chevron-left',
                                aoClicar: () => Navigator.pop(context),
                              ),
                              const Spacer(),
                              TextoWidget(
                                texto: "Solicitações",
                                tamanho: widget.tema.tamanhoFonteXG,
                                weight: FontWeight.w500,
                                tema: widget.tema,
                              ),
                              const Spacer(),
                              Opacity(
                                opacity: 0,
                                child: IgnorePointer(
                                  child: BotaoRedondoWidget(
                                    tema: widget.tema,
                                    nomeSvg: 'filtro',
                                    icone: Icon(
                                      Icons.edit,
                                      color: Color(widget.tema.baseContent),
                                    ),
                                    aoClicar: () {},
                                  ),
                                ),
                              ),
                            ],
                          )
                        : TextoWidget(
                            texto: "Solicitações",
                            tamanho: widget.tema.tamanhoFonteXG + 4,
                            weight: FontWeight.w500,
                            tema: widget.tema,
                          ),
                    SizedBox(height: widget.tema.espacamento * 2),
                  ],
                ),
              ),
            ],
          ),
          DicaWidget(
            tema: widget.tema,
            largura: 400,
            texto: "Aqui você pode visualizar todas as solicitações que estão em andamento.",
          ),
          SizedBox(height: widget.tema.espacamento * 2),
          Expanded(
            child: SizedBox(
              width: 800,
              child: solicitacaoComponent.itensPaginados.isEmpty
                  ? EmptyStateWidget(tema: widget.tema)
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: solicitacaoComponent.itensPaginados.length,
                      itemBuilder: (context, index) {
                        ResumoSolicitacao? resumoSolicitacao = solicitacaoComponent.itensPaginados[index];
                        if (resumoSolicitacao != null) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: widget.tema.espacamento * 2),
                            child: CardSolicitacaoWidget(
                              tema: widget.tema,
                              solicitacao: resumoSolicitacao,
                              aoVisualizar: (numero) async {
                                Rota.navegarComArgumentos(
                                  context,
                                  DetalhesSolicitacaoRoute(
                                    numeroSolicitacao: numero,
                                  ),
                                );
                                Navigator.pop(context, true);
                              },
                              usuarioPerfil: _autenticacaoState.usuario!.nome,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
