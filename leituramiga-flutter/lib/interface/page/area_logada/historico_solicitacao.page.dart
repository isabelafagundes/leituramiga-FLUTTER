import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/solicitacao.component.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/card/card_solicitacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

@RoutePage()
class HistoricoPage extends StatefulWidget {
  const HistoricoPage({super.key});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  SolicitacaoComponent solicitacaoComponent = SolicitacaoComponent();

  TemaState get _temaState => TemaState.instancia;
  DataHora? dataSelecionada = DataHora.hoje();

  Tema get tema => _temaState.temaSelecionado!;

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
      await solicitacaoComponent.obterHistoricoInicial(_autenticacaoState.usuario!.email.endereco);
    });
  }

  void atualizar() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: ConteudoMenuLateralWidget(
        tema: tema,
        voltar: ()=>Rota.navegar(context, Rota.HOME),
        child: Column(
          children: [
            TextoWidget(
              texto: "Histórico de Solicitações",
              tema: tema,
              weight: FontWeight.w500,
              tamanho: tema.tamanhoFonteXG + 4,
            ),
            SizedBox(height: tema.espacamento * 4),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.larguraP(context) ? 1 :3,
                  crossAxisSpacing: tema.espacamento * 2,
                  mainAxisSpacing: tema.espacamento * 2,
                  childAspectRatio: 1.5,
                  mainAxisExtent: 200,
                ),
                itemCount: solicitacaoComponent.itensPaginados.length,
                itemBuilder: (context, index) {
                  final solicitacao = solicitacaoComponent.itensPaginados[index];
                  return CardSolicitacaoWidget(
                    tema: tema,
                    solicitacao: solicitacao,
                    aoVisualizar: (int) {},
                    usuarioPerfil: '',
                  );
                },
              ),
            ),
          ],
        ),
      ),
      tema: tema,
    );
  }
}
