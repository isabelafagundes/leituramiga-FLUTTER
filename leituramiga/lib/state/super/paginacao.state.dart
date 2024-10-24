mixin PaginacaoState<T> {
  List<T> itensPaginados = [];
  String pesquisa = "";
  int limite = 18;
  int pagina = 0;
  bool pesquisou = false;
  bool possuiProximaPagina = false;

  void reiniciar() {
    itensPaginados = [];
    pagina = 0;
    possuiProximaPagina = false;
    limparPesquisa();
  }

  void paginar(List<T> itens, [int limite = 18, String pesquisa = ""]) {
    print("paginou");

    this.limite = limite;
    this.pesquisa = pesquisa;
    possuiProximaPagina = itens.length == limite;
    itensPaginados.addAll(itens);
    if (possuiProximaPagina) return;
    pagina++;

    print("Fim da paginação ${itensPaginados.length}  ");
  }

  void limparPesquisa() {
    pesquisa = "";
    pesquisou = false;
  }
}
