import 'package:scm_engenharia_app/data/tb_tecnologia.dart';
import 'package:scm_engenharia_app/data/tb_uf.dart';
import 'package:scm_engenharia_app/data/tb_uf_municipio.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'scmSici.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE tbUsuario (idUsuarioApp INTEGER PRIMARY KEY AUTOINCREMENT,idUsuario TEXT , idPerfil TEXT , nome TEXT, senha TEXT, email TEXT, telefone TEXT, dtUltacesso TEXT, empresa TEXT, periodoReferencia TEXT, cpf TEXT)');
    await db.execute('CREATE TABLE tbTecnologia (idTecnologiaApp INTEGER PRIMARY KEY AUTOINCREMENT, id TEXT , tecnologia TEXT)');
    await db.execute('CREATE TABLE tbUf (idUfApp INTEGER PRIMARY KEY AUTOINCREMENT,id TEXT,uf TEXT)');
    await db.execute('CREATE TABLE tbUfMunicipio (idMunicipioApp INTEGER PRIMARY KEY AUTOINCREMENT,ufId TEXT , uf TEXT,id TEXT,municipio TEXT)');
  }

  Future<Operacao> limparTabelas(int idUsuario) async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var resultNotificacoes = await dbClient.delete(
        'tbNotificacaoVeiculo',
        where: 'idUsuario = ?',
        whereArgs: [idUsuario],
      );
      var resultRegistroNotificacao= await dbClient.delete(
        'tbRegistroNotificacao',
        where: 'idUsuario = ?',
        whereArgs: [idUsuario],
      );
      _Operacao.erro = false;
      _Operacao.mensagem = "Dados removidos com sucesso";
      _Operacao.resultado = true;
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }


  // Usuário ------------------------------------------------------------------------------

  Future<Operacao> OnAddUpdateUsuario(TbUsuario Usuario) async {
    Operacao _Operacao = new Operacao();
    try {

      var dbClient = await db;
      if (Usuario.idUsuarioApp == 0 || Usuario.idUsuarioApp == null)
        Usuario.idUsuarioApp = await dbClient.insert('tbUsuario', Usuario.toJson());
      else {
        int id = await dbClient.update(
          'tbUsuario',
          Usuario.toJson(),
          where: 'idUsuarioApp = ?',
          whereArgs: [Usuario.idUsuarioApp],
        );
        Usuario.idUsuarioApp = id;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário adicionado com sucesso.";
      _Operacao.resultado = Usuario;
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarUsuario() async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbUsuario');
      List<TbUsuario> listUsuario = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUsuario.add(TbUsuario.fromJson(results[i]));
        }
      }
      if (listUsuario.length > 1) {
        for (final i in listUsuario) {
          var resp = await dbClient.delete(
            'tbUsuario',
            where: 'idUsuarioApp = ?',
            whereArgs: [i.idUsuarioApp],
          );
        }
        throw ("Usuários foram removidos.");
      } else if (listUsuario.length == 0) {
        _Operacao.resultado = null;
      } else {
        //_Operacao.resultado = null;
        //_Operacao.erro = true;
        _Operacao.resultado = listUsuario.first;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário obtido com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarUsuario() async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbUsuario');
      List<TbUsuario> listUsuario = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUsuario.add(TbUsuario.fromJson(results[i]));
        }
      }
      if (listUsuario.length > 0) {
        for (final i in listUsuario) {
          var resp = await dbClient.delete(
            'tbUsuario',
            where: 'idUsuarioApp = ?',
            whereArgs: [i.idUsuarioApp],
          );
        }
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário foi removido com sucesso";
      _Operacao.resultado = "Usuário foi removido com sucesso";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  //---------------------------------------------------------------------------------------


  // Tecnologia ---------------------------------------------------------------------------

  Future<Operacao> OnAddUpdateTecnologia(TbTecnologia Tecnologia) async {
    Operacao _Operacao = new Operacao();
    try {

      var dbClient = await db;
      if (Tecnologia.idTecnologiaApp == 0 || Tecnologia.idTecnologiaApp == null)
       {
         Tecnologia.idTecnologiaApp = null;
         Tecnologia.idTecnologiaApp = await dbClient.insert('tbTecnologia', Tecnologia.toJson());
       }
      else {
        int id = await dbClient.update(
          'tbUsuario',
          Tecnologia.toJson(),
          where: 'idTecnologiaApp = ?',
          whereArgs: [Tecnologia.idTecnologiaApp],
        );
        Tecnologia.idTecnologiaApp = id;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário adicionado com sucesso.";
      _Operacao.resultado = Tecnologia;
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarTecnologia() async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbTecnologia');
      List<TbTecnologia> listTecnologia = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listTecnologia.add(TbTecnologia.fromJson(results[i]));
        }
        _Operacao.resultado = listTecnologia;
      }
      else
        _Operacao.resultado = null;
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário obtido com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarTecnologia() async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbTecnologia');
      List<TbTecnologia> listTecnologia = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listTecnologia.add(TbTecnologia.fromJson(results[i]));
        }
      }
      if (listTecnologia.length > 0) {
        for (final i in listTecnologia) {
          var resp = await dbClient.delete(
            'tbTecnologia',
            where: 'idTecnologiaApp = ?',
            whereArgs: [i.idTecnologiaApp],
          );
        }
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário foi removido com sucesso";
      _Operacao.resultado = "Usuário foi removido com sucesso";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletar(int idTecnologiaApp) async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var resp = await dbClient.delete(
        'tbTecnologia',
        where: 'idTecnologiaApp = ?',
        whereArgs: [idTecnologiaApp],
      );
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário foi removido com sucesso";
      _Operacao.resultado = "Usuário foi removido com sucesso";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  //---------------------------------------------------------------------------------------


  // Uf -----------------------------------------------------------------------------------

  Future<Operacao> OnAddUpdateUf(TbUf Uf) async {
    Operacao _Operacao = new Operacao();
    try {

      var dbClient = await db;
      if (Uf.idUfApp == 0 || Uf.idUfApp == null)
      {
        Uf.idUfApp = null;
        Uf.idUfApp = await dbClient.insert('tbUf', Uf.toJson());
      }
      else {
        int id = await dbClient.update(
          'tbUf',
          Uf.toJson(),
          where: 'tbUf = ?',
          whereArgs: [Uf.idUfApp],
        );
        Uf.idUfApp = id;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário adicionado com sucesso.";
      _Operacao.resultado = Uf;
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarUf() async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbUf');
      List<TbUf> listUf = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUf.add(TbUf.fromJson(results[i]));
        }
        _Operacao.resultado = listUf;
      }
      else
        _Operacao.resultado = null;
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário obtido com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarUfs() async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbUf');
      List<TbUf> listUf = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUf.add(TbUf.fromJson(results[i]));
        }
      }
      if (listUf.length > 0) {
        for (final i in listUf) {
          var resp = await dbClient.delete(
            'tbUf',
            where: 'idUfApp = ?',
            whereArgs: [i.idUfApp],
          );
        }
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário foi removido com sucesso";
      _Operacao.resultado = "Usuário foi removido com sucesso";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarUf(int idUfApp) async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var resp = await dbClient.delete(
        'tbUf',
        where: 'idUfApp = ?',
        whereArgs: [idUfApp],
      );
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário foi removido com sucesso";
      _Operacao.resultado = "Usuário foi removido com sucesso";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }


  //---------------------------------------------------------------------------------------

  // uf município -------------------------------------------------------------------------


  Future<Operacao> OnAddUpdateUfMunicipio(TbUfMunicipio UfMunicipio) async {
    Operacao _Operacao = new Operacao();
    try {

      var dbClient = await db;
      if (UfMunicipio.idMunicipioApp == 0 || UfMunicipio.idMunicipioApp == null)
      {
        UfMunicipio.idMunicipioApp = null;
        UfMunicipio.idMunicipioApp = await dbClient.insert('tbUfMunicipio', UfMunicipio.toJson());
      }
      else {
        int id = await dbClient.update(
          'tbUfMunicipio',
          UfMunicipio.toJson(),
          where: 'idMunicipioApp = ?',
          whereArgs: [UfMunicipio.idMunicipioApp],
        );
        UfMunicipio.idMunicipioApp = id;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário adicionado com sucesso.";
      _Operacao.resultado = UfMunicipio;
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarUfMunicipio() async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbUfMunicipio');
      List<TbUfMunicipio> listUfMunicipio = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUfMunicipio.add(TbUfMunicipio.fromJson(results[i]));
        }
        _Operacao.resultado = listUfMunicipio;
      }
      else
        _Operacao.resultado = null;
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário obtido com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarMunicipioByIdUf(String Id) async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbUfMunicipio WHERE ufId = ' + Id;
      var results = await dbClient.rawQuery(Query);
      List<TbUfMunicipio> listUfMunicipio = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUfMunicipio.add(TbUfMunicipio.fromJson(results[i]));
        }
        _Operacao.resultado = listUfMunicipio;
      }
      else
        _Operacao.resultado = null;
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário obtido com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarUfMunicipios() async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var results = await dbClient.rawQuery('SELECT * FROM tbUfMunicipio');
      List<TbUfMunicipio> listUfMunicipio = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUfMunicipio.add(TbUfMunicipio.fromJson(results[i]));
        }
      }
      if (listUfMunicipio.length > 0) {
        for (final i in listUfMunicipio) {
          var resp = await dbClient.delete(
            'tbUfMunicipio',
            where: 'idMunicipioApp = ?',
            whereArgs: [i.idMunicipioApp],
          );
        }
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário foi removido com sucesso";
      _Operacao.resultado = "Usuário foi removido com sucesso";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarUfMunicipio(int idMunicipioApp) async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var resp = await dbClient.delete(
        'tbUfMunicipio',
        where: 'idMunicipioApp = ?',
        whereArgs: [idMunicipioApp],
      );
      _Operacao.erro = false;
      _Operacao.mensagem = "Usuário foi removido com sucesso";
      _Operacao.resultado = "Usuário foi removido com sucesso";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  //---------------------------------------------------------------------------------------


  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

}