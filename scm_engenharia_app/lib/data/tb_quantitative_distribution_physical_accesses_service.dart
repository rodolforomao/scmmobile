import 'package:realm/realm.dart';
part 'tb_quantitative_distribution_physical_accesses_service.g.dart';


@RealmModel()
class _TbQuantitativeDistributionPhysicalAccessesService {
  @PrimaryKey()
  @MapTo('idApp')
  late ObjectId idApp;
  late String idFichaSiciApp;
  late String id;
  late String cod_ibge;
  late String id_uf;
  late String id_municipio;
  late String id_tecnologia;
  late String pf_0;
  late String pf_512;
  late String pf_2;
  late String pf_12;
  late String pf_34;
  late String pj_0;
  late String pj_512;
  late String pj_2;
  late String pj_12;
  late String pj_34;
  late String id_lancamento;
  late String id_usuario_ultima_alteracao;
  late String municipio;
  late String uf;
  late String tecnologia;
}
