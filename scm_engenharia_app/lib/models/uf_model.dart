class UfModel {
  int? idUfApp;
  String? id;
  String? uf;

  UfModel({this.idUfApp = 0, this.id, this.uf});

  UfModel.fromJson(Map<String, dynamic> json) {
    idUfApp = json['idUfApp'];
    id = json['id'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUfApp'] = this.idUfApp;
    data['id'] = this.id;
    data['uf'] = this.uf;
    return data;
  }
}