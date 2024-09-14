import 'package:leituramiga/domain/super/erro_dominio.dart';
import 'package:leituramiga/domain/super/objeto_de_valor.dart';

class Email extends ObjetoDeValor {
  final String _endereco;

  Email.criar(this._endereco) {
    _validarEmail();
  }

  void _validarEmail() {
    if (!_endereco.contains('@')) throw EmailInvalido("Não possui @!");
    if (!_endereco.contains('.com')) throw EmailInvalido("Não possui .com!");
  }

  String get endereco => _endereco;
}

class EmailInvalido extends ErroDominio {
  EmailInvalido(String mensagem) : super("O email é inválido: $mensagem");
}
