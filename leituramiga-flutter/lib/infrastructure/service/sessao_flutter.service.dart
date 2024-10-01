import 'package:leituramiga/service/sessao.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessaoFlutterService extends SessaoService {

  static SessaoFlutterService? _instancia;

  SessaoFlutterService._();

  static SessaoFlutterService get instancia {
    _instancia ??= SessaoFlutterService._();
    return _instancia!;
  }

  @override
  Future<void> alterarFonte(bool modoFonteGrande) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoFonteGrande', modoFonteGrande);
  }

  @override
  Future<void> alterarTema(int idTema) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idTema', idTema);
  }

  @override
  Future<Map<String, dynamic>> obterTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString('accessToken'),
      'refreshToken': prefs.getString('refreshToken'),
    };
  }

  @override
  Future<void> removerToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }

  @override
  Future<void> salvarToken(Map<String, dynamic> tokens) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', tokens['accessToken']);
    await prefs.setString('refreshToken', tokens['refreshToken']);
  }

  @override
  Future<bool> obterModoFonteGrande() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('modoFonteGrande') ?? false;
  }

  @override
  Future<int> obterTema() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idTema') ?? 1;
  }
}
