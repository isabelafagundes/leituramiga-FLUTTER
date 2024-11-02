import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/area_logada.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/aceite_solicitacao.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/editar_solicitacao.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/autenticacao.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/calendario.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/livro/criar_livro.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/usuario/editar_perfil.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/historico_solicitacao.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/livro/livro.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/usuario/perfil.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/criar_solicitacao.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/detalhes_solicitacao.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/usuario/usuario.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/cadastro_usuario.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/home.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/esqueceu_senha.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/login.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/livro/editar_livro.page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => Rota.rotasAuto;
}