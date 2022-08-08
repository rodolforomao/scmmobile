class QuantitativeDistributionPhysicalAccessesServiceModel {
  int? idApp;
  int? index;
  String? idFichaSiciApp;
  String? id;
  String? cod_ibge;
  String? id_uf;
  String? id_municipio;
  String? id_tecnologia;
  String? pf_0;
  String? pf_512;
  String? pf_2;
  String? pf_12;
  String? pf_34;
  String? pj_0;
  String? pj_512;
  String? pj_2;
  String? pj_12;
  String? pj_34;
  String? id_lancamento;
  String? id_usuario_ultima_alteracao;
  String? municipio;
  String? uf;
  String? tecnologia;

  QuantitativeDistributionPhysicalAccessesServiceModel(
      {this.idApp =0,

        this.idFichaSiciApp,
        this.index,
      this.id,
      this.cod_ibge,
      this.id_uf,
      this.id_municipio,
      this.id_tecnologia,
      this.pf_0,
      this.pf_512,
      this.pf_2,
      this.pf_12,
      this.pf_34,
      this.pj_0,
      this.pj_512,
      this.pj_2,
      this.pj_12,
      this.pj_34,
      this.id_lancamento,
      this.id_usuario_ultima_alteracao,
      this.municipio,
      this.uf,
      this.tecnologia});

  QuantitativeDistributionPhysicalAccessesServiceModel.fromJson(
      Map<String, dynamic> json) {
    idApp = json['idApp'];
    idFichaSiciApp = json['idFichaSiciApp'];
    id = json['id'];
    cod_ibge = json['cod_ibge'];
    id_uf = json['id_uf'];
    id_municipio = json['id_municipio'];
    id_tecnologia = json['id_tecnologia'];
    pf_0 = json['pf_0'];
    pf_512 = json['pf_512'];
    pf_2 = json['pf_2'];
    pf_12 = json['pf_12'];
    pf_34 = json['pf_34'];
    pj_0 = json['pj_0'];
    pj_512 = json['pj_512'];
    pj_2 = json['pj_2'];
    pj_12 = json['pj_12'];
    pj_34 = json['pj_34'];
    id_lancamento = json['id_lancamento'];
    id_usuario_ultima_alteracao = json['id_usuario_ultima_alteracao'];
    municipio = json['municipio'];
    uf = json['uf'];
    tecnologia = json['tecnologia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idApp'] = this.idApp;
    data['idFichaSiciApp'] = this.idFichaSiciApp == null ? "" : this.idFichaSiciApp;
    data['id'] = this.id == null ? "" : this.id;
    data['cod_ibge'] = this.cod_ibge == null ? "" : this.cod_ibge;
    data['id_uf'] = this.id_uf== null ? "" : this.id_uf;
    data['id_municipio'] = this.id_municipio == null ? "" : this.id_municipio;
    data['id_tecnologia'] = this.id_tecnologia == null ? "" : this.id_tecnologia;
    data['pf_0'] = this.pf_0 == null ? "" : this.pf_0;
    data['pf_512'] = this.pf_512 == null ? "" : this.pf_512;
    data['pf_2'] = this.pf_2 == null ? "" : this.pf_2;
    data['pf_12'] = this.pf_12 == null ? "" : this.pf_12;
    data['pf_34'] = this.pf_34 == null ? "" : this.pf_34;
    data['pj_0'] = this.pj_0 == null ? "" : this.pj_0;
    data['pj_512'] = this.pj_512 == null ? "" : this.pj_512;
    data['pj_2'] = this.pj_2 == null ? "" : this.pj_2;
    data['pj_12'] = this.pj_12 == null ? "" : this.pj_12;
    data['pj_34'] = this.pj_34 == null ? "" : this.pj_34;
    data['id_lancamento'] = this.id_lancamento == null ? "" : this.id_lancamento;
    data['id_usuario_ultima_alteracao'] = this.id_usuario_ultima_alteracao == null ? "" : this.id_usuario_ultima_alteracao;
    data['municipio'] = this.municipio == null ? "" : this.municipio;
    data['uf'] = this.uf == null ? "" : this.uf;
    data['tecnologia'] = this.tecnologia == null ? "" : this.tecnologia;
    return data;
  }
}
