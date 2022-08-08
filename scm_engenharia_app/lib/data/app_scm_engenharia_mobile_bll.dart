import 'package:realm/realm.dart';
import 'package:scm_engenharia_app/data/tb_form_sici_fust.dart';
import 'package:scm_engenharia_app/data/tb_quantitative_distribution_physical_accesses_service.dart';
import 'package:scm_engenharia_app/data/tb_technology.dart';
import 'package:scm_engenharia_app/data/tb_uf.dart';
import '../models/operation.dart';
import 'tb_uf_municipality.dart';
import 'tb_user.dart';

class AppScmEngenhariaMobileBll {

  static late AppScmEngenhariaMobileBll instance = AppScmEngenhariaMobileBll();

  //---------------------------------------------------------------------------------------------------

  late Realm realm;
  AppScmEngenhariaMobileBll() {
    final config = Configuration.local([TbUser.schema ,TbUfMunicipality.schema]);
    realm = Realm(config);
  }

  Future<Operation> onThereisAnEnvironmentVariable() async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {

      final tbUf = realm.all<TbUf>();
      final tbUfMunicipality = realm.all<TbUfMunicipality>();
      final tbTechnology = realm.all<TbTechnology>();
      if(tbUf.isEmpty)
      {
        throw ('Não a uf cadastrados');
      }
      if(tbUfMunicipality.isEmpty)
      {
        throw ('Não a municípios cadastrados');
      }
      if(tbTechnology.isEmpty)
      {
        throw ('Não a tecnologias cadastrados');
      }
      operation.result = false;
    } catch (ex) {
      operation.erro = true;
      operation.result = true;
      operation.message = ' , erro ' + ex.toString();
    }
    return operation;
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

 //----------------------------------------------------------------------------------------------------

  // Technology ---------------------------------------------------------------------------------------

  Future<Operation> onSaveUpdateTechnology(TbTechnology technology) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        realm.add<TbTechnology>(technology);
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro ' + ex.toString();
    }
    return operation;
  }

  Future<Operation> onSelectTechnologyAll() async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      operacao.erro = false;
      realm.write(() {
        realm.all<TbTechnology>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  Future<Operation> onSelectTechnologyBayId(String id) async {
    Operation operation = Operation();
    try {
      operation.result = null;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.all<TbTechnology>().query('idTechnologyApp == $id');
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteAllTechnology() async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      realm.write(() {
        realm.deleteAll<TbTechnology>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  Future<Operation> onDeleteTechnologyBayId(TbTechnology technology) async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      realm.write(() {
        realm.delete(technology);
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  // Uf ----------------------------------------------------------------------------------------------

  Future<Operation> onSaveUpdateUF(TbUf uf) async {
    Operation operation = Operation();
    operation.result = null;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        realm.add<TbUf>(uf);
      });
      operation.result = true;
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onSelectUFAll() async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      operacao.erro = false;
      realm.write(() {
        realm.all<TbUf>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  Future<Operation> onSelectUFBayId(String id) async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.all<TbUf>().query('idUfApp == $id');
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteAllUF() async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      operacao.erro = false;
      realm.write(() {
        realm.deleteAll<TbUf>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  Future<Operation> onDeleteUFBayId(TbUf uf) async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      realm.write(() {
        realm.delete(uf);
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

 // uf Municipality -----------------------------------------------------------------------------------

  Future<Operation> onSaveUpdateMunicipality(TbUfMunicipality municipality) async {
    Operation operation = Operation();
    operation.result = true;
    operation.message = 'Operação realizada com sucesso';
    operation.erro = false;
    try {
      realm.write(() {
        realm.add<TbUfMunicipality>(municipality);
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onSelectUfMunicipalityAll() async {
    Operation operacao = Operation();
    try {
      operacao.result = true;
      operacao.message = 'Operação realizada com sucesso';
      operacao.erro = false;
      realm.write(() {
        realm.all<TbUfMunicipality>();
      });
    } catch (ex) {
      operacao.erro = true;
      operacao.message = ' , erro $ex';
    }
    return operacao;
  }

  Future<Operation> onSelectUfMunicipalityById(String id) async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.all<TbUfMunicipality>().query('idMunicipalityApp == $id');
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onSelectUfMunicipalityByIdUf(String ufId) async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.all<TbUfMunicipality>().query('id == $ufId');
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteUfMunicipalityAll() async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.deleteAll<TbUfMunicipality>();
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
  }

  Future<Operation> onDeleteUfMunicipality(TbUfMunicipality municipality) async {
    Operation operation = Operation();
    try {
      operation.result = true;
      operation.message = 'Operação realizada com sucesso';
      operation.erro = false;
      realm.write(() {
        realm.delete(municipality);
      });
    } catch (ex) {
      operation.erro = true;
      operation.message = ' , erro $ex';
    }
    return operation;
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