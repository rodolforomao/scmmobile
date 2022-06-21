class TbUfMunicipio {
  int? idMunicipioApp;
  String? ufId;
  String? uf;
  String? id;
  String? municipio;

  TbUfMunicipio(
      {this.idMunicipioApp = 0, this.ufId, this.uf, this.id, this.municipio});

  TbUfMunicipio.fromJson(Map<String, dynamic> json) {
    idMunicipioApp = json['idMunicipioApp'];
    ufId = json['ufId'];
    uf = json['uf'];
    id = json['id'];
    municipio = json['municipio'];
    // municipio =
    //     json['descricao'] == null ? json['municipio'] : json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMunicipioApp'] = this.idMunicipioApp;
    data['ufId'] = this.ufId;
    data['uf'] = this.uf;
    data['id'] = this.id;
    data['municipio'] = this.municipio;
    return data;
  }
}
