enum TipoStatusLivro {
  DISPONIVEL(id: 1, descricao: "Disponivel"),
  EMPRESTADO(id: 2, descricao: "Emprestado"),
  INDISPONIVEL(id: 3, descricao: "Indisponivel"),
  DESATIVADO(id: 4, descricao: "Desativado");

  final int id;
  final String descricao;

  const TipoStatusLivro({required this.id, required this.descricao});

  factory TipoStatusLivro.obterDeNumero(int numero) {
    return TipoStatusLivro.values.where((e) => e.id == numero).firstOrNull ?? TipoStatusLivro.DISPONIVEL;
  }
}
