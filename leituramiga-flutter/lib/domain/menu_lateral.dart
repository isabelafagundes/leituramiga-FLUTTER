import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';

enum MenuLateral {
  PAGINA_PRINCIPAL(
    id: 1,
    descricao: "Início",
    iconeAtivado: "menu/home-fill",
    iconeDesativado: "menu/home",
    usuarioLogado: false,
    rota: Rota.HOME,
  ),
  SOLICITACOES(
    id: 2,
    descricao: "Solicitações",
    iconeAtivado: "compartilhar_fill",
    iconeDesativado: "compartilhar",
    rota: Rota.DETALHES_SOLICITACAO,
  ),
  CALENDARIO(
    id: 3,
    descricao: "Calendário",
    iconeAtivado: "calendar-fill",
    iconeDesativado: "calendar",
    rota: Rota.CALENDARIO,
  ),
  PERFIL(
    id: 4,
    descricao: "Perfil",
    iconeAtivado: "usuario/user",
    iconeDesativado: "usuario/user-outline",
    rota: Rota.PERFIL,
  ),
  HISTORICO(
    id: 5,
    descricao: "Histórico",
    iconeAtivado: "menu/plus-circle-fill",
    iconeDesativado: "menu/plus-circle",
    rota: Rota.HISTORICO,
  );

  final int id;
  final String descricao;
  final String iconeAtivado;
  final String iconeDesativado;
  final Rota rota;
  final bool usuarioLogado;

  const MenuLateral({
    required this.id,
    required this.descricao,
    required this.iconeAtivado,
    required this.iconeDesativado,
    required this.rota,
    this.usuarioLogado = true,
  });
}
