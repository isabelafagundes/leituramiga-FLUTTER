import 'package:intl/intl.dart';
import 'package:leituramiga/domain/super/erro_dominio.dart';

class DataHora {
  DateTime _valor;

  DataHora.criar(this._valor);

  factory DataHora.deString(String data) {
    try {
      DateTime dateTime = DateTime.parse(data);
      return DataHora.criar(dateTime);
    } catch (e) {
      throw DataInvalida();
    }
  }

  void formatar([String formato = "dd/MM/yyyy HH:mm"]) {
    DateFormat dateFormat = DateFormat(formato);
    DateTime dateTime = dateFormat.parse(_valor.toString());
    _valor = dateTime;
  }

  String _dataFormatada([String formato = "dd/MM/yyyy HH:mm"]) {
    DateFormat dateFormat = DateFormat(formato);
    return dateFormat.parse(_valor.toString()).toString();
  }

  DateTime get valor => _valor;

  static DateTime hoje() {
    return DateTime.now();
  }

  static DateTime ontem() {
    return hoje().subtract(Duration(days: 1));
  }

  void subtrair(int dias) {
    _valor = _valor.subtract(Duration(days: dias));
  }

  void adicionar(int dias) {
    _valor = _valor.add(Duration(days: dias));
  }
}

class DataInvalida extends ErroDominio {
  DataInvalida() : super("A data é inválida!");
}
