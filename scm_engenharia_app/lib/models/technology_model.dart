class TechnologyModel {
  int? idTecnologiaApp;
  String? id;
  String? tecnologia;

  TechnologyModel({
    this.idTecnologiaApp = 0,
    this.id,
    this.tecnologia});

  TechnologyModel.fromJson(Map<String, dynamic> json) {
    idTecnologiaApp = json['idTecnologiaApp'];
    id = json['id'];
    tecnologia = json['tecnologia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTecnologiaApp'] = this.idTecnologiaApp;
    data['id'] = this.id;
    data['tecnologia'] = this.tecnologia;
    return data;
  }
}