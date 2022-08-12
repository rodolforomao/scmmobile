import 'package:flutter/services.dart';
import 'compoundable_formatter.dart';

/// Formata o valor do campo com a mascara de CPF `XXX.XXX.XXX-XX`
class CnpjInputFormatter extends TextInputFormatter
    implements CompoundableFormatter {
  /// Define o tamanho máximo do campo.
  @override
  int get maxLength => 11;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue valorAntigo, TextEditingValue valorNovo) {
    final novoTextLength = valorNovo.text.length;
    var selectionIndex = valorNovo.selection.end;

    if (novoTextLength > maxLength) {
      return valorAntigo;
    }

    var usedSubstringIndex = 0;
    final newText = StringBuffer();

    if (novoTextLength >= 3) {
      newText.write('${valorNovo.text.substring(0, usedSubstringIndex = 2)}.');
      if (valorNovo.selection.end >= 2) selectionIndex++;
    }
    if (novoTextLength >= 7) {
      newText.write(valorNovo.text.substring(3, usedSubstringIndex = 6) + '.');
      if (valorNovo.selection.end >= 6) selectionIndex++;
    }
    if (novoTextLength >= 10) {
      newText.write(valorNovo.text.substring(6, usedSubstringIndex = 9) + '-');
      if (valorNovo.selection.end >= 9) selectionIndex++;
    }
    if (novoTextLength >= usedSubstringIndex) {
      newText.write(valorNovo.text.substring(usedSubstringIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}