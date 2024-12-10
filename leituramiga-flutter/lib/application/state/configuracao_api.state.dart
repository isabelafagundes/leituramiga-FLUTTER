abstract mixin class ConfiguracaoApiState {
  static String _ip = '192.168.209.56';
  static const String _porta = '8080';
  static const String _protocolo = 'http';

  String get host => _porta.isEmpty ? "$_protocolo://$_ip/api" : '$_protocolo://$_ip:$_porta/api';
}
