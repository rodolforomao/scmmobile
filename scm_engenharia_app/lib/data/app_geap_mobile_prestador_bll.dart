import 'package:realm/realm.dart';
import '../models/operation.dart';
import 'tb_uf_municipality.dart';
import 'tb_user.dart';

class AppGeapMobileEngenhariaBll {

  static late AppGeapMobileEngenhariaBll instance = AppGeapMobileEngenhariaBll();

  //---------------------------------------------------------------------------------------------------
  late Realm realm;
  appGeapMobilePrestadorBll() {
    final config = Configuration.local([TbUser.schema ,TbUfMunicipality.schema]);
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

  Future<Operation> onSaveUpdateTechnology(TbUser user) async {
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

  Future<Operation> onSelectTechnologyAll() async {
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

  Future<Operation> onSelectTechnologyBayId(String Id) async {
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

  Future<Operation> onCleanTbTechnology() async {
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

  Future<Operation> onDeleteTechnologyBayId(String Id) async {
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

  // Uf ----------------------------------------------------------------------------------------------

  Future<Operation> onSaveUpdateUF(TbUser user) async {
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

  Future<Operation> onSelectUFAll() async {
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

  Future<Operation> onSelectUFBayId(String Id) async {
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

  Future<Operation> onCleanTbUF() async {
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

  Future<Operation> onDeleteUFBayId(String Id) async {
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

 // uf Municipality -----------------------------------------------------------------------------------

  Future<Operation> onSaveUpdateMunicipality(TbUser user) async {
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

  Future<Operation> onSelectUfMunicipalityAll() async {
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

  Future<Operation> onSelectUfMunicipalityById(String id) async {
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

  Future<Operation> onSelectUfMunicipalityByIdUf(String ufId) async {
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

  Future<Operation> onCleanTbUfMunicipality() async {
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

  Future<Operation> onDeleteUfMunicipality() async {
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

  // Form Sici - Fust ---------------------------------------------------------------------------------

  Future<Operation> onSaveFormSiciFust(TbUser user) async {
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

  Future<Operation> onSelectFormSiciFustId(String id) async {
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

  Future<Operation> onSelectAll() async {
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

  Future<Operation> onCleanTbFormSiciFust() async {
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

  Future<Operation> onDeleteFormSiciFustId(String Id) async {
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

// DISTRIBUTION OF THE QUANTITATIVE OF PHYSICAL ACCESS IN SERVICE -------------------------------------
  
  Future<Operation> onSaveDistributionQuantitativePhysicalAccessesService(TbUser user) async {
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

  Future<Operation> onSelectDistributionQuantitativePhysicalAccessesServiceByIdSiciFust(int Id) async {
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

  Future<Operation> onDeleteDistributionQuantitativePhysicalAccessesService(int Id) async {
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

  Future<Operation> onCleanTbDistributionQuantitativePhysicalAccessesService() async {
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
}