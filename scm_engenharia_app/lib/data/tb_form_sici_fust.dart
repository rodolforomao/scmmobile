import 'package:realm/realm.dart';
part 'tb_form_sici_fust.g.dart';


@RealmModel()
class _TbFormSiciFust {
  @PrimaryKey()
  @MapTo('idQuantitativeDistributionPhysicalAccessesServiceApp')
  late ObjectId idQuantitativeDistributionPhysicalAccessesServiceApp;
  late String idEmpresa;
  late String isSincronizar;
  late String idLancamento;
  late String periodoReferencia;
  late String razaoSocial;
  late String telefoneFixo;
  late String cnpj;
  late String telefoneMovel;
  late String receitaBruta;
  late String idFinanceiro;
  late String simples;
  late String simplesPorc;
  late String icms;
  late String icmsPorc;
  late String pis;
  late String pisPorc;
  late String cofins;
  late String cofinsPorc;
  late String receitaLiquida;
  late String observacoes;
}
