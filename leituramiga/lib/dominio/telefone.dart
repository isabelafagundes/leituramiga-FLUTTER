import 'package:leituramiga/dominio/super/erro_dominio.dart';
import 'package:leituramiga/dominio/super/objeto_de_valor.dart';

class Telefone extends ObjetoDeValor {
  final String _numero;
  final String _prefixo;

  Telefone.criar(this._numero, this._prefixo) {
    if (_numero.length != 9 && _numero.length != 8) throw TelefoneInvalido("O número de caracteres incorreto!");
    if (_prefixo.length != 2) throw TelefoneInvalido("O número de caracteres incorreto!");
  }

  String get telefoneFormatado {
    RegExp regex = RegExp(r'^\(?\d{2}\)?[\s-]?\d{4,5}[\s-]?\d{4}$');
    String? numeroFormatado = regex.stringMatch("$_prefixo$_numero");
    if (numeroFormatado == null) throw TelefoneInvalido("O formato é inválido");
    return numeroFormatado;
  }
}

class TelefoneInvalido extends ErroDominio {
  TelefoneInvalido(String mensagem) : super("O telefone é inválido: $mensagem");
}
