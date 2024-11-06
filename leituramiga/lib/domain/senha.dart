import 'package:leituramiga/domain/super/erro_dominio.dart';

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

    if (_senha.length < 6) throw SenhaInvalida("A senha deve ter no mínimo 6 caracteres.");
    if (!_senha.contains(numeros)) throw SenhaInvalida("A senha deve ter no mínimo 1 número.");
    if (!_senha.contains(letras)) throw SenhaInvalida("A senha deve ter no mínimo 1 letra.");
    if (!_senha.contains(especiais)) throw SenhaInvalida("A senha deve ter no mínimo 1 caractere especial.");
    if (_senha != _confirmacaoSenha) throw SenhaInvalida("As senhas não coincidem.");
    if (_senha.isNotEmpty && _confirmacaoSenha.isEmpty) throw SenhaInvalida("Confirme a senha.");
    if (_senha.isEmpty && _confirmacaoSenha.isNotEmpty) throw SenhaInvalida("Digite a senha.");
  }

  static String obterErro(String senha, String confirmacaoSenha) {
    RegExp numeros = RegExp(r'[0-9]');
    RegExp letras = RegExp(r'[a-zA-Z]');
    RegExp especiais = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (senha.length < 6) return "A senha deve ter no mínimo 6 caracteres.";
    if (!senha.contains(numeros)) return "A senha deve ter no mínimo 1 número.";
    if (!senha.contains(letras)) return "A senha deve ter no mínimo 1 letra.";
    if (!senha.contains(especiais)) return "A senha deve ter no mínimo 1 caractere especial.";
    if (senha != confirmacaoSenha) return "As senhas não coincidem.";
    if (senha.isNotEmpty && confirmacaoSenha.isEmpty) return "Confirme a senha.";
    if (senha.isEmpty && confirmacaoSenha.isNotEmpty) return "Digite a senha.";

    return "";
  }

  void atualizarSenha(String senha) {
    _senha = senha;
  }

  void atualizarConfirmacaoSenha(String confirmacaoSenha) {
    _confirmacaoSenha = confirmacaoSenha;
  }
}

class SenhaInvalida extends ErroDominio {
  SenhaInvalida(String mensagem) : super("A senha é inválida: $mensagem");
}
