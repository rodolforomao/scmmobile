
class UtilFields {
  /// Remover caracteres especiais (ex: `/`, `-`, `.`)
  static String removeCaracteres(String valor) {
    assert(valor.isNotEmpty);
    return valor.replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
  }

  /// Remover o símbolo `R$`
  static String removerSimboloMoeda(String valor) {
    assert(valor.isNotEmpty);
    return valor.replaceAll('R\$ ', '');
  }

  /// Converter o valor de uma String com `R$`
  static double converterMoedaParaDouble(String valor) {
    assert(valor.isNotEmpty);
    final value = double.tryParse(
        valor.replaceAll('R\$ ', '').replaceAll('.', '').replaceAll(',', '.'));

    return value ?? 0;
  }

  /// Retorna o CNPJ informado, utilizando a máscara: `XX.YYY-ZZZ`
  ///
  /// Para remover o `.`, informe `ponto=false`.
  static String obterCep(String cep, {bool ponto = true}) {
    assert(
    cep.length == 8, 'CEP com tamanho inválido. Deve conter 8 caracteres');

    return ponto
        ? '${cep.substring(0, 2)}.${cep.substring(2, 5)}-${cep.substring(5, 8)}'
        : '${cep.substring(0, 2)}${cep.substring(2, 5)}-${cep.substring(5, 8)}';
  }

  /// Retorna o telefone informado, utilizando a máscara: `(00) 11111-2222`
  ///
  /// Ajusta-se automaticamente para celular e fixo.
  ///
  /// Para retornar apenas os números, informe `mascara=false`.
  static String obterTelefone(String telefone,
      {bool ddd = true, bool mascara = true}) {
    assert((telefone.length <= 15),
    'Telefone com tamanho inválido. Deve conter 10 ou 11 caracteres');
    if (!mascara) return UtilFields.removeCaracteres(telefone);

    if (ddd) {
      assert((telefone.length == 10 || telefone.length == 11),
      'Telefone com tamanho inválido. Deve conter 10 ou 11 caracteres');

      return telefone.length == 10
          ? '(${telefone.substring(0, 2)}) ${telefone.substring(2, 6)}-${telefone.substring(6, 10)}'
          : '(${telefone.substring(0, 2)}) ${telefone.substring(2, 7)}-${telefone.substring(7, 11)}';
    } else {
      assert((telefone.length == 8 || telefone.length == 9),
      'Telefone com tamanho inválido. Deve conter 8 ou 9 caracteres');

      return (telefone.length == 8)
          ? '${telefone.substring(0, 4)}-${telefone.substring(4, 8)}'
          : '${telefone.substring(0, 5)}-${telefone.substring(5, 9)}';
    }
  }

  static String obterDDD(String telefone) {
    assert((telefone.length == 14 || telefone.length == 15),
    'Telefone com tamanho inválido. Deve conter 14 ou 15 caracteres');
    return '${telefone.substring(1, 3)}';
  }

  static String dateString(DateTime data){
    String dia = data.day.toString().padLeft(2,'0');
    String mes = data.month.toString().padLeft(2,'0');
    return '${dia}/${mes}/${data.year}';
  }

  static String dateTimeString(DateTime data){
    String dia = data.day.toString().padLeft(2,'0');
    String mes = data.month.toString().padLeft(2,'0');
    String ano = data.year.toString();
    return '${dia}/${mes}/${ano} ${data.hour}:${data.minute}:${data.second}';
  }

  static DateTime stringDate(String data){
    data = data.toString();
    int dia = int.parse(data.substring(0, 2));
    int mes = int.parse(data.substring(3, 5));
    int ano = int.parse(data.substring(6, 10));
    return DateTime(ano, mes, dia);
  }

  static DateTime stringDateTime(String data){
    data = data.toString();
    int dia = int.parse(data.substring(0, 2));
    int mes = int.parse(data.substring(3, 5));
    int ano = int.parse(data.substring(6, 10));
    int hora = int.parse(data.substring(11, 13));
    int minuto = int.parse(data.substring(14, 16));
    int segundo = int.parse(data.substring(17, 19));
    return DateTime(ano, mes, dia, hora, minuto, segundo);
  }

  static String dateStringBanco(String data){
    data = data.toString(); //00/00/0000
    String dia = data.substring(0, 2);
    String mes = data.substring(3, 5);
    int ano = int.parse(data.substring(6, 10));
    return '${ano}-${mes}-${dia}';
  }

  static bool boolMaiorIdade(String? data){
    data = data.toString();
    int dia = int.parse(data.substring(0, 2));
    int mes = int.parse(data.substring(3, 5));
    int ano = int.parse(data.substring(6, 10));
    DateTime dataNascimento = DateTime(ano, mes, dia);
    DateTime hoje = DateTime.now();

    int diferencaAno = hoje.year - dataNascimento.year;
    int mesDiferenca = hoje.month - dataNascimento.month;
    int diaDiferenca = hoje.day - dataNascimento.day;

    return diferencaAno > 18 || diferencaAno == 18 &&
        mesDiferenca >= 0 && diaDiferenca >= 0;
  }

}