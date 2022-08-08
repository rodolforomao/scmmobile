import 'package:realm/realm.dart';
part 'tb_user.g.dart';

@RealmModel()
class _TbUser {
  @PrimaryKey()
  @MapTo('idUserApp')
  late ObjectId idUserApp;
  late String idUser;
  late String idProfile;
  late String name;
  late String password;
  late String email;
  late String telephone;
  late String dtLastAcess;
  late String company;
  late String referencePeriod;
  late String cpf;
  late String uf;
}


