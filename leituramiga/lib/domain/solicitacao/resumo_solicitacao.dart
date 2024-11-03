import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/super/entidade.dart';

class ResumoSolicitacao extends Entidade {
  final int? _numero;
  final Endereco? _endereco;
  final String _nomeUsuario;
  final DataHora? _dataEntrega;
  final DataHora? _dataDevolucao;
  final TipoSolicitacao _tipo;

  ResumoSolicitacao.carregar(this._numero,
      this._endereco,
      this._nomeUsuario,
      this._dataEntrega,
      this._dataDevolucao,
      this._tipo,);

  int? get numero => _numero;

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {
      'codigoSolicitacao': _numero,
      'endereco': _endereco?.paraMapa(),
      'nomeUsuario': _nomeUsuario,
      'dataEntrega': _dataEntrega.toString(),
      'dataDevolucao': _dataDevolucao?.toString(),
      'tipo': _tipo.index,
    };
  }

  factory ResumoSolicitacao.carregarDeMapa(Map<String, dynamic> mapa) {
    return ResumoSolicitacao.carregar(
      mapa['codigoSolicitacao'],
      mapa['enderecoSolicitante'] == null ? null : Endereco.carregarDeMapa(mapa['enderecoSolicitante']),
      mapa['nomeUsuarioSolicitante'],
      mapa['dataEntrega'] == null ? null : DataHora.deString("${mapa['dataEntrega']} 00:00:00"),
      mapa['dataDevolucao'] == null ? null : DataHora.deString("${mapa['dataDevolucao']} 00:00:00"),
      TipoSolicitacao.deNumero(mapa['codigoTipoSolicitacao']
      ),
    );
  }

  Endereco? get endereco => _endereco;

  String get nomeUsuario => _nomeUsuario;

  DataHora? get dataEntrega => _dataEntrega;

  DataHora? get dataDevolucao => _dataDevolucao;

  TipoSolicitacao get tipo => _tipo;
}
