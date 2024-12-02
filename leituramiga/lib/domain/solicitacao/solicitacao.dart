import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:leituramiga/domain/super/entidade.dart';
import 'package:leituramiga/domain/super/erro_dominio.dart';

class Solicitacao extends Entidade {
  final int? _numero;
  final String _emailUsuarioReceptor;
  final String _emailUsuarioSolicitante;
  final LivrosSolicitacao _livrosUsuarioSolicitante;
  LivrosSolicitacao? _livrosUsuarioReceptor;
  final FormaEntrega _formaEntrega;
  final DataHora? _dataCriacao;
  final DataHora? _dataEntrega;
  final DataHora? _dataDevolucao;
  final DataHora? _dataAtualizacao;
  final String _informacoesAdicionais;
  Endereco? _enderecoSolicitante;
  Endereco? _enderecoReceptor;
  final bool _enderecoUsuarioCriador;
  final TipoSolicitacao _tipoSolicitacao;
  final TipoStatusSolicitacao _status;
  final DataHora? _dataAceite;
  final String? _motivoRecusa;
  final String? _codigoRastreamento;

  Solicitacao.criar(
    this._numero,
    this._emailUsuarioReceptor,
    this._emailUsuarioSolicitante,
    this._formaEntrega,
    this._dataCriacao,
    this._dataEntrega,
    this._dataDevolucao,
    this._dataAtualizacao,
    this._informacoesAdicionais,
    this._enderecoSolicitante,
    this._status,
    this._dataAceite,
    this._motivoRecusa,
    this._tipoSolicitacao,
    this._codigoRastreamento,
    this._livrosUsuarioSolicitante,
    this._livrosUsuarioReceptor, [
    this._enderecoReceptor = null,
    this._enderecoUsuarioCriador = false,
  ]) {
    validarDataEntrega(_dataEntrega);
    validarDataDevolucao(_dataDevolucao);
    validarDataEntregaEDevolucao(_dataEntrega, _dataDevolucao);
  }

  Solicitacao.carregar(
    this._numero,
    this._emailUsuarioReceptor,
    this._emailUsuarioSolicitante,
    this._livrosUsuarioSolicitante,
    this._livrosUsuarioReceptor,
    this._formaEntrega,
    this._dataCriacao,
    this._dataEntrega,
    this._dataDevolucao,
    this._dataAtualizacao,
    this._informacoesAdicionais,
    this._enderecoSolicitante,
    this._enderecoUsuarioCriador,
    this._tipoSolicitacao,
    this._status,
    this._dataAceite,
    this._motivoRecusa,
    this._codigoRastreamento,
    this._enderecoReceptor,
  );

  int? get numero => _numero;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      "codigoSolicitacao": _numero,
      "emailUsuarioReceptor": _emailUsuarioReceptor,
      "emailUsuarioSolicitante": _emailUsuarioSolicitante,
      "livrosUsuarioSolicitante": _livrosUsuarioSolicitante.paraMapa(),
      "livrosTroca": _livrosUsuarioReceptor?.paraMapa(),
      "codigoFormaEntrega": _formaEntrega.id,
      "dataCriacao": _dataCriacao?.formatar("yyyy-MM-dd"),
      "dataEntrega": _dataEntrega?.formatar("yyyy-MM-dd"),
      "horaEntrega": _dataEntrega?.formatar("HH:mm:ss"),
      "horaCriacao": _dataCriacao?.formatar("HH:mm:ss"),
      "horaAtualizacao": _dataAtualizacao?.formatar("HH:mm:ss"),
      "horaAceite": _dataAceite?.formatar("HH:mm:ss"),
      "horaDevolucao": _dataDevolucao?.formatar("HH:mm:ss"),
      "dataDevolucao": _dataDevolucao?.formatar("yyyy-MM-dd"),
      "dataAceite": _dataAceite?.formatar("yyyy-MM-dd"),
      "dataAtualizacao": _dataAtualizacao?.toString(),
      "informacoesAdicionais": _informacoesAdicionais,
      "enderecoSolicitante": _enderecoSolicitante?.paraMapa(_emailUsuarioSolicitante),
      "enderecoReceptor": _enderecoReceptor?.paraMapa(_emailUsuarioReceptor),
      "enderecoUsuarioCriador": _enderecoUsuarioCriador,
      "codigoTipoSolicitacao": _tipoSolicitacao.id,
      "codigoStatusSolicitacao": _status.id,
      "motivoRecusa": _motivoRecusa,
      "codigoRastreioCorreio": _codigoRastreamento,
    };
  }

  bool get validarPodeFinalizar {
    if (_dataDevolucao != null && _dataDevolucao!.ehDepoisDe(DataHora.hoje())) {
      return false;
    } else if (_dataEntrega != null && _dataEntrega!.ehDepoisDe(DataHora.hoje())) {
      return false;
    }
    return _dataEntrega == null || _dataDevolucao == null || (_dataEntrega != null || _dataDevolucao != null);
  }

  void adicionarEndereco(
    String? numeroResidencial,
    String? complemento,
    String rua,
    String cep,
    String bairro,
    Municipio municipio,
  ) {
    Endereco endereco = Endereco.criar(
      numeroResidencial,
      complemento,
      rua,
      cep,
      bairro,
      municipio,
      false,
    );
    _enderecoSolicitante = endereco;
  }

  void adicionar(Livro livro, String emailUsuario) {
    if (emailUsuario == _emailUsuarioSolicitante) {
      _livrosUsuarioSolicitante.adicionar(livro);
    } else {
      _livrosUsuarioReceptor ??= LivrosSolicitacao.carregar(_numero ?? 0, _emailUsuarioReceptor, []);
      _livrosUsuarioReceptor!.adicionar(livro);
    }
  }

  factory Solicitacao.carregarDeMapa(Map<String, dynamic> solicitacaoAsMap) {
    String dataEntrega = "${solicitacaoAsMap["dataEntrega"]} ${solicitacaoAsMap["horaEntrega"]}";
    String dataCriacao = "${solicitacaoAsMap["dataCriacao"]} ${solicitacaoAsMap["horaCriacao"]}";
    String dataAtualizacao = "${solicitacaoAsMap["dataAtualizacao"]} ${solicitacaoAsMap["horaAtualizacao"]}";
    String dataAceite = "${solicitacaoAsMap["dataAceite"]} ${solicitacaoAsMap["horaAceite"]}";
    String dataDevolucao = "${solicitacaoAsMap["dataDevolucao"]} ${solicitacaoAsMap["horaDevolucao"]}";
    return Solicitacao.carregar(
      solicitacaoAsMap["codigoSolicitacao"],
      solicitacaoAsMap["emailUsuarioReceptor"],
      solicitacaoAsMap["emailUsuarioSolicitante"],
      LivrosSolicitacao.carregarDeMapa(
        (solicitacaoAsMap["livrosUsuarioSolicitante"])?.toList() ?? [],
        solicitacaoAsMap,
        solicitacaoAsMap["emailUsuarioSolicitante"],
      ),
      LivrosSolicitacao.carregarDeMapa(
        (solicitacaoAsMap["livrosTroca"])?.toList() ?? [],
        solicitacaoAsMap,
        solicitacaoAsMap["emailUsuarioReceptor"],
      ),
      FormaEntrega.deNumero(solicitacaoAsMap["codigoFormaEntrega"] as int),
      solicitacaoAsMap['dataCriacao'] == null ? null : DataHora.deString(dataCriacao),
      solicitacaoAsMap['dataEntrega'] == null ? null : DataHora.deString(dataEntrega),
      solicitacaoAsMap["dataDevolucao"] == null ? null : DataHora.deString(dataDevolucao),
      solicitacaoAsMap['dataAtualizacao'] == null ? null : DataHora.deString(dataAtualizacao),
      solicitacaoAsMap["informacoesAdicionais"],
      solicitacaoAsMap["enderecoSolicitante"] == null
          ? null
          : Endereco.carregarDeMapa(solicitacaoAsMap["enderecoSolicitante"]),
      solicitacaoAsMap["enderecoUsuarioCriador"] == null ? false : solicitacaoAsMap["enderecoUsuarioCriador"] as bool,
      TipoSolicitacao.deNumero(solicitacaoAsMap["codigoTipoSolicitacao"] as int? ?? 1),
      TipoStatusSolicitacao.deNumero(int.tryParse(solicitacaoAsMap["codigoStatusSolicitacao"].toString()) ?? 1),
      solicitacaoAsMap["dataAceite"] == null ? null : DataHora.deString(dataAceite),
      solicitacaoAsMap["motivoRecusa"],
      solicitacaoAsMap["codigoRastreioCorreio"],
      solicitacaoAsMap["enderecoReceptor"] == null
          ? null
          : Endereco.carregarDeMapa(solicitacaoAsMap["enderecoReceptor"]),
    );
  }

  static void validarDataDevolucao(DataHora? dataDevolucao) {
    if (dataDevolucao != null && dataDevolucao.ehAntesDe(DataHora.hoje())) {
      throw DataSolicitacaoInvalida("Data de devolução não pode ser anterior a data atual");
    }
  }

  static void validarDataEntrega(DataHora? dataEntrega) {
    if (dataEntrega != null && dataEntrega.ehAntesDe(DataHora.hoje())) {
      throw DataSolicitacaoInvalida("Data de entrega não pode ser anterior a data atual");
    }
  }

  static void validarDataEntregaEDevolucao(DataHora? dataEntrega, DataHora? dataDevolucao) {
    if (dataEntrega != null && dataDevolucao != null && dataEntrega.ehDepoisDe(dataDevolucao)) {
      throw DataSolicitacaoInvalida("Data de entrega não pode ser posterior a data de devolução");
    }

    if (dataEntrega != null && dataDevolucao != null && dataDevolucao.ehAntesDe(dataEntrega)) {
      throw DataSolicitacaoInvalida("Data de devolução não pode ser anterior a data de entrega");
    }

    if (dataEntrega != null && dataDevolucao != null && dataDevolucao.ehIgualA(dataEntrega)) {
      throw DataSolicitacaoInvalida("Data de devolução não pode ser igual a data de entrega");
    }
  }

  LivrosSolicitacao get livrosUsuarioSolicitante => _livrosUsuarioSolicitante;

  String get emailUsuarioProprietario => _emailUsuarioReceptor;

  LivrosSolicitacao get livrosSolicitante => _livrosUsuarioSolicitante;

  FormaEntrega get formaEntrega => _formaEntrega;

  DataHora? get dataCriacao => _dataCriacao;

  DataHora? get dataEntrga => _dataEntrega;

  bool get enderecoUsuarioCriador => _enderecoUsuarioCriador;

  DataHora? get dataDevolucao => _dataDevolucao;

  DataHora? get dataAtualizacao => _dataAtualizacao;

  String get informacoesAdicionais => _informacoesAdicionais;

  Endereco? get enderecoSolicitante => _enderecoSolicitante;

  Endereco? get enderecoReceptor => _enderecoReceptor;

  TipoStatusSolicitacao get status => _status;

  LivrosSolicitacao? get livrosReceptor => _livrosUsuarioReceptor;

  String? get motivoRecusa => _motivoRecusa;

  DataHora? get dataAceite => _dataAceite;

  DataHora? get dataEntrega => _dataEntrega;

  TipoSolicitacao get tipoSolicitacao => _tipoSolicitacao;

  String get emailUsuarioSolicitante => _emailUsuarioSolicitante;

  LivrosSolicitacao? get livrosUsuarioReceptor => _livrosUsuarioReceptor;

  String? get codigoRastreamento => _codigoRastreamento;
}

class DataSolicitacaoInvalida extends ErroDominio {
  DataSolicitacaoInvalida(String mensagemException) : super(mensagemException);
}

class SolicitacaoFinalizada extends ErroDominio {
  SolicitacaoFinalizada() : super("Solicitação já finalizada");
}

class SolicitacaoRecusada extends ErroDominio {
  SolicitacaoRecusada() : super("Solicitação não está mais disponível para aceite");
}