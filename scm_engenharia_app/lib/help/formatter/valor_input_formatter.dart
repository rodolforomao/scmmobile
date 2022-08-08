import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class ValorInputFormatter extends TextInputFormatter {

  int maxLength;
  bool prefix;
  String value = '';

  ValorInputFormatter({this.maxLength = 12, this.prefix = false});

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final novoTextLength = newValue.text.length;

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }
    if (novoTextLength > this.maxLength) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");

    if(this.prefix == true) {
      this.value = "R\$ " + formatter.format(value / 100);
    }else{
      this.value = formatter.format(value / 100);
    }
    return newValue.copyWith(
        text: this.value,
        selection: new TextSelection.collapsed(offset: this.value.length));
  }

}