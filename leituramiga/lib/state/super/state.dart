mixin class State {
  late Function() atualizar;
  bool carregando = false;
  bool erro = false;
  String mensagemErro = '';

  void alterarCarregamento(bool carregando) {
    carregando = carregando;
    atualizar();
  }

  void adicionarErro(String mensagem) {
    erro = true;
    mensagemErro = mensagem;
  }

  Future<void> executar({required Function() rotina, required String mensagemErro}) async {
    try {
      alterarCarregamento(true);
      await rotina();
    } catch (erro) {
      adicionarErro(mensagemErro);
      rethrow;
    } finally {
      alterarCarregamento(false);
    }
  }
}
