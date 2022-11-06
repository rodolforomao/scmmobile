import 'package:realm/realm.dart';
import 'package:scm_engenharia_app/data/tb_form_sici_fust.dart';
import '../models/operation.dart';
import 'tb_user.dart';

class AppScmEngenhariaMobileBll {

  static late AppScmEngenhariaMobileBll instance = AppScmEngenhariaMobileBll();

  //---------------------------------------------------------------------------------------------------

  late Realm realm;
  AppScmEngenhariaMobileBll() {
    final config = Configuration.local([TbUser.schema ,TbFormSiciFust.schema],schemaVersion: 3);
    realm = Realm(config);
  }


  // User ---------------------------------------------------------------------------------------------

  Future<Operation> onSaveUser(TbUser user) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      TbUser respUser = realm.write<TbUser>(() {
        return realm.add<TbUser>(user);
      });
      operation.result = respUser;
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onUpdateUser(ObjectId idUserApp,TbUser user) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      TbUser? updateUser = realm.find<TbUser>(idUserApp);
      if(!updateUser!.isValid)
      {
        throw ('Não foi possível identificar as informações no seu dispositivo');
      }
      else
        {
          realm.write(() {
            updateUser.idUser = user.idUser;
            updateUser.idProfile = user.idProfile;
            updateUser.name = user.name;
            updateUser.password = user.password;
            updateUser.email = user.email;
            updateUser.telephone = user.telephone;
            updateUser.dtLastAcess = user.dtLastAcess;
            updateUser.company = user.company;
            updateUser.referencePeriod = user.referencePeriod;
            updateUser.cpf = user.cpf;
            updateUser.uf = user.uf;
          });
          TbUser? respUpdate = realm.find<TbUser>(idUserApp);
          if(!updateUser.isValid)
          {
            throw ('Não foi possível identificar as informações no seu dispositivo');
          }
          operation.result = respUpdate;
        }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteUser() async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        realm.deleteAll<TbUser>();
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onSelectUser() async {
    Operation operation = Operation();
    try {
      operation.result = null;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      final accessToken = realm.all<TbUser>();
      if(accessToken.length > 1)
        {
          realm.write(() {
            realm.deleteAll<TbUser>();
          });
          operation.result = null;
          throw ('Todos usuários foram removidos');
        }
      else  if(accessToken.isEmpty)
        {
          operation.result = null;
          operation.message = 'Usuário não logado';
        }
      else
      {
        operation.result = accessToken.first;
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }



  // Form Sici - Fust ---------------------------------------------------------------------------------

  Future<Operation> onSaveFormSiciFust(TbFormSiciFust formSiciFust) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        realm.add<TbFormSiciFust>(formSiciFust);
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onUpdateFormSiciFust(TbFormSiciFust formSiciFust) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        formSiciFust;
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onSelectFormSiciFustIdApp(String idFormSiciFustApp) async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      operacao.erro = false;
      realm.write(() {
        realm.all<TbFormSiciFust>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  Future<Operation> onSelectFormSiciFustIdRecord(String idRecord) async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      operacao.erro = false;
      realm.write(() {
        realm.all<TbFormSiciFust>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  Future<Operation> onSelectFormSiciFustAll() async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      final formSici = realm.all<TbFormSiciFust>().toList();
      if(formSici.isEmpty)
        {
          operation.result = null;
        }
      else
        {
          operation.result = formSici;
        }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteFormSiciFustId(String idFormSiciFust) async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      final formSici = realm.query<TbFormSiciFust>('idFormSiciFustApp == $idFormSiciFust').first;
      realm.write(() {
        realm.delete(formSici);
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

}