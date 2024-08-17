import 'package:leituramiga/dominio/endereco.dart';
import 'package:leituramiga/dominio/forma_entrega.dart';
import 'package:leituramiga/dominio/instituicao_de_ensino.dart';
import 'package:leituramiga/dominio/super/entidade.dart';

class Solicitacao extends Entidade {
  final int _numero;
  final int _numeroUsuarioProprietario;
  final int _numeroUsuarioCriador;
  final List<int> _numerosLivros;
  final FormaEntrega _formaEntrega;
  final DateTime _dataCriacao;
  final DateTime _dataEntrga;
  final DateTime? _dataDevolucao;
  final DateTime _dataAtualizacao;
  final String _informacoesAdicionais;
  final Endereco? _endereco;
  final InstituicaoDeEnsino? _instituicaoDeEnsino;

  Solicitacao.criar(
    this._numero,
    this._numeroUsuarioProprietario,
    this._numeroUsuarioCriador,
    this._numerosLivros,
    this._formaEntrega,
    this._dataCriacao,
    this._dataEntrga,
    this._dataDevolucao,
    this._dataAtualizacao,
    this._informacoesAdicionais,
    this._endereco,
    this._instituicaoDeEnsino,
  );


  int get numero => _numero;

  @override
  String get id => throw UnimplementedError();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  int get numeroUsuarioProprietario => _numeroUsuarioProprietario;

  int get numeroUsuarioCriador => _numeroUsuarioCriador;

  List<int> get numerosLivros => _numerosLivros;

  FormaEntrega get formaEntrega => _formaEntrega;

  DateTime get dataCriacao => _dataCriacao;

  DateTime get dataEntrga => _dataEntrga;

  DateTime? get dataDevolucao => _dataDevolucao;

  DateTime get dataAtualizacao => _dataAtualizacao;

  String get informacoesAdicionais => _informacoesAdicionais;

  Endereco? get endereco => _endereco;

  InstituicaoDeEnsino? get instituicaoDeEnsino => _instituicaoDeEnsino;
}
