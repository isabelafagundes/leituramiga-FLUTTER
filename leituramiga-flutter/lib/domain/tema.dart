import 'package:projeto_leituramiga/domain/cor.dart';

class Tema {
  final int _id;
  final Cor _accent;
  final Cor _secondary;
  final Cor _primary;
  final Cor _neutral;
  final Cor _base100;
  final Cor _base200;
  final Cor _baseContent;
  final Cor _info;
  final Cor _success;
  final Cor _warning;
  final Cor _error;
  final Cor _neutralPrimary;
  final double _espacamento;
  final double _borderRadiusP;
  final double _borderRadiusM;
  final double _borderRadiusG;
  final double _borderRadiusXG;
  final double _tamanhoFonteP;
  final double _tamanhoFonteM;
  final double _tamanhoFonteG;
  final double _tamanhoFonteXG;
  bool _selecionado;
  bool _modoFonteGrande;
  final String _familiaDeFontePrimaria;
  final String? _familiaDeFonteSecundaria;

  Tema.criar({
    required int id,
    required String corAccent,
    required String corPrimary,
    required String corSecondary,
    required String corNeutral,
    required String corBase100,
    required String corInfo,
    required String corSuccess,
    required String corWarning,
    required String corError,
    required String corBase200,
    required String corBaseContent,
    required String corNeutralPrimary,
    required double espacamento,
    required double borderRadiusP,
    required double borderRadiusM,
    required double borderRadiusG,
    required double borderRadiusXG,
    required double tamanhoFonteP,
    required double tamanhoFonteM,
    required double tamanhoFonteG,
    required double tamanhoFonteXG,
    required bool selecionado,
    required bool modoFonteGrande,
    required String familiaDeFontePrimaria,
    String? familiaDeFonteSecundaria,
  })  : _id = id,
        _primary = Cor.criar(corPrimary),
        _accent = Cor.criar(corAccent),
        _secondary = Cor.criar(corSecondary),
        _neutral = Cor.criar(corNeutral),
        _base100 = Cor.criar(corBase100),
        _info = Cor.criar(corInfo),
        _success = Cor.criar(corSuccess),
        _warning = Cor.criar(corWarning),
        _error = Cor.criar(corError),
        _base200 = Cor.criar(corBase200),
        _baseContent = Cor.criar(corBaseContent),
        _borderRadiusG = borderRadiusG,
        _borderRadiusP = borderRadiusP,
        _borderRadiusM = borderRadiusM,
        _borderRadiusXG = borderRadiusXG,
        _tamanhoFonteP = tamanhoFonteP,
        _tamanhoFonteM = tamanhoFonteM,
        _tamanhoFonteG = tamanhoFonteG,
        _tamanhoFonteXG = tamanhoFonteXG,
        _selecionado = selecionado,
        _modoFonteGrande = modoFonteGrande,
        _familiaDeFontePrimaria = familiaDeFontePrimaria,
        _familiaDeFonteSecundaria = familiaDeFontePrimaria,
        _espacamento = espacamento,
        _neutralPrimary = Cor.criar(corNeutralPrimary);

  int get id => _id;

  String get familiaDeFonteSecundaria => _familiaDeFonteSecundaria ?? '';

  String get familiaDeFontePrimaria => _familiaDeFontePrimaria;

  bool get modoFonteGrande => _modoFonteGrande;

  bool get selecionado => _selecionado;

  double get tamanhoFonteG => modoFonteGrande ? _tamanhoFonteG + 2 : _tamanhoFonteG;

  double get tamanhoFonteM => modoFonteGrande ? _tamanhoFonteM + 2 : _tamanhoFonteM;

  double get tamanhoFonteP => modoFonteGrande ? _tamanhoFonteP + 2 : _tamanhoFonteP;

  double get borderRadiusXG => _borderRadiusXG;

  double get borderRadiusG => _borderRadiusG;

  double get borderRadiusM => _borderRadiusM;

  double get borderRadiusP => _borderRadiusP;

  double get espacamento => _espacamento;

  int get error => _error.valor;

  int get warning => _warning.valor;

  int get sucess => _success.valor;

  int get info => _info.valor;

  int get base100 => _base100.valor;

  int get base200 => _base200.valor;

  int get baseContent => _baseContent.valor;

  int get neutral => _neutral.valor;

  int get secondary => _secondary.valor;

  int get neutralPrimary => _neutralPrimary.valor;

  int get accent => _accent.valor;

  int get primary => _primary.valor;

  int get success => _success.valor;

  double get tamanhoFonteXG => _modoFonteGrande ? _tamanhoFonteXG + 2 : _tamanhoFonteXG;

  void selecionarTema(bool selecionar) => _selecionado = selecionar;

  void alterarFonte(bool fonte) => _modoFonteGrande = fonte;
}
