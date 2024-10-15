import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:leituramiga/domain/super/entidade.dart';

class Solicitacao extends Entidade {
  final int? _numero;
  final String _emailUsuarioProprietario;
  final String _emailUsuarioCriador;
  final LivrosSolicitacao _livrosCriador;
  LivrosSolicitacao? _livrosProprietario;
  final FormaEntrega _formaEntrega;
  final DataHora? _dataCriacao;
  final DataHora _dataEntrega;
  final DataHora? _dataDevolucao;
  final DataHora? _dataAtualizacao;
  final String _informacoesAdicionais;
  Endereco? _endereco;
  final bool _enderecoUsuarioCriador;
  final TipoSolicitacao _tipoSolicitacao;
  final TipoStatusSolicitacao _status;
  final DataHora? _dataAceite;
  final String? _motivoRecusa;
  final String? _codigoRastreamento;

  Solicitacao.criar(
    this._numero,
    this._emailUsuarioProprietario,
    this._emailUsuarioCriador,
    this._formaEntrega,
    this._dataCriacao,
    this._dataEntrega,
    this._dataDevolucao,
    this._dataAtualizacao,
    this._informacoesAdicionais,
    this._endereco,
    this._status,
    this._dataAceite,
    this._motivoRecusa,
    this._tipoSolicitacao,
    this._codigoRastreamento,
  )   : _livrosCriador = LivrosSolicitacao.carregar(_numero ?? 0, _emailUsuarioCriador, []),
        _enderecoUsuarioCriador = _endereco == null;

  Solicitacao.carregar(
    this._numero,
    this._emailUsuarioProprietario,
    this._emailUsuarioCriador,
    this._livrosCriador,
    this._livrosProprietario,
    this._formaEntrega,
    this._dataCriacao,
    this._dataEntrega,
    this._dataDevolucao,
    this._dataAtualizacao,
    this._informacoesAdicionais,
    this._endereco,
    this._enderecoUsuarioCriador,
    this._tipoSolicitacao,
    this._status,
    this._dataAceite,
    this._motivoRecusa,
    this._codigoRastreamento,
  );

  int? get numero => _numero;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      "codigoSolicitacao": _numero,
      "emailUsuarioReceptor": _emailUsuarioProprietario,
      "emailUsuarioSolicitante": _emailUsuarioCriador,
      "livrosUsuarioSolicitante": _livrosCriador.paraMapa(),
      "livrosTroca": _livrosProprietario?.paraMapa(),
      "codigoFormaEntrega": _formaEntrega.id,
      "dataCriacao": _dataCriacao?.formatar("yyyy-MM-dd"),
      "dataEntrega": _dataEntrega.formatar("yyyy-MM-dd"),
      "horaEntrega": _dataEntrega.formatar("HH:mm:ss"),
      "horaCriacao": _dataCriacao?.formatar("HH:mm:ss"),
      "horaAtualizacao": _dataAtualizacao?.formatar("HH:mm:ss"),
      "horaAceite": _dataAceite?.formatar("HH:mm:ss"),
      "horaDevolucao": _dataDevolucao?.formatar("HH:mm:ss"),
      "dataDevolucao": _dataDevolucao?.formatar("yyyy-MM-dd"),
      "dataAceite": _dataAceite?.formatar("yyyy-MM-dd"),
      "dataAtualizacao": _dataAtualizacao?.toString(),
      "informacoesAdicionais": _informacoesAdicionais,
      "endereco": _endereco?.paraMapa(),
      "enderecoUsuarioCriador": _enderecoUsuarioCriador,
      "codigoTipoSolicitacao": _tipoSolicitacao.id,
      "codigoStatusSolicitacao": _status.id,
      "motivoRecusa": _motivoRecusa,
      "codigoRastreioCorreio": _codigoRastreamento,
    };
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
    );
    _endereco = endereco;
  }

  void adicionar(Livro livro, String emailUsuario) {
    if (emailUsuario == _emailUsuarioCriador) {
      _livrosCriador.adicionar(livro);
    } else {
      _livrosProprietario ??= LivrosSolicitacao.carregar(_numero ?? 0, _emailUsuarioProprietario, []);
      _livrosProprietario!.adicionar(livro);
    }
  }

  factory Solicitacao.carregarDeMapa(Map<String, dynamic> solicitacaoAsMap) {
    String dataEntrega = "${solicitacaoAsMap["dataEntrega"]} ${solicitacaoAsMap["horaEntrega"]}";
    String dataCriacao = "${solicitacaoAsMap["dataCriacao"]} ${solicitacaoAsMap["horaCriacao"]}";
    String dataAtualizacao = "${solicitacaoAsMap["dataAtualizacao"]} ${solicitacaoAsMap["horaAtualizacao"]}";
    String dataAceite = "${solicitacaoAsMap["dataAceite"]} ${solicitacaoAsMap["horaAceite"]}";
    String dataDevolucao = "${solicitacaoAsMap["dataDevolucao"]} ${solicitacaoAsMap["horaDevolucao"]}";
    print(solicitacaoAsMap);
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
      DataHora.deString(dataEntrega),
      solicitacaoAsMap["dataDevolucao"] == null ? null : DataHora.deString(dataDevolucao),
      solicitacaoAsMap['dataAtualizacao'] == null ? null : DataHora.deString(dataAtualizacao),
      solicitacaoAsMap["informacoesAdicionais"],
      solicitacaoAsMap["endereco"] == null ? null : Endereco.carregarDeMapa(solicitacaoAsMap["endereco"]),
      solicitacaoAsMap["enderecoUsuarioCriador"] == null ? false : solicitacaoAsMap["enderecoUsuarioCriador"] as bool,
      TipoSolicitacao.deNumero(solicitacaoAsMap["codigoTipoSolicitacao"] as int? ?? 1),
      TipoStatusSolicitacao.deNumero(int.tryParse(solicitacaoAsMap["codigoStatusSolicitacao"].toString()) ?? 1),
      solicitacaoAsMap["dataAceite"] == null ? null : DataHora.deString(dataAceite),
      solicitacaoAsMap["motivoRecusa"],
      solicitacaoAsMap["codigoRastreioCorreio"],
    );
  }

  String get emailUsuarioProprietario => _emailUsuarioProprietario;

  LivrosSolicitacao get livrosCriador => _livrosCriador;

  FormaEntrega get formaEntrega => _formaEntrega;

  DataHora? get dataCriacao => _dataCriacao;

  DataHora get dataEntrga => _dataEntrega;

  bool get enderecoUsuarioCriador => _enderecoUsuarioCriador;

  DataHora? get dataDevolucao => _dataDevolucao;

  DataHora? get dataAtualizacao => _dataAtualizacao;

  String get informacoesAdicionais => _informacoesAdicionais;

  Endereco? get endereco => _endereco;

  TipoStatusSolicitacao get status => _status;

  LivrosSolicitacao? get livrosProprietario => _livrosProprietario;

  String? get motivoRecusa => _motivoRecusa;

  DataHora? get dataAceite => _dataAceite;

  DataHora get dataEntrega => _dataEntrega;

  TipoSolicitacao get tipoSolicitacao => _tipoSolicitacao;

  String get emailUsuarioCriador => _emailUsuarioCriador;
}
