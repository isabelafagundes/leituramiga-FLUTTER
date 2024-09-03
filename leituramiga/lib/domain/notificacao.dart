import 'package:leituramiga/domain/super/entidade.dart';

class Notificacao extends Entidade {
  final int _numero;
  final String _nomeUsuario;
  final int _numeroUsuario;
  final int _numeroSolicitacao;

  Notificacao.carregar(
    this._numero,
    this._nomeUsuario,
    this._numeroUsuario,
    this._numeroSolicitacao,
  );

  @override
  String get id => _numero.toString();

  @override
  Map<String, dynamic> paraMapa() {
    return {};
  }

  int get numeroUsuario => _numeroUsuario;

  String get nomeUsuario => _nomeUsuario;

  int get numeroSolicitacao => _numeroSolicitacao;

  int get numero => _numero;
}
