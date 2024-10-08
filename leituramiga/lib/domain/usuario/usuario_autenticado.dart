class UsuarioAutenticado {
  final String _username;
  final String _email;
  final String _accessToken;
  final String _refreshToken;

  UsuarioAutenticado.carregar(
    this._username,
    this._email,
    this._accessToken,
    this._refreshToken,
  );

  factory UsuarioAutenticado.carregarDeMapa(Map<String, dynamic> mapa) {
    return UsuarioAutenticado.carregar(
      mapa['username'],
      mapa['email'],
      mapa['accessToken'],
      mapa['refreshToken'],
    );
  }

  String get refreshToken => _refreshToken;

  String get accessToken => _accessToken;

  String get email => _email;

  String get username => _username;
}
