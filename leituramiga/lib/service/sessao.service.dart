abstract class SessaoService {
  Future<void> salvarToken(Map<String, dynamic> tokens);

  Future<Map<String, dynamic>> obterTokens();

  Future<void> removerToken();

  Future<void> alterarTema(int idTema);

  Future<void> alterarFonte(bool modoFonteGrande);

  Future<int> obterTema();

  Future<bool> obterModoFonteGrande();

  Future<void> limpar();
}
