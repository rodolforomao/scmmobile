import 'package:realm/realm.dart';
part 'tb_uf_municipality.g.dart';

@RealmModel()
class _TbUfMunicipality {
  @PrimaryKey()
  @MapTo('idMunicipalityApp')
  late ObjectId idMunicipalityApp;
  late String idMunicipality;
  late String uf;
  late String id;
  late String municipality;
}


