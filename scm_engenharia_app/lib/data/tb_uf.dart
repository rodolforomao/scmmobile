import 'package:realm/realm.dart';
part 'tb_uf.g.dart';

@RealmModel()
class _TbUf {
  @PrimaryKey()
  @MapTo('idUfApp')
  late ObjectId idUfApp;
  late String id;
  late String uf;
}


