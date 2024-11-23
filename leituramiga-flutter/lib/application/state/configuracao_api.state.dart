import 'dart:io';

abstract mixin class ConfiguracaoApiState {
  static String _ip = '57b7-2804-1b3-ac03-aa-94e3-9141-e0a0-39b8.ngrok-free.app';
  static const String _porta = '';
  static const String _protocolo = 'https';

  String get host => _porta.isEmpty ? "$_protocolo://$_ip/api" : '$_protocolo://$_ip:$_porta/api';
}

