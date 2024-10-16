import 'package:intl/intl.dart';
import 'package:leituramiga/domain/super/erro_dominio.dart';

class DataHora {
  DateTime _valor;

  DataHora.criar(this._valor);

  factory DataHora.deString(String data, [String formato = "yyyy-MM-dd HH:mm:ss"]) {
    try {
      DateFormat dateFormat = DateFormat(formato);
      DateTime dateTime = dateFormat.parse(data);
      return DataHora.criar(dateTime);
    } catch (e) {
      throw DataInvalida();
    }
  }

  String formatar([String formato = "dd/MM/yyyy HH:mm"]) {
    DateFormat dateFormat = DateFormat(formato);
    return dateFormat.format(_valor);
  }

  String _dataFormatada([String formato = "dd/MM/yyyy HH:mm"]) {
    DateFormat dateFormat = DateFormat(formato);
    return dateFormat.parse(_valor.toString()).toString();
  }

  DateTime get valor => _valor;

  static DataHora hoje() {
    return DataHora.criar(DateTime.now());
  }

  static DataHora ontem() {
    return DataHora.criar(DateTime.now().subtract(Duration(days: 1)));
  }

  bool ehAntesDe(DataHora data) {
    return _valor.isBefore(data.valor);
  }

  bool ehDepoisDe(DataHora data) {
    return _valor.isAfter(data.valor);
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
