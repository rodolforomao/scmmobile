import 'package:realm/realm.dart';
part 'tb_environment_variable.g.dart';


@RealmModel()
class _TbEnvironmntVariable {
  @PrimaryKey()
  @MapTo('idEnvironmntVariableApp')
  late ObjectId idEnvironmntVariableApp;
  late String result;
}
