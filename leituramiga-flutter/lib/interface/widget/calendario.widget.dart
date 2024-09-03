import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';

class CalendarioWidget extends StatefulWidget {
  final Tema tema;
  final DateTime? dataInicial;
  final Function(DateTime) aoSelecionarData;

  const CalendarioWidget({
    super.key,
    required this.tema,
    required this.aoSelecionarData,
    this.dataInicial,
  });

  @override
  State<CalendarioWidget> createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  DateTime dataSelecionada = DataHora.hoje().valor;

  @override
  void initState() {
    super.initState();
    dataSelecionada = widget.dataInicial ?? DataHora.hoje().valor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          maxDate: DateTime(2200, 12, 31),
          minDate: DataHora.hoje().valor,
          initialDate: DataHora.hoje().valor,
          enabledCellsTextStyle: textStyle,
          selectedCellTextStyle: textStyleSelected,
          leadingDateTextStyle: textStyle,
          slidersColor: Color(widget.tema.accent),
          highlightColor: Color(widget.tema.accent),
          splashColor: Color(widget.tema.accent),
          daysOfTheWeekTextStyle: textStyle,
          currentDateDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(widget.tema.accent), width: 2),
          ),
          currentDateTextStyle: textStyle,
          disabledCellsDecoration: const BoxDecoration(shape: BoxShape.circle),
          disabledCellsTextStyle: textStyleDisabled,
          selectedCellDecoration: BoxDecoration(
            color: Color(widget.tema.accent),
            shape: BoxShape.circle,
          ),
          enabledCellsDecoration: const BoxDecoration(shape: BoxShape.circle),
          onDateSelected: (data) => setState(() => dataSelecionada = data),
        ),
        SizedBox(height: widget.tema.espacamento * 4),
        BotaoWidget(
          tema: widget.tema,
          texto: 'Selecionar',
          nomeIcone: "seta/arrow-long-right",
          aoClicar: () => widget.aoSelecionarData(dataSelecionada),
        ),
      ],
    );
  }

  TextStyle get textStyleDisabled => TextStyle(
        color: Color(widget.tema.baseContent).withOpacity(.2),
        fontSize: widget.tema.tamanhoFonteM,
        fontFamily: widget.tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyle => TextStyle(
        color: Color(widget.tema.baseContent),
        fontSize: widget.tema.tamanhoFonteM,
        fontFamily: widget.tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyleSelected => TextStyle(
        color: kCorFonte,
        fontSize: widget.tema.tamanhoFonteM,
        fontFamily: widget.tema.familiaDeFontePrimaria,
      );

  TextStyle get textStyleBold => TextStyle(
        color: Color(widget.tema.baseContent),
        fontSize: widget.tema.tamanhoFonteM,
        fontWeight: FontWeight.w500,
        fontFamily: widget.tema.familiaDeFontePrimaria,
      );
}
