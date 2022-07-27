import 'package:scm_engenharia_app/models/quantitative_distribution_physical_accesses_service_model.dart';

class SiciFileModel {
  int? idFichaSiciApp;
  String? idEmpresa;
  String? isSincronizar;
  String? idLancamento;
  String? periodoReferencia;
  String? razaoSocial;
  String? telefoneFixo;
  String? cnpj;
  String? telefoneMovel;
  String? receitaBruta;
  String? idFinanceiro;
  String? simples;
  String? simplesPorc;
  String? icms;
  String? icmsPorc;
  String? pis;
  String? pisPorc;
  String? cofins;
  String? cofinsPorc;
  String? receitaLiquida;
  String? observacoes;
  List<QuantitativeDistributionPhysicalAccessesServiceModel>?
      distribuicaoFisicosServicoQuantitativo;
  SiciFileModel({
    this.idFichaSiciApp = 0,
    this.idEmpresa,
    this.isSincronizar,
    this.idLancamento,
    this.periodoReferencia,
    this.razaoSocial,
    this.telefoneFixo,
    this.cnpj,
    this.telefoneMovel,
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
    this.distribuicaoFisicosServicoQuantitativo,
  });

  SiciFileModel.fromJson(Map<String, dynamic> json) {
    idFichaSiciApp = json['idFichaSiciApp'];
    idEmpresa = json['idEmpresa'];
    isSincronizar = json['isSincronizar'];
    idLancamento = json['idLancamento'];
    periodoReferencia = json['periodoReferencia'];
    razaoSocial = json['razaoSocial'];
    telefoneFixo = json['telefoneFixo'];
    cnpj = json['cnpj'];
    telefoneMovel = json['telefoneMovel'];
    receitaBruta = json['receitaBruta'];
    idFinanceiro = json['idFinanceiro'];
    simples = json['simples'];
    simplesPorc = json['simplesPorc'];
    icms = json['icms'];
    icmsPorc = json['icmsPorc'];
    pis = json['pis'];
    pisPorc = json['pisPorc'];
    cofins = json['cofins'];
    cofinsPorc = json['cofinsPorc'];
    receitaLiquida = json['receitaLiquida'];
    observacoes = json['observacoes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idFichaSiciApp'] = this.idFichaSiciApp;
    data['idEmpresa'] = this.idEmpresa == null ? "" : this.idEmpresa;
    data['isSincronizar'] =
        this.isSincronizar == null ? "" : this.isSincronizar;
    data['idLancamento'] = this.idLancamento == null ? "" : this.idLancamento;
    data['periodoReferencia'] =
        this.periodoReferencia == null ? "" : this.periodoReferencia;
    data['razaoSocial'] = this.razaoSocial == null ? "" : this.razaoSocial;

    data['telefoneFixo'] = this.telefoneFixo == null ? "" : this.telefoneFixo;
    data['cnpj'] = this.cnpj == null ? "" : this.cnpj;

    data['telefoneMovel'] =
        this.telefoneMovel == null ? "" : this.telefoneMovel;

    data['receitaBruta'] = this.receitaBruta == null ? "" : this.receitaBruta;
    data['idFinanceiro'] = this.idFinanceiro == null ? "" : this.idFinanceiro;
    data['simples'] = this.simples == null ? "" : this.simples;
    data['simplesPorc'] = this.simplesPorc == null ? "" : this.simplesPorc;
    data['icms'] = this.icms == null ? "" : this.icms;
    data['icmsPorc'] = this.icmsPorc == null ? "" : this.icmsPorc;
    data['pis'] = this.pis == null ? "" : this.pis;
    data['pisPorc'] = this.pisPorc == null ? "" : this.pisPorc;
    data['cofins'] = this.cofins == null ? "" : this.cofins;
    data['cofinsPorc'] = this.cofinsPorc == null ? "" : this.cofinsPorc;
    data['receitaLiquida'] =
        this.receitaLiquida == null ? "" : this.receitaLiquida;
    data['observacoes'] = this.observacoes == null ? "" : this.observacoes;
    return data;
  }
}
