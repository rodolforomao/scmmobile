import 'package:realm/realm.dart';
part 'tb_form_sici_fust.g.dart';


@RealmModel()
class _TbFormSiciFust {
  @PrimaryKey()
  @MapTo('idFormSiciFustApp')
  late ObjectId idFormSiciFustApp;
  late String idRegistro;
  late String result;
}
