import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';

class TimePickerWidget extends StatelessWidget {
  final Tema tema;
  final Widget child;

  const TimePickerWidget({super.key, required this.tema, required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        dialogBackgroundColor: Color(tema.base200),
        colorScheme: ColorScheme.light(
          primary: Color(tema.accent),
          onSurface: Color(tema.accent),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(
              TextStyle(
                color: Color(tema.accent),
                fontSize: tema.tamanhoFonteM,
                fontFamily: tema.familiaDeFontePrimaria,
              ),
            ),
            foregroundColor: WidgetStateProperty.all(Color(tema.accent)),
          ),
        ),
        timePickerTheme: TimePickerThemeData(
          dialTextStyle: TextStyle(
            color: Color(tema.baseContent),
            fontSize: tema.tamanhoFonteM,
            fontFamily: tema.familiaDeFontePrimaria,
          ),
          dialTextColor: Color(tema.baseContent),
          backgroundColor: Color(tema.base200),
          hourMinuteColor: Color(tema.base100),
          dialHandColor: Color(tema.accent).withOpacity(.3),
          dialBackgroundColor: Color(tema.base200),
          dayPeriodTextColor: Color(tema.baseContent),
          hourMinuteTextColor: Color(tema.baseContent),
          hourMinuteTextStyle: TextStyle(
            color: Color(tema.baseContent),
            fontSize: tema.tamanhoFonteXG * 2,
            fontFamily: tema.familiaDeFontePrimaria,
          ),
          helpTextStyle: TextStyle(
            color: Color(tema.baseContent),
            fontSize: tema.tamanhoFonteM,
            fontFamily: tema.familiaDeFontePrimaria,
          ),
          dayPeriodTextStyle: TextStyle(
            color: Color(tema.baseContent),
            fontSize: tema.tamanhoFonteXG * 2,
            fontFamily: tema.familiaDeFontePrimaria,
          ),
          entryModeIconColor: Color(tema.accent),
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(tema.accent),
          ),
        ),
      ),
      child: child!,
    );
  }
}
