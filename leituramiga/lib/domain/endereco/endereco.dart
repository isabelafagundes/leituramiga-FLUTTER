import 'dart:math';

import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/super/erro_dominio.dart';
import 'package:leituramiga/domain/super/objeto_de_valor.dart';

class Endereco extends ObjetoDeValor {
  final int? _numero;
  final String? _numeroResidencial;
  final String? _complemento;
  final String _rua;
  final String _cep;
  final String _bairro;
  final Municipio _municipio;

  Endereco.criar(
    this._numeroResidencial,
    this._complemento,
    this._rua,
    this._cep,
    this._bairro,
    this._municipio,
  ) : _numero = null;

  Endereco.carregar(
    this._numero,
    this._numeroResidencial,
    this._complemento,
    this._rua,
    this._cep,
    this._bairro,
    this._municipio,
  );

  void validarCEP() {
    if (_cep.length != 8) throw EnderecoInvalido("CEP não possui 8 caracteres!");
  }

  String get _cepFormatado {
    RegExp cepRegex = RegExp(r'^\d{5}-?\d{3}$');
    return cepRegex.stringMatch(_cep) ?? "CEP Inválido";
  }

  Municipio get municipio => _municipio;

  String get bairro => _bairro;

  String get cep => _cep;

  String get rua => _rua;

  String? get complemento => _complemento;

  String? get numeroResidencial => _numeroResidencial;

  int? get numero => _numero;

  Map<String, dynamic> paraMapa([String? emailUsuario]) {
    return {
      "logradouro": rua,
      "complemento": complemento,
      "bairro": bairro,
      "cep": cep,
      "nomeCidade": municipio.nome,
      "codigoCidade": municipio.numero,
      "emailUsuario": emailUsuario,
    };
  }

  factory Endereco.carregarDeMapa(Map<String, dynamic> enderecoAsMap) {
    return Endereco.carregar(
      enderecoAsMap["codigoEndereco"],
      enderecoAsMap["numero"],
      enderecoAsMap["complemento"],
      enderecoAsMap["logradouro"],
      enderecoAsMap["cep"],
      enderecoAsMap["bairro"],
      Municipio.carregar(
        enderecoAsMap["codigoCidade"],
        enderecoAsMap["nomeCidade"],
        enderecoAsMap["estado"],
      ),
    );
  }

  String get enderecoFormatado {
    String numeroCompleto = _numeroResidencial != null ? "$_numeroResidencial" : "";
    String complementoFormatado = _complemento != null ? ", $_complemento" : "";
    return "$_rua, $numeroCompleto$complementoFormatado, $_bairro, ${_municipio.nome} - ${_municipio.estado.descricao}, $_cepFormatado";
  }
}

class EnderecoInvalido extends ErroDominio {
  EnderecoInvalido(String mensagem) : super("O endereço é inválido: $mensagem");
}
