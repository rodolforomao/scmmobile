class TbFichaSici {
  int idFichaSiciApp;
  String idEmpresa;
  String idLancamento;
  String periodoReferencia;
  String razaoSocial;
  String nomeCliente;
  String nomeConsultor;
  String telefoneFixo;
  String cnpj;
  String mesReferencia;
  String telefoneMovel;
  String emailCliente;
  String emailConsutor;
  String receitaBruta;
  String idFinanceiro;
  String simples;
  String simplesPorc;
  String icms;
  String icmsPorc;
  String pis;
  String pisPorc;
  String cofins;
  String cofinsPorc;
  String receitaLiquida;
  String observacoes;
  String id;
  String cod_ibge;
  String id_uf;


  TbFichaSici({
    this.idFichaSiciApp,
    this.idEmpresa,
    this.idLancamento,
    this.periodoReferencia,
    this.razaoSocial,
    this.nomeCliente,
    this.nomeConsultor,
    this.telefoneFixo,
    this.cnpj,
    this.mesReferencia,
    this.telefoneMovel,
    this.emailCliente,
    this.emailConsutor,
    this.receitaBruta,
    this.idFinanceiro,
    this.simples,
    this.simplesPorc,
    this.icms,
    this.icmsPorc,
    this.pis,
    this.pisPorc,
    this.cofins,
    this.cofinsPorc,
    this.receitaLiquida,
    this.observacoes,
    this.id,
    this.cod_ibge,
    this.id_uf,

  });

  TbFichaSici.fromJson(Map<String, dynamic> json) {
    idFichaSiciApp= json['idFichaSiciApp'];
    idEmpresa= json['idEmpresa'];
    idLancamento= json['idLancamento'];
    periodoReferencia= json['periodoReferencia'];
    razaoSocial= json['razaoSocial'];
    nomeCliente= json['nomeCliente'];
    nomeConsultor= json['nomeConsultor'];
    telefoneFixo= json['telefoneFixo'];
    cnpj= json['cnpj'];
    mesReferencia= json['mesReferencia'];
    telefoneMovel= json['telefoneMovel'];
    emailCliente= json['emailCliente'];
    emailConsutor= json['emailConsutor'];
    receitaBruta= json['receitaBruta'];
    idFinanceiro= json['idFinanceiro'];
    simples= json['simples'];
    simplesPorc= json['simplesPorc'];
    icms= json['icms'];
    icmsPorc= json['icmsPorc'];
    pis= json['pis'];
    pisPorc= json['pisPorc'];
    cofins= json['cofins'];
    cofinsPorc= json['cofinsPorc'];
    receitaLiquida= json['receitaLiquida'];
    observacoes= json['observacoes'];
    id = json['id'];
    cod_ibge= json['cod_ibge'];
    id_uf= json['id_uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFichaSiciApp'] = this.idFichaSiciApp;
    data['idEmpresa'] = this.idEmpresa;
    data['idLancamento'] = this.idLancamento;
    data['periodoReferencia'] = this.periodoReferencia;
    data['razaoSocial'] = this.razaoSocial;
    data['nomeCliente'] = this.nomeCliente;
    data['nomeConsultor'] = this.nomeConsultor;
    data['telefoneFixo'] = this.telefoneFixo;
    data['cnpj'] = this.cnpj;
    data['mesReferencia'] = this.mesReferencia;
    data['telefoneMovel'] = this.telefoneMovel;
    data['emailCliente'] = this.emailCliente;
    data['emailConsutor'] = this.emailConsutor;
    data['receitaBruta'] = this.receitaBruta;
    data['idFinanceiro'] = this.idFinanceiro;
    data['simples'] = this.simples;
    data['simplesPorc'] = this.simplesPorc;
    data['icms'] = this.icms;
    data['icmsPorc'] = this.icmsPorc;
    data['pis'] = this.pis;
    data['pisPorc'] = this.pisPorc;
    data['cofins'] = this.cofins;
    data['cofinsPorc'] = this.cofinsPorc;
    data['receitaLiquida'] = this.receitaLiquida;
    data['observacoes'] = this.observacoes;
    data['id'] = this.id;
    data['cod_ibge'] = this.cod_ibge;
    data['id_uf'] = this.id_uf;

    return data;
  }
}
