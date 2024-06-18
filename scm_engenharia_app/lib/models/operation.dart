class Operation {
  late bool erro;
  String? message;
  late int statusCode;
  Object? result;
  late List resultList = [];
}
class OperationJson {
  late bool? status;
  String? message;
  Object? result;

  OperationJson({this.status, this.message, this.result});

  OperationJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['mensagem'];
    result = json['resultado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['mensagem'] = message;
    data['resultado'] = result;
    return data;
  }
}