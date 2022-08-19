import 'package:realm/realm.dart';
import 'package:scm_engenharia_app/data/tb_form_sici_fust.dart';
import 'package:scm_engenharia_app/data/tb_quantitative_distribution_physical_accesses_service.dart';
import '../models/operation.dart';
import 'tb_user.dart';

class AppScmEngenhariaMobileBll {

  static late AppScmEngenhariaMobileBll instance = AppScmEngenhariaMobileBll();

  //---------------------------------------------------------------------------------------------------

  late Realm realm;
  AppScmEngenhariaMobileBll() {
    final config = Configuration.local([TbUser.schema ,TbFormSiciFust.schema ,TbQuantitativeDistributionPhysicalAccessesService.schema]);
    realm = Realm(config);
  }



  // User ---------------------------------------------------------------------------------------------

  Future<Operation> onSaveUser(TbUser user) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        realm.add<TbUser>(user);
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro ' + ex.toString();
    }
    return operation;
  }

  Future<Operation> onUpdateUser(TbUser user) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        user;
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro ' + ex.toString();
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
      operation.message = ' , erro ' + ex.toString();
    }
    return operation;
  }

  Future<Operation> onSelectUser() async {
    Operation operacao = Operation();
    try {
      operacao.result = null;
      operacao.message = 'Operação realizada com sucesso';
      operacao.erro = false;
      final accessToken = realm.all<TbUser>();
      if(accessToken.length > 1)
        {
          realm.write(() {
            realm.deleteAll<TbUser>();
          });
          operacao.result = null;
          throw ('Todos usuários foram removidos');
        }
      else  if(accessToken.isEmpty)
        {
          operacao.result = null;
          operacao.message = 'Usuário não logado';
        }
      else
      {
        operacao.result = accessToken.first;
      }
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro ' + ex.toString();
    }
    return operacao;
  }



  // Form Sici - Fust ---------------------------------------------------------------------------------

  Future<Operation> onSaveFormSiciFust(TbFormSiciFust formSiciFust,List<TbQuantitativeDistributionPhysicalAccessesService> quantitativeDistributionPhysicalAccessesService) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      int index = 0;
      for (var prop in quantitativeDistributionPhysicalAccessesService) {
        quantitativeDistributionPhysicalAccessesService[index].idFichaSiciApp =formSiciFust.idFichaSiciApp.toString();
        index++;
      }
      realm.write(() {
        realm.add<TbFormSiciFust>(formSiciFust);
        realm.addAll<TbQuantitativeDistributionPhysicalAccessesService>(quantitativeDistributionPhysicalAccessesService);
      });
     // onSaveDistributionQuantitativePhysicalAccessesService(quantitativeDistributionPhysicalAccessesService);
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro ' + ex.toString();
    }
    return operation;
  }

  Future<Operation> onSelectFormSiciFustId(String id) async {
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

  Future<Operation> onSelectAll() async {
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

  Future<Operation> onDeleteFormSiciFustId(TbFormSiciFust formSiciFust) async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.delete(formSiciFust);
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

// DISTRIBUTION OF THE QUANTITATIVE OF PHYSICAL ACCESS IN SERVICE -------------------------------------
  
  Future<Operation> onSaveDistributionQuantitativePhysicalAccessesService(List<TbQuantitativeDistributionPhysicalAccessesService> quantitativeDistributionPhysicalAccessesService) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {

      realm.write(() {
        realm.addAll<TbQuantitativeDistributionPhysicalAccessesService>(quantitativeDistributionPhysicalAccessesService);
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro ' + ex.toString();
    }
    return operation;
  }

  Future<Operation> onSelectDistributionQuantitativePhysicalAccessesServiceByIdSiciFust(int id) async {
    Operation operation = Operation();
    try {
      operation.result = null;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.all<TbQuantitativeDistributionPhysicalAccessesService>().query('idFichaSiciApp == $id');
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteDistributionQuantitativePhysicalAccessesService(int id) async {
    Operation operation = Operation();
    try {
      operation.result = null;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.all<TbQuantitativeDistributionPhysicalAccessesService>().query('idApp == $id');
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onCleanTbDistributionQuantitativePhysicalAccessesService() async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      realm.write(() {
        realm.deleteAll<TbQuantitativeDistributionPhysicalAccessesService>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }
}