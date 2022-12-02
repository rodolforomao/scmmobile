import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DataInputFormatter extends TextInputFormatter {

  DateTime dataInicio;
  DateTime dataFinal;

  DataInputFormatter({required dataInicio, required dataFinal})
      : this.dataInicio = dataInicio ?? DateTime(1800,01,01),
        this.dataFinal = dataFinal ?? DateTime(3000,01,01);

  bool isValidDate(String date) {

    try {
      final DateTime d = DateFormat('dd/MM/yyyy').parseStrict(date);
      this.dataInicio = DateTime(this.dataInicio.year, this.dataInicio.month, this.dataInicio.day);
      this.dataFinal = DateTime(this.dataFinal.year, this.dataFinal.month, this.dataFinal.day);
      if(d.isBefore(this.dataInicio) || d.isAfter(this.dataFinal)){
         return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/', oldValue);
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator, oldValue) {
    value = value.replaceAll(seperator, '');
    var ret = '';

    for (int i = 0; i < min(value.length, 8); i++) {
      ret += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        ret += seperator;
      }
    }

    if(ret.length == 10 && !isValidDate(ret)){
        ret = '';
    }

    return ret;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}