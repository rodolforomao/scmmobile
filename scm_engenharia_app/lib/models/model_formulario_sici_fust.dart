
class ModelFormularioSiciFustJson {

  String periodo_referencia;
  String cnpj;
  String razao_social;
  String nome_responsavel_preenchimento;
  String telefone_celular;
  String telefone_fixo;
  String email_consutor;
  String email_cliente;
  String nome_cliente;
  String mes_referencia;


  String receita_bruta;
  String receita_liquida;
  String simples;
  String simplesPorc;
  String icms;
  String icmsPorc;
  String pis;
  String pisPorc;
  String cofins;
  String cofinsPorc;
  String observacoes;

  List<ModelDistribuicaoFisicosServicoQuantitativoJson> distribuicaoFisicosServicoQuantitativo;

  ModelFormularioSiciFustJson({
    this.cnpj,
    this.razao_social,
    this.nome_responsavel_preenchimento,
    this.telefone_celular,
    this.telefone_fixo,
    this.email_consutor,
    this.email_cliente,
    this.nome_cliente,
    this.mes_referencia,
    this.periodo_referencia,

    this.receita_bruta,
    this.receita_liquida,
    this.simples,
    this.simplesPorc,
    this.icms,
    this.icmsPorc,
    this.pis,
    this.pisPorc,
    this.cofins,
    this.cofinsPorc,
    this.observacoes,
    this.distribuicaoFisicosServicoQuantitativo,
  });

  ModelFormularioSiciFustJson.fromJson(Map<String, dynamic> json) {
    cnpj = json['cnpj'];
    razao_social = json['razao_social'];
    nome_responsavel_preenchimento = json['nome_responsavel_preenchimento'];
    telefone_celular = json['telefone_celular'];
    telefone_fixo = json['telefone_fixo'];
    email_consutor = json['email_consutor'];
    email_cliente = json['email_cliente'];
    nome_cliente = json['nome_cliente'];
    mes_referencia = json['mes_referencia'];
    periodo_referencia = json['periodo_referencia'];

    receita_bruta = json['receita_bruta'];
    receita_liquida = json['receita_liquida'];
    simples = json['simples'];
    simplesPorc = json['simplesPorc'];
    icms = json['icms'];
    icmsPorc = json['icmsPorc'];
    pis = json['pis'];
    pisPorc =  json['pisPorc'];
    cofins = json['cofins'];
    cofinsPorc = json['cofinsPorc'];
    observacoes = json['observacoes'];
    if (json['dadosEmServicos'] != null) {
      distribuicaoFisicosServicoQuantitativo = new List<ModelDistribuicaoFisicosServicoQuantitativoJson>();
      json['dadosEmServicos'].forEach((v) {
        distribuicaoFisicosServicoQuantitativo.add(new ModelDistribuicaoFisicosServicoQuantitativoJson.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cnpj'] = this.cnpj;
    data['razao_social'] = this.razao_social;
    data['nome_responsavel_preenchimento'] = this.nome_responsavel_preenchimento;
    data['telefone_celular'] = this.telefone_celular;
    data['telefone_fixo'] = this.telefone_fixo;
    data['email_consutor'] = this.email_consutor;
    data['email_cliente'] = this.email_cliente;
    data['nome_cliente'] = this.nome_cliente;
    data['mes_referencia'] = this.mes_referencia;
    data['periodo_referencia'] = this.periodo_referencia;


    data['receita_bruta'] = this.receita_bruta;
    data['receita_liquida'] = this.receita_liquida;
    data['simples'] = this.simples;
    data['simplesPorc'] = this.simplesPorc;
    data['icms'] = this.icms;
    data['icmsPorc'] = this.icmsPorc;
    data['pis'] = this.pis;
    data['pisPorc'] = this.pisPorc;
    data['cofins'] = this.cofins;
    data['cofinsPorc'] = this.cofinsPorc;
    data['observacoes'] = this.observacoes;
    if (this.distribuicaoFisicosServicoQuantitativo != null) {
      data['dadosEmServicos'] = this.distribuicaoFisicosServicoQuantitativo.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ModelDistribuicaoFisicosServicoQuantitativoJson {
  String id;
  String codIbge;
  String idUf;
  String idMunicipio;
  String idTecnologia;
  String pf0;
  String pf512;
  String pf2;
  String pf12;
  String pf34;
  String pj0;
  String pj512;
  String pj2;
  String pj12;
  String pj34;
  String idLancamento;
  String ultimaAlteracao;
  String idUsuarioUltimaAlteracao;
  String municipio;
  String uf;
  String tecnologia;

  ModelDistribuicaoFisicosServicoQuantitativoJson(
      {this.id,
        this.codIbge,
        this.idUf,
        this.idMunicipio,
        this.idTecnologia,
        this.pf0,
        this.pf512,
        this.pf2,
        this.pf12,
        this.pf34,
        this.pj0,
        this.pj512,
        this.pj2,
        this.pj12,
        this.pj34,
        this.idLancamento,
        this.ultimaAlteracao,
        this.idUsuarioUltimaAlteracao,
        this.municipio,
        this.uf,
        this.tecnologia});

  ModelDistribuicaoFisicosServicoQuantitativoJson.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    codIbge = json['cod_ibge'];
    idUf = json['id_uf'];
    idMunicipio = json['id_municipio'];
    idTecnologia = json['id_tecnologia'];
    pf0 = json['pf_0'];
    pf512 = json['pf_512'];
    pf2 = json['pf_2'];
    pf12 = json['pf_12'];
    pf34 = json['pf_34'];
    pj0 = json['pj_0'];
    pj512 = json['pj_512'];
    pj2 = json['pj_2'];
    pj12 = json['pj_12'];
    pj34 = json['pj_34'];
    idLancamento = json['id_lancamento'];
    ultimaAlteracao = json['ultima_alteracao'];
    idUsuarioUltimaAlteracao = json['id_usuario_ultima_alteracao'];
    municipio = json['municipio'];
    uf = json['uf'];
    tecnologia = json['tecnologia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cod_ibge'] = this.codIbge;
    data['id_uf'] = this.idUf;
    data['id_municipio'] = this.idMunicipio;
    data['id_tecnologia'] = this.idTecnologia;
    data['pf_0'] = this.pf0;
    data['pf_512'] = this.pf512;
    data['pf_2'] = this.pf2;
    data['pf_12'] = this.pf12;
    data['pf_34'] = this.pf34;
    data['pj_0'] = this.pj0;
    data['pj_512'] = this.pj512;
    data['pj_2'] = this.pj2;
    data['pj_12'] = this.pj12;
    data['pj_34'] = this.pj34;
    data['id_lancamento'] = this.idLancamento;
    data['ultima_alteracao'] = this.ultimaAlteracao;
    data['id_usuario_ultima_alteracao'] = this.idUsuarioUltimaAlteracao;
    data['municipio'] = this.municipio;
    data['uf'] = this.uf;
    data['tecnologia'] = this.tecnologia;
    return data;
  }
}



