import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/solicitacao/livros_solicitacao.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
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
  final DataHora _dataCriacao;
  final DataHora _dataEntrega;
  final DataHora? _dataDevolucao;
  final DataHora _dataAtualizacao;
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
      "formaEntrega": _formaEntrega.id,
      "dataCriacao": _dataCriacao.toString(),
      "dataEntrega": _dataEntrega.toString(),
      "dataDevolucao": _dataDevolucao?.toString(),
      "dataAtualizacao": _dataAtualizacao.toString(),
      "informacoesAdicionais": _informacoesAdicionais,
      "endereco": _endereco?.paraMapa(),
      "enderecoUsuarioCriador": _enderecoUsuarioCriador,
      "codigoTipoSolicitacao": _tipoSolicitacao.id,
      "codigoStatusSolicitacao": _status.id,
      "dataAceite": _dataAceite?.toString(),
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
    return Solicitacao.carregar(
      solicitacaoAsMap["codigoSolicitacao"],
      solicitacaoAsMap["emailUsuarioReceptor"],
      solicitacaoAsMap["emailUsuarioSolicitante"],
      LivrosSolicitacao.carregarDeMapa(solicitacaoAsMap["livrosUsuarioSolicitante"]),
      LivrosSolicitacao.carregarDeMapa(solicitacaoAsMap["livrosTroca"]),
      FormaEntrega.deNumero(solicitacaoAsMap["formaEntrega"]),
      DataHora.deString(dataCriacao),
      DataHora.deString(dataEntrega),
      solicitacaoAsMap["dataDevolucao"] == null ? null : DataHora.deString(dataDevolucao),
      DataHora.deString(dataAtualizacao),
      solicitacaoAsMap["informacoesAdicionais"],
      solicitacaoAsMap["endereco"] == null ? null : Endereco.carregarDeMapa(solicitacaoAsMap["endereco"]),
      solicitacaoAsMap["enderecoUsuarioCriador"],
      TipoSolicitacao.deNumero(solicitacaoAsMap["codigoTipoSolicitacao"]),
      TipoStatusSolicitacao.deNumero(solicitacaoAsMap["codigoStatusSolicitacao"]),
      solicitacaoAsMap["dataAceite"] == null ? null : DataHora.deString(dataAceite),
      solicitacaoAsMap["motivoRecusa"],
      solicitacaoAsMap["codigoRastreioCorreio"],
    );
  }

  String get emailUsuarioProprietario => _emailUsuarioProprietario;

  LivrosSolicitacao get livrosCriador => _livrosCriador;

  FormaEntrega get formaEntrega => _formaEntrega;

  DataHora get dataCriacao => _dataCriacao;

  DataHora get dataEntrga => _dataEntrega;

  bool get enderecoUsuarioCriador => _enderecoUsuarioCriador;

  DataHora? get dataDevolucao => _dataDevolucao;

  DataHora get dataAtualizacao => _dataAtualizacao;

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
