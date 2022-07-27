import 'package:realm/realm.dart';
part 'tb_technology.g.dart';

@RealmModel()
class _TbTechnology {
  @PrimaryKey()
  @MapTo('idTechnologyApp')
  late ObjectId idTechnologyApp;
  late String idTechnology;
  late String technology;
}
