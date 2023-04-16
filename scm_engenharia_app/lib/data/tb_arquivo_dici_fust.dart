import 'package:realm/realm.dart';
part 'tb_arquivo_dici_fust.g.dart';



@RealmModel()
class _TbArquivoDiciFust {
  @PrimaryKey()
  @MapTo('idArquivoDiciFustApp')
  late ObjectId idArquivoDiciFustApp;
  late String idRegistro;
  late String result;
}
