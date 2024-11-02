enum TipoSolicitacao {
  EMPRESTIMO(id: 1, descricao: "Empréstimo"),
  TROCA(id: 2, descricao: "Troca"),
  DOACAO(id: 3, descricao: "Doação");

  final int id;
  final String descricao;

  factory TipoSolicitacao.deNumero(int numero) {
    return TipoSolicitacao.values.where((e) => e.id == numero).firstOrNull ?? TipoSolicitacao.EMPRESTIMO;
  }

  const TipoSolicitacao({required this.id, required this.descricao});

  bool get possuiSegundoEndereco => this == TipoSolicitacao.EMPRESTIMO || this == TipoSolicitacao.TROCA;
}
