import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';

@RoutePage()
class AutenticacaoPage extends StatefulWidget {
  const AutenticacaoPage({
    super.key,
  });

  @override
  State<AutenticacaoPage> createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {
  AutenticacaoState get autenticacaoState => AutenticacaoState.instancia;
  AutenticacaoComponent autenticacaoComponent = AutenticacaoComponent();

  @override
  void initState() {
    super.initState();
    autenticacaoComponent.inicializar(
      AppModule.autenticacaoService,
      AppModule.sessaoService,
      AppModule.usuarioRepo,
      atualizar,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await autenticacaoComponent.validarSePossuiToken();
      if (autenticacaoState.usuario != null) {
        Rota.navegar(context, Rota.AREA_LOGADA);
      }
    });
  }

  void atualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (autenticacaoState.usuario != null) Rota.navegar(context, Rota.AREA_LOGADA);

    return Scaffold(
      backgroundColor: Color(TemaState.instancia.temaSelecionado!.base100),
      body: autenticacaoComponent.carregando || autenticacaoState.usuario != null
          ? Container(
              width: Responsive.largura(context),
              height: Responsive.altura(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            )
          : const AutoRouter(),
    );
  }
}
