import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:leituramiga/repo/usuario.repo.dart';
import 'package:projeto_leituramiga/application/state/configuracao_api.state.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/http.client.dart';

class UsuarioApiRepo extends UsuarioRepo with ConfiguracaoApiState {
  static UsuarioApiRepo? _instancia;

  UsuarioApiRepo._();

  static UsuarioApiRepo get instancia {
    _instancia ??= UsuarioApiRepo._();
    return _instancia!;
  }

  final HttpClient _client = HttpClient.instancia;

  @override
  Future<void> atualizarUsuario(Usuario usuario) async {
    print(usuario.paraMapa());
    await _client.post("$host/criar-usuario", data: usuario.paraMapa()).catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<void> desativarUsuario() async {
    await _client.post("$host/desativar").catchError((erro) {
      throw erro;
    });
  }

  @override
  Future<Usuario> obterUsuario(String emailUsuario) async {
    return await _client.post(
      "$host/usuario",
      data: {"email": emailUsuario},
    ).catchError((erro) {
      throw erro;
    }).then((response) => Usuario.carregarDeMapa(response.data));
  }

  @override
  Future<List<ResumoUsuario>> obterUsuarios([
    int numeroPagina = 0,
    int limite = 18,
    int? numeroMunicipio,
    int? numeroInstituicao,
    String? pesquisa,
  ]) async {
    Map<String, dynamic> mapaFiltros = {
      "numeroPagina": numeroPagina,
      "tamanhoPagina": limite,
      "numeroCidade": numeroMunicipio,
      "numeroInstituicao": numeroInstituicao,
      "pesquisa": pesquisa,
    };

    return await _client.get("$host/usuarios").catchError((erro) {
      throw erro;
    }).then(
      (response) => (response.data as List).map((e) => ResumoUsuario.carregarDeMapa(e)).toList(),
    );
  }

  @override
  Future<Usuario> obterUsuarioPerfil() async {
    return await _client.get("$host/perfil").catchError((erro) {
      throw erro;
    }).then((response) => Usuario.carregarDeMapa(response.data));
  }
}
