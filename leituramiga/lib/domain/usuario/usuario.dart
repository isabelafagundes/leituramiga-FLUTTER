import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/senha.dart';
import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/super/erro_dominio.dart';
import 'package:leituramiga/domain/usuario/email.dart';
import 'package:leituramiga/domain/usuario/telefone.dart';
import 'package:leituramiga/domain/usuario/tipo_usuario.dart';

class Usuario extends Entidade {
  final String _nome;
  final String _nomeUsuario;
  final Email _email;
  final Telefone? _telefone;
  final int _numeroDeLivros;
  final String? _descricao;
  final String? _nomeMunicipio;
  final InstituicaoDeEnsino? _instituicaoDeEnsino;
  final int? _numeroEndereco;
  final String imagem;
  final Endereco? endereco;
  final Senha? senha;
  final TipoUsuario _tipoUsuario;

  Usuario.criar(
    this._nome,
    this._nomeUsuario,
    this._email,
    this._telefone,
    this._numeroDeLivros,
    this._descricao,
    this._instituicaoDeEnsino,
    this._numeroEndereco,
    this._nomeMunicipio,
    this.imagem,
    this.endereco,
    this.senha, [
    this._tipoUsuario = TipoUsuario.USUARIO,
  ]) {
    _validarNomeUsuario();
  }

  Usuario.carregar(
    this._nome,
    this._nomeUsuario,
    this._email,
    this._telefone,
    this._numeroDeLivros,
    this._descricao,
    this._instituicaoDeEnsino,
    this._numeroEndereco,
    this._nomeMunicipio,
    this.imagem,
    this.endereco, [
    this.senha,
    this._tipoUsuario = TipoUsuario.USUARIO,
  ]) {
    _validarNomeUsuario();
  }

  @override
  String get id => _email.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      "nome": nome,
      "username": nomeUsuario,
      "email": email.endereco,
      "celular": telefone?.telefone,
      "descricao": descricao,
      "imagem": imagem,
      "codigoInstituicao": instituicaoDeEnsino?.numero,
      "endereco": endereco?.paraMapa(email.endereco),
      "senha": senha?.senha,
      "tipoUsuario": _tipoUsuario.id,
      "quantidadeLivros": _numeroDeLivros,
    };
  }

  String get nome => _nome;

  String get nomeUsuario => _nomeUsuario;

  Email get email => _email;

  Telefone? get telefone => _telefone;

  int get numeroDeLivros => _numeroDeLivros;

  String? get descricao => _descricao;

  InstituicaoDeEnsino? get instituicaoDeEnsino => _instituicaoDeEnsino;

  int? get numeroEndereco => _numeroEndereco;

  String? get nomeMunicipio => _nomeMunicipio;

  String get nomeInstituicao => _instituicaoDeEnsino?.nome ?? "";

  void _validarNomeUsuario() {
    if (_nomeUsuario.isEmpty) throw UsuarioInvalido("Nome de usuário não pode ser vazio!");
    if (_nomeUsuario.contains(" ")) throw UsuarioInvalido("Nome de usuário não pode conter espaços!");
    if (_nomeUsuario.length >= 40) throw UsuarioInvalido("Nome de usuário deve ter no máximo 40 caracteres!");
  }

  factory Usuario.carregarDeMapa(Map<String, dynamic> usuarioAsMap) {
    return Usuario.carregar(
        usuarioAsMap["nome"],
        usuarioAsMap["username"],
        Email.criar(usuarioAsMap["email"]),
        usuarioAsMap["celular"] == null
            ? null
            : Telefone.criar(
                usuarioAsMap["celular"].substring(2, 11),
                usuarioAsMap["celular"].substring(0, 2),
              ),
        usuarioAsMap["quantidadeLivros"],
        usuarioAsMap["descricao"],
        usuarioAsMap["codigoInstituicao"] == null || usuarioAsMap["nomeInstituicao"] == null
            ? null
            : InstituicaoDeEnsino.carregar(
                usuarioAsMap["codigoInstituicao"],
                "",
                usuarioAsMap["nomeInstituicao"],
              ),
        usuarioAsMap["codigoEndereco"],
        usuarioAsMap["nomeCidade"],
        usuarioAsMap["imagem"],
        usuarioAsMap["endereco"] == null ? null : Endereco.carregarDeMapa(usuarioAsMap["endereco"]));
  }
}

class UsuarioInvalido extends ErroDominio {
  UsuarioInvalido(String mensagem) : super("O usuário é inválido: $mensagem");
}

class CredenciaisIncorretas extends ErroDominio {
  CredenciaisIncorretas() : super("As credenciais são inválidas");
}

class UsuarioNaoEncontrado extends ErroDominio {
  UsuarioNaoEncontrado() : super("O usuário não encontrado. Crie uma conta!");
}

class UsuarioNaoAtivo extends ErroDominio {
  UsuarioNaoAtivo() : super("O usuário não ativo. Confirme seu código!");
}

class CredenciaisExistentes extends ErroDominio {
  CredenciaisExistentes() : super("O email ou o usuário já existe!");
}

class UsuarioJaExiste extends ErroDominio {
  UsuarioJaExiste() : super("O usuário já existe! Altere o email ou o seu nome de usuário");
}

class TokenExpirado extends ErroDominio {
  TokenExpirado() : super("Não é possível utilizar o código pois ele expirou! Tente novamente!");
}

class CodigoInvalido extends ErroDominio {
  CodigoInvalido() : super("O código é inválido!");
}
