import 'package:flutter/services.dart';

/// Formata o valor do campo com a máscara ( 99999-9999 ).
///
/// Nono dígito automático.
class TelefoneSemDddInputFormatter extends TextInputFormatter {
  TelefoneSemDddInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue valorAntigo, TextEditingValue valorNovo) {
    final novoTextLength = valorNovo.text.length;

    var selectionIndex = valorNovo.selection.end;

    if (novoTextLength == 11) {
      if (valorNovo.text.toString()[2] != '9') {
        return valorAntigo;
      }
    }

    /// Verifica o tamanho máximo do campo.
    if (novoTextLength > 11) {
      return valorAntigo;
    }

    var usedSubstringIndex = 0;

    final newText = StringBuffer();

    if (novoTextLength >= 6) {
      newText.write(valorNovo.text.substring(0, usedSubstringIndex = 5) + '-');
      if (valorNovo.selection.end >= 5) selectionIndex++;
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



