import 'package:auto_route/auto_route.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/area_logada.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/autenticacao.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/criar_livro.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/editar_perfil.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/livro.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/perfil.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacao/criar_solicitacao.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/solicitacoes.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/usuario.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/cadastro_usuario.page.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/home.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/esqueceu_senha.page.dart';
import 'package:projeto_leituramiga/interface/page/autenticacao/login.page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => Rota.rotasAuto;
}