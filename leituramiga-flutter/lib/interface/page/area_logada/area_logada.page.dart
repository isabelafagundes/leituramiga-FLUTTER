import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/component/autenticacao.component.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/interface/configuration/module/app.module.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';

@RoutePage()
class AreaLogadaPage extends StatefulWidget {
  const AreaLogadaPage({
    super.key,
  });

  @override
  State<AreaLogadaPage> createState() => _AreaLogadaPageState();
}

class _AreaLogadaPageState extends State<AreaLogadaPage> {
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
      await autenticacaoComponent.carregarSessao();
    });
  }

  void atualizar() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
