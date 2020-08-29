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


  //------------------------------------------------------------------------------

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

  //------------------------------------------------------------------------------

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

}