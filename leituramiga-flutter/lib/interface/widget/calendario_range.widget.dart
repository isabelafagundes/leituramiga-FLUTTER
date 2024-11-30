import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:leituramiga/domain/data_hora.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';

class CalendarioRangeWidget extends StatefulWidget {
  final Tema tema;
  final DateTime? dataInicial;
  final DateTime? dataFinal;
  final Function(DateTime, DateTime) aoSelecionarDataRange;

  const CalendarioRangeWidget({
    super.key,
    required this.tema,
    required this.aoSelecionarDataRange,
    this.dataInicial,
    this.dataFinal,
  });

  @override
  State<CalendarioRangeWidget> createState() => _CalendarioRangeWidgetState();
}

class _CalendarioRangeWidgetState extends State<CalendarioRangeWidget> {
  DateTime? dataInicioSelecionada;
  DateTime? dataFimSelecionada;

  @override
  void initState() {
    super.initState();
    dataInicioSelecionada = widget.dataInicial ?? DataHora.hoje().valor;
    dataFimSelecionada = widget.dataFinal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeDatePicker(
          maxDate: DateTime(2200, 12, 31),
          minDate: DateTime(2024, 01, 12),
          initialDate: DataHora.hoje().valor,
          enabledCellsTextStyle: textStyle,
          leadingDateTextStyle: textStyle,
          selectedCellsTextStyle: textStyleSelected,
          singelSelectedCellTextStyle: textStyleSelected,
          singelSelectedCellDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(widget.tema.accent),
          ),
          selectedCellsDecoration: BoxDecoration(
            color: Color(widget.tema.accent),
          ),
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
          enabledCellsDecoration: const BoxDecoration(shape: BoxShape.circle),
          onRangeSelected: (dataRange) => setState(() {
            dataInicioSelecionada = dataRange.start;
            dataFimSelecionada = dataRange.end;
          }),
        ),
        SizedBox(height: widget.tema.espacamento * 4),
        BotaoWidget(
          tema: widget.tema,
          desabilitado: dataInicioSelecionada == null || dataFimSelecionada == null,
          texto: 'Selecionar',
          nomeIcone: "seta/arrow-long-right",
          aoClicar: () => widget.aoSelecionarDataRange(dataInicioSelecionada!, dataFimSelecionada!),
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
        color: Color(widget.tema.base200),
        fontSize: widget.tema.tamanhoFonteM,
        fontFamily: widget.tema.familiaDeFontePrimaria,
      );
}
