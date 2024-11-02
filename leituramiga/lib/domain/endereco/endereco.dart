import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
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
  final bool _principal;

  Endereco.criar(
    this._numeroResidencial,
    this._complemento,
    this._rua,
    this._cep,
    this._bairro,
    this._municipio,
    this._principal,
  ) : _numero = null;

  Endereco.carregar(
    this._numero,
    this._numeroResidencial,
    this._complemento,
    this._rua,
    this._cep,
    this._bairro,
    this._municipio,
    this._principal,
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
      "codigoEndereco": _numero,
      "logradouro": rua,
      "complemento": complemento,
      "bairro": bairro,
      "cep": cep.replaceAll("-", "").trim(),
      "nomeCidade": municipio.nome,
      "estado": municipio.estado.name,
      "codigoCidade": municipio.numero,
      "emailUsuario": emailUsuario,
      "numero": numeroResidencial,
      "enderecoPrincipal": _principal,
    };
  }

  factory Endereco.carregarDeMapa(Map<String, dynamic> enderecoAsMap) {
    print(enderecoAsMap);
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
        UF.deSigla(
          enderecoAsMap["estado"],
        ),
      ),
      enderecoAsMap["enderecoPrincipal"],
    );
  }

  bool get principal => _principal;

  String get enderecoFormatado {
    String numeroCompleto = _numeroResidencial != null && _numeroResidencial!.isNotEmpty ? "$_numeroResidencial" : "";
    String complementoFormatado = _complemento != null && _complemento!.isNotEmpty ? ", $_complemento" : "";
    return "$_rua, $numeroCompleto$complementoFormatado, $_bairro, ${_municipio.nome} - ${_municipio.estado.descricao}, $_cepFormatado";
  }

  String get enderecoFormatadoCensurado {
    return "$_bairro, ${_municipio.nome} - ${_municipio.estado.descricao}";
  }
}

class EnderecoInvalido extends ErroDominio {
  EnderecoInvalido(String mensagem) : super("O endereço é inválido: $mensagem");
}

class EnderecoNaoEncontrado extends ErroDominio {
  EnderecoNaoEncontrado() : super("Endereço não foi encontrado!");
}
