class Senha {
  String _senha = "";
  String _confirmacaoSenha = "";

  Senha._(this._senha, this._confirmacaoSenha);

  Senha.criar();

  String get senha => _senha;

  void validarSenha() {
    RegExp numeros = RegExp(r'[0-9]');
    RegExp letras = RegExp(r'[a-zA-Z]');
    RegExp especiais = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (_senha.length < 6) throw Exception("A senha deve ter no mínimo 6 caracteres.");
    if (!_senha.contains(numeros)) throw Exception("A senha deve ter no mínimo 1 número.");
    if (!_senha.contains(letras)) throw Exception("A senha deve ter no mínimo 1 letra.");
    if (!_senha.contains(especiais)) throw Exception("A senha deve ter no mínimo 1 caractere especial.");
    if (_senha != _confirmacaoSenha) throw Exception("As senhas não coincidem.");
    if (_senha.isNotEmpty && _confirmacaoSenha.isEmpty) throw Exception("Confirme a senha.");
    if (_senha.isEmpty && _confirmacaoSenha.isNotEmpty) throw Exception("Digite a senha.");
  }

  String obterErro() {
    RegExp numeros = RegExp(r'[0-9]');
    RegExp letras = RegExp(r'[a-zA-Z]');
    RegExp especiais = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (_senha.length < 6) return "A senha deve ter no mínimo 6 caracteres.";
    if (!_senha.contains(numeros)) return "A senha deve ter no mínimo 1 número.";
    if (!_senha.contains(letras)) return "A senha deve ter no mínimo 1 letra.";
    if (!_senha.contains(especiais)) return "A senha deve ter no mínimo 1 caractere especial.";
    if (_senha != _confirmacaoSenha) return "As senhas não coincidem.";
    if (_senha.isNotEmpty && _confirmacaoSenha.isEmpty) return "Confirme a senha.";
    if (_senha.isEmpty && _confirmacaoSenha.isNotEmpty) return "Digite a senha.";

    return "";
  }

  void atualizarSenha(String senha) {
    _senha = senha;
  }

  void atualizarConfirmacaoSenha(String confirmacaoSenha) {
    _confirmacaoSenha = confirmacaoSenha;
  }
}