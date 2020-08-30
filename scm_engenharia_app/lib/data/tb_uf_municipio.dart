class TbUfMunicipio {
  int idMunicipioApp;
  String ufId;
  String uf;
  String id;
  String municipio;

  TbUfMunicipio({this.idMunicipioApp,this.ufId, this.uf, this.id, this.municipio});

  TbUfMunicipio.fromJson(Map<String, dynamic> json) {
    idMunicipioApp = json['idMunicipioApp'];
    ufId = json['uf_id'];
    uf = json['uf'];
    id = json['id'];
    municipio = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMunicipioApp'] = this.idMunicipioApp;
    data['uf_id'] = this.ufId;
    data['uf'] = this.uf;
    data['id'] = this.id;
    data['municipio'] = this.municipio;
    return data;
  }
}