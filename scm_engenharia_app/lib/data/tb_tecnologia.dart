class TbTecnologia {
  int? idTecnologiaApp;
  String? id;
  String? tecnologia;

  TbTecnologia({this.idTecnologiaApp = 0, this.id, this.tecnologia});

  TbTecnologia.fromJson(Map<String, dynamic> json) {
    idTecnologiaApp = json['idTecnologiaApp'];
    id = json['id'];
    tecnologia =
        json['descricao'] == null ? json['tecnologia'] : json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTecnologiaApp'] = this.idTecnologiaApp;
    data['id'] = this.id;
    data['tecnologia'] = this.tecnologia;
    return data;
  }
}
