import 'package:leituramiga/domain/super/entidade.dart';

class Notificacao extends Entidade {
  final int? _numero;
  final String _nomeUsuario;
  final String _emailUsuario;
  final int _numeroSolicitacao;
  final String? _imagem;

  Notificacao.carregar(
    this._numero,
    this._nomeUsuario,
    this._emailUsuario,
    this._numeroSolicitacao,
    this._imagem,
  );

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  Notificacao.carregarDeMapa(Map<String, dynamic> mapa)
      : this.carregar(
          mapa['numero'],
          mapa['nomeUsuarioSolicitante'],
          mapa['emailUsuarioSolicitante'],
          mapa['codigoSolicitacao'],
          mapa['imagem'],
        );

  String get emailUsuario => _emailUsuario;

  String get nomeUsuario => _nomeUsuario;

  int get numeroSolicitacao => _numeroSolicitacao;

  int? get numero => _numero;

  String? get imagem => _imagem;
}
