import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:leituramiga/state/autenticacao.state.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';

@RoutePage()
class AutenticacaoPage extends StatefulWidget {
  const AutenticacaoPage({
    super.key,
  });

  @override
  State<AutenticacaoPage> createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(AutenticacaoState.instancia.usuario!=null){
        Rota.navegar(context, Rota.AREA_LOGADA);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

}
