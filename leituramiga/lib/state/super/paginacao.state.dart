mixin PaginacaoState<T> {
  Set<T> itensPaginadosSet = {};
  String pesquisa = "";
  int limite = 18;
  int pagina = 0;
  bool pesquisou = false;
  bool possuiProximaPagina = false;

  void reiniciar() {
    itensPaginadosSet = {};
    pagina = 0;
    possuiProximaPagina = false;
    limparPesquisa();
  }

  List<T> get itensPaginados => itensPaginadosSet.toList();

  void paginar(List<T> itens, [int limite = 18, String pesquisa = ""]) {
    this.limite = limite;
    this.pesquisa = pesquisa;
    possuiProximaPagina = itens.length < limite;
    itensPaginadosSet.addAll(itens);
    pagina++;
  }

  void limparPesquisa() {
    pesquisa = "";
    pesquisou = false;
  }
}
