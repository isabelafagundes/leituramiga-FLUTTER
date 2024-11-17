import 'package:leituramiga/domain/super/erro_dominio.dart';

enum FormaEntrega {
  CORREIOS(id: 1, descricao: "Correios"),
  PRESENCIAL(id: 2, descricao: "Presencial");

  final int id;
  final String descricao;

  factory FormaEntrega.deNumero(int numero) {
    return FormaEntrega.values.where((e) => e.id == numero).firstOrNull ?? FormaEntrega.CORREIOS;
  }

  factory FormaEntrega.deDescricao(String descricao) {
    return FormaEntrega.values.where((e) => e.descricao == descricao).firstOrNull ?? FormaEntrega.CORREIOS;
  }

  const FormaEntrega({required this.id, required this.descricao});
}

class FormaDeEntregaInvalida extends ErroDominio {
  FormaDeEntregaInvalida(String mensagemException) : super(mensagemException);
}
