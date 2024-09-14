import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';

enum MenuLateral {
  PAGINA_PRINCIPAL(
    id: 1,
    descricao: "Início",
    iconeAtivado: "menu/home-fill",
    iconeDesativado: "menu/home",
    rota: Rota.HOME,
  ),
  SOLICITACOES(
    id: 2,
    descricao: "Solicitações",
    iconeAtivado: "compartilhar_fill",
    iconeDesativado: "compartilhar",
    rota: Rota.SUPORTE,
  ),
  SUPORTE(
    id: 3,
    descricao: "Suporte",
    iconeAtivado: "menu/plus-circle-fill",
    iconeDesativado: "menu/plus-circle",
    rota: Rota.SUPORTE,
  );


  final int id;
  final String descricao;
  final String iconeAtivado;
  final String iconeDesativado;
  final Rota rota;

  const MenuLateral({
    required this.id,
    required this.descricao,
    required this.iconeAtivado,
    required this.iconeDesativado,
    required this.rota,
  });
}
