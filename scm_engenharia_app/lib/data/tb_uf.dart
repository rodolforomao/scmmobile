class TbUf {
  String idUf;
  String id;
  String uf;

  TbUf({this.id, this.uf});

  TbUf.fromJson(Map<String, dynamic> json) {
    idUf = json['idUf'];
    id = json['id'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUf'] = this.idUf;
    data['id'] = this.id;
    data['uf'] = this.uf;
    return data;
  }
}