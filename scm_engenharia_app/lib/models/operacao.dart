class Operacao {
  bool erro;
  String mensagem;
  Object resultado;
}
class OperacaoJson {
  bool status;
  String mensagem;
  Object resultado;

  OperacaoJson({this.status, this.mensagem, this.resultado});

  OperacaoJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mensagem = json['mensagem'];
    resultado = json['resultado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['mensagem'] = this.mensagem;
    data['resultado'] = this.resultado;
    return data;
  }
}