import 'package:realm/realm.dart';
import 'package:scm_engenharia_app/data/tb_arquivo_dici_fust.dart';
import 'package:scm_engenharia_app/data/tb_environment_variable.dart';
import 'package:scm_engenharia_app/data/tb_form_sici_fust.dart';
import '../models/operation.dart';
import 'tb_user.dart';


class AppScmEngenhariaMobileBll {

  static  AppScmEngenhariaMobileBll instance = AppScmEngenhariaMobileBll();

  //---------------------------------------------------------------------------------------------------

  late Realm realm;
  late Configuration config;
  AppScmEngenhariaMobileBll() {
    try {
      config = Configuration.local([TbUser.schema ,TbFormSiciFust.schema,TbEnvironmntVariable.schema,TbArquivoDiciFust.schema],schemaVersion: 1);
      realm = Realm(config);
    } catch (ex) {
      Realm.deleteRealm(config.path);
      throw ('Não foi possível identificar as informações no seu dispositivo corretamente.\r\n\r\n Feche o aplicativo e tente novamente');
    }
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
        realm.deleteAll<TbFormSiciFust>();
        realm.deleteAll<TbEnvironmntVariable>();
        realm.deleteAll<TbArquivoDiciFust>();
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

      if(realm.all<TbFormSiciFust>().where((element) => element.idRegistro == formSiciFust.idRegistro).isEmpty)
      {
        throw ('O registro já está salvo no dispositivo');
      }
      else
      {
        TbFormSiciFust authorizationSso = realm.write<TbFormSiciFust>(() {
          return realm.add<TbFormSiciFust>(formSiciFust);
        });
        operation.result = authorizationSso;
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onSaveUpdateFormSiciFust(String idFormSiciFust , TbFormSiciFust formSiciFust) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      if(idFormSiciFust.isEmpty)
      {
        TbFormSiciFust resp = realm.write<TbFormSiciFust>(() {
          return  realm.add<TbFormSiciFust>(formSiciFust);
        });
        operation.result = resp;
      }
      else
      {
        TbFormSiciFust? updateFormSiciFust = realm.find<TbFormSiciFust>(ObjectId.fromHexString(idFormSiciFust));
        if(updateFormSiciFust!.result.isEmpty)
        {
          throw ('Não foi possível identificar as informações no seu dispositivo');
        }
        realm.write(() {
          updateFormSiciFust.idRegistro = formSiciFust.idRegistro;
          updateFormSiciFust.result = formSiciFust.result;
        });
        operation.result = updateFormSiciFust;
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = ex.toString();
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
      ObjectId id =   ObjectId.fromHexString(idFormSiciFust);
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      final formSici = realm.find<TbFormSiciFust>(id);
      //final formSici  = realm.all<TbFormSiciFust>().firstWhereOrNull((element) => element.idFormSiciFustApp == ObjectId.fromHexString(idFormSiciFust));
      if(formSici != null)
      {
        realm.write(() {
          realm.delete(formSici);
        });
        operation.result = true;
      }
      else
      {
        throw ('Não foi possivel identificar o formulário');
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

 // Variável ambiente ----------------------------------------------------------------------------------

  Future<Operation> onSaveUpdateEnvironmentVariable(TbEnvironmntVariable environmntVariable) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      var updateFormSiciFust = realm.find<TbEnvironmntVariable>(environmntVariable.idEnvironmntVariableApp);
      if(updateFormSiciFust == null)
      {
        TbEnvironmntVariable resp = realm.write<TbEnvironmntVariable>(() {
          return  realm.add<TbEnvironmntVariable>(environmntVariable);
        });
        operation.result = resp;
      }
      else
      {
        realm.write(() {
          updateFormSiciFust.result = environmntVariable.result;
        });
        operation.result = updateFormSiciFust;
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = ex.toString();
    }
    return operation;
  }

  Future<Operation> onSelectEnvironmentVariableAll() async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      final formSici = realm.all<TbEnvironmntVariable>().toList();
      if(formSici.isEmpty)
      {
        operation.result = null;
        operation.message = 'Não existe variável de ambiente neste dispositivo';
      }
      else if(formSici.length > 1)
      {
        realm.write(() {
          realm.deleteAll<TbEnvironmntVariable>();
        });
        operation.result = null;
        operation.message = 'Não existe variável de ambiente neste dispositivo';
      }
      else
      {
        operation.message = 'Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.';
        operation.result = formSici.first;
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onEnvironmentVariableDeleteAll() async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.deleteAll<TbEnvironmntVariable>;
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

 // Arquivo ----------------------------------------------------------------------------------

  Future<Operation> onSaveArquivoDiciFust(ObjectId id ,String mapFile) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      final formSici = realm.all<TbArquivoDiciFust>().toList();
      if(realm.all<TbArquivoDiciFust>().where((element) => element.idRegistro == id.toString()).isNotEmpty)
      {
        throw ('O registro já está salvo no dispositivo');
      }
      else
        {
          TbArquivoDiciFust arquivoDiciFust = TbArquivoDiciFust(
              id,
              id.toString(),
              mapFile
          );
          TbArquivoDiciFust resp = realm.write<TbArquivoDiciFust>(() {
            return  realm.add<TbArquivoDiciFust>(arquivoDiciFust);
          });
          operation.result = resp;
        }
    } catch (ex) {
      operation.erro = true;
      operation.message = ex.toString();
    }
    return operation;
  }

  Future<Operation> onSelectArquivoDiciFustAll() async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      final formDici = realm.all<TbArquivoDiciFust>().toList();
      if(formDici.isEmpty)
      {
        operation.result = null;
        operation.message = 'Não existe variável de ambiente neste dispositivo';
      }
      else if(formDici.length > 1)
      {
        realm.write(() {
          realm.deleteAll<TbArquivoDiciFust>();
        });
        operation.result = null;
        operation.message = 'Não existe variável de ambiente neste dispositivo';
      }
      else
      {
        operation.message = 'Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.';
        operation.result = formDici.first;
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteDiciFust(String idArquivoDiciFustApp) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {

      if (idArquivoDiciFustApp.isEmpty || idArquivoDiciFustApp == null) {
        throw ('Não foi possivel identificar o formulário');
      }
      ObjectId id =   ObjectId.fromHexString(idArquivoDiciFustApp);
      final formSici = realm.find<TbArquivoDiciFust>(id);
      if(formSici != null)
      {
        realm.write(() {
          realm.delete(formSici);
        });
        realm.refresh();
        operation.result = true;
      }
      else
      {
        throw ('Não foi possivel identificar o formulário');
      }
    } catch (ex) {
      operation.erro = true;
      operation.message = 'Erro $ex';
    }
    return operation;
  }

  Future<Operation> onArquivoDiciFustAll() async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      final formSici = realm.all<TbArquivoDiciFust>().toList();
      if(formSici.isEmpty)
      {
        operation.result = null;
        operation.message = 'Não existe documentos salvos';
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

}