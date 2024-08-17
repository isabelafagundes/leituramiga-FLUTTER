import 'package:projeto_leituramiga/domain/tema.dart';

mixin class TemaState {
  static TemaState? _instancia;

  TemaState._();

  static TemaState get instancia {
    _instancia ??= TemaState._();
    return _instancia!;
  }

  Tema? get temaSelecionado =>
      _temas
          .where((tema) => tema.selecionado)
          .firstOrNull;

  void alterarTema(int idTema, Function() atualizar) {
    bool temaModoGrande = temaSelecionado!.modoFonteGrande;
    for (Tema tema in _temas) {
      tema.selecionarTema(tema.id == idTema);
      if (tema.id == idTema) tema.alterarFonte(temaModoGrande);
    }
    atualizar();
  }

  void alterarFonte(Function() atualizar) {
    temaSelecionado!.alterarFonte(!temaSelecionado!.modoFonteGrande);
    atualizar();
  }

  final Tema _temaEscuro = Tema.criar(
    id: 1,
    corAccent: "A5FFE5",
    corPrimary: "79b791",
    corSecondary: "3FDFAF",
    corNeutral: "ffffff",
    corBase100: "464A52",
    corInfo: "61b3ff",
    corSuccess: "2dc04b",
    corWarning: "ffad00",
    corError: "ff899a",
    corBase200: "363940",
    corBaseContent: "ffffff",
    corNeutralPrimary: "ffffff",
    espacamento: 8.0,
    borderRadiusP: 8.0,
    borderRadiusM: 16.0,
    borderRadiusG: 24.0,
    borderRadiusXG: 32.0,
    tamanhoFonteP: 10.0,
    tamanhoFonteM: 14.0,
    tamanhoFonteG: 16.0,
    tamanhoFonteXG: 18.0,
    selecionado: true,
    modoFonteGrande: false,
    familiaDeFontePrimaria: 'Montserrat',
    familiaDeFonteSecundaria: 'MontserratAlternates',

  );

  final Tema _temaClaro = Tema.criar(
    id: 2,
    corAccent: "79b791",
    corPrimary: "A5FFE5",
    corSecondary: "3FDFAF",
    corNeutral: "2a2f2c",
    corBase100: "eaeee5",
    corInfo: "61b3ff",
    corSuccess: "2dc04b",
    corWarning: "ffad00",
    corError: "ff899a",
    corBase200: "FFFDFF",
    corBaseContent: "464A52",
    corNeutralPrimary: "004342",
    espacamento: 8.0,
    borderRadiusP: 8.0,
    borderRadiusM: 16.0,
    borderRadiusG: 24.0,
    borderRadiusXG: 32.0,
    tamanhoFonteP: 10.0,
    tamanhoFonteM: 14.0,
    tamanhoFonteG: 16.0,
    tamanhoFonteXG: 18.0,
    selecionado: false,
    modoFonteGrande: false,
    familiaDeFontePrimaria: 'Montserrat',
    familiaDeFonteSecundaria: 'MontserratAlternates',
  );

  List<Tema> get _temas => [_temaEscuro, _temaClaro];
}
