abstract mixin class ConfiguracaoApiState {
  static const String _ip = 'localhost';
  static const String _porta = '8080';
  static const String _protocolo = 'http';

  String get host => '$_protocolo://$_ip:$_porta/api';
}
