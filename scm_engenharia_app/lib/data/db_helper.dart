import 'package:scm_engenharia_app/data/tb_distribuicao_quantitativo_acessos_fisicos_servico.dart';
import 'package:scm_engenharia_app/data/tb_ficha_sici.dart';
import 'package:scm_engenharia_app/data/tb_tecnologia.dart';
import 'package:scm_engenharia_app/data/tb_uf.dart';
import 'package:scm_engenharia_app/data/tb_uf_municipio.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
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
    await db.execute('CREATE TABLE tbDistribuicaoQuantitativoAcessosFisicosServico (idDistribuicaoQuantitativoAcessosFisicosServicoApp INTEGER PRIMARY KEY AUTOINCREMENT,idFichaSiciApp NUMERIC,id TEXT ,cod_ibge TEXT,id_uf TEXT,id_municipio TEXT,id_tecnologia TEXT,pf_0 TEXT,pf_512 TEXT,pf_2 TEXT,pf_12 TEXT,pf_34 TEXT,pj_0 TEXT,pj_512 TEXT,pj_2 TEXT,pj_12 TEXT,pj_34 TEXT,id_lancamento TEXT,ultima_alteracao TEXT,id_usuario_ultima_alteracao TEXT,municipio TEXT,uf TEXT,tecnologia TEXT)');
    await db.execute('CREATE TABLE tbFichaSici (idFichaSiciApp INTEGER PRIMARY KEY AUTOINCREMENT,isSincronizar TEXT, idEmpresa TEXT,idLancamento TEXT ,periodoReferencia TEXT,razaoSocial TEXT,nomeCliente TEXT,nomeConsultor TEXT,telefoneFixo TEXT,cnpj TEXT,mesReferencia TEXT,telefoneMovel TEXT,emailCliente TEXT,emailConsutor TEXT,receitaBruta TEXT,idFinanceiro TEXT,simples TEXT,simplesPorc TEXT,icms TEXT,icmsPorc TEXT,pis TEXT,pisPorc TEXT,cofins TEXT,cofinsPorc TEXT,receitaLiquida TEXT,observacoes TEXT)');
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

  Future<Operacao> OnExisteVariavelDeAmbiente() async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.resultado = false;
      _Operacao.mensagem = "";


      Operacao _Uf = await onSelecionarUf();
      if (_Uf.erro)
        throw (_Uf.mensagem);
      else if (_Uf.resultado == null) {
        _Operacao.resultado = true;
      }
      Operacao _Tecnologia = await onSelecionarTecnologia();
      if (_Tecnologia.erro)
        throw (_Tecnologia.mensagem);
      else if (_Tecnologia.resultado == null) {
        _Operacao.resultado = true;
      }
      Operacao _SelecionarUf = await onSelecionarUfMunicipio();
      if (_SelecionarUf.erro)
        throw (_SelecionarUf.mensagem);
      else if (_SelecionarUf.resultado == null) {
        _Operacao.resultado = true;
      }
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
      int _Resp = 0;
      if (listUsuario.length > 0) {
        for (final i in listUsuario) {
          var resp = await dbClient.delete(
            'tbUsuario',
            where: 'idUsuarioApp = ?',
            whereArgs: [i.idUsuarioApp],
          );
          _Resp = resp;
        }
      }
      if(_Resp == 1)
        {
          _Operacao.erro = false;
          _Operacao.mensagem = "Usuário foi removido com sucesso";
          _Operacao.resultado = "Usuário foi removido com sucesso";
        }
      else{
        throw ("Houve uma inconsistência ao remover usuário");
      }

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
      Operacao _Tecnologia = await onSelecionarTecnologiaBayId(Tecnologia.id);
      if (_Tecnologia.erro)
        throw (_Tecnologia.mensagem);
      else if (_Tecnologia.resultado == null)
      {
        if (Tecnologia.idTecnologiaApp == 0)
        {
          Tecnologia.idTecnologiaApp = null;
          Tecnologia.idTecnologiaApp = await dbClient.insert('tbTecnologia', Tecnologia.toJson());
        }
      }
      else
        {
          int idTecnologiaApp = Tecnologia.idTecnologiaApp;
          Tecnologia = _Tecnologia.resultado as TbTecnologia;
          Tecnologia.idTecnologiaApp = idTecnologiaApp;
          int id = await dbClient.update(
            'tbTecnologia',
            Tecnologia.toJson(),
            where: 'idTecnologiaApp = ?',
            whereArgs: [Tecnologia.idTecnologiaApp],
          );
          Tecnologia.idTecnologiaApp = id;
        }
      _Operacao.erro = false;
      _Operacao.mensagem = "Tecnologia adicionada com sucesso.";
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
      _Operacao.mensagem = "Lista de tecnologias obtida com sucesso .";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarTecnologiaBayId(String Id) async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbTecnologia WHERE id = ' + Id;
      var results = await dbClient.rawQuery(Query);
      List<TbTecnologia> listTecnologia = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listTecnologia.add(TbTecnologia.fromJson(results[i]));
        }
      }
      else if (listTecnologia.length > 1) {
        for (final i in listTecnologia) {
          var resp = await dbClient.delete(
            'tbTecnologia',
            where: 'idTecnologiaApp = ?',
            whereArgs: [i.idTecnologiaApp],
          );
        }
        throw ("Houve inconsistência .");
      } else if (listTecnologia.length == 0) {
        _Operacao.resultado = null;
      } else {
        _Operacao.resultado = listTecnologia.first;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnLimparTbTecnologia() async {
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
      _Operacao.mensagem = "Todas as tecnologias foram removidos com sucesso";
      _Operacao.resultado = "Todas as tecnologias foram removidos com sucesso";
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = "Operação realizada com sucesso.";
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
      Operacao _Uf = await onSelecionarUfBayId(Uf.id);
      if (_Uf.erro)
        throw (_Uf.mensagem);
      else if (_Uf.resultado == null)
        {
          if (Uf.idUfApp == 0)
          {
            Uf.idUfApp = null;
            Uf.idUfApp = await dbClient.insert('tbUf', Uf.toJson());
          }
        }
      else
        {
          int idUfApp = Uf.idUfApp;
          Uf = _Uf.resultado as TbUf;
          Uf.idUfApp = idUfApp;
          int id = await dbClient.update(
            'tbUf',
            Uf.toJson(),
            where: 'idUfApp = ?',
            whereArgs: [Uf.idUfApp],
          );
          Uf.idUfApp = id;
        }
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
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
      _Operacao.mensagem = "Operação realizada com sucesso..";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarUfBayId(String Id) async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbUf WHERE id = ' + Id;
      var results = await dbClient.rawQuery(Query);
      List<TbUf> listUfs = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listUfs.add(TbUf.fromJson(results[i]));
        }
      }
      else if (listUfs.length > 1) {
        for (final i in listUfs) {
          var resp = await dbClient.delete(
            'tbUf',
            where: 'idUfApp = ?',
            whereArgs: [i.idUfApp],
          );
        }
        throw ("Houve inconsistência .");
      } else if (listUfs.length == 0) {
        _Operacao.resultado = null;
      } else {
        _Operacao.resultado = listUfs.first;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnLimparTbUfs() async {
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = "Operação realizada com sucesso.";
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = "Operação realizada com sucesso.";
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
      Operacao _UfMunicipio = await onSelecionarMunicipioById(UfMunicipio.id);
      if (_UfMunicipio.erro)
        throw (_UfMunicipio.mensagem);
      else if (_UfMunicipio.resultado == null)
        {
          if (UfMunicipio.idMunicipioApp == 0)
          {
            UfMunicipio.idMunicipioApp = null;
            UfMunicipio.idMunicipioApp = await dbClient.insert('tbUfMunicipio', UfMunicipio.toJson());
          }
      }
      else
        {
          int idMunicipioApp = UfMunicipio.idMunicipioApp;
          UfMunicipio = _UfMunicipio.resultado as TbUfMunicipio;
          UfMunicipio.idMunicipioApp = idMunicipioApp;
          int id = await dbClient.update(
            'tbUfMunicipio',
            UfMunicipio.toJson(),
            where: 'idMunicipioApp = ?',
            whereArgs: [UfMunicipio.idMunicipioApp],
          );
          UfMunicipio.idMunicipioApp = id;
        }
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarMunicipioById(String Id) async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbUfMunicipio WHERE id = ' + Id;
      var results = await dbClient.rawQuery(Query);
      List<TbUfMunicipio> listMunicipio = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listMunicipio.add(TbUfMunicipio.fromJson(results[i]));
        }
      }
      else if (listMunicipio.length > 1) {
        for (final i in listMunicipio) {
          var resp = await dbClient.delete(
            'tbUfMunicipio',
            where: 'idMunicipioApp = ?',
            whereArgs: [i.idMunicipioApp],
          );
        }
        throw ("Houve inconsistência .");
      } else if (listMunicipio.length == 0) {
        _Operacao.resultado = null;
      } else {
        _Operacao.resultado = listMunicipio.first;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarMunicipioByIdUf(String ufId) async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbUfMunicipio WHERE ufId = ' + ufId;
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnLimparTbUfMunicipios() async {
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = "Operação realizada com sucesso.";
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  //---------------------------------------------------------------------------------------


  // Formulário Sici - Fust ---------------------------------------------------------------------------

  Future<Operacao> OnAddFichaSici(TbFichaSici _Modelo) async {
    Operacao _Operacao = new Operacao();
    try {
      var dbClient = await db;
      if (_Modelo.idFichaSiciApp == 0 || _Modelo.idFichaSiciApp == null)
      {
        _Modelo.idFichaSiciApp = null;
        _Modelo.isSincronizar = "S";
        _Modelo.idFichaSiciApp = await dbClient.insert('tbFichaSici', _Modelo.toJson());
      }
      else {
        int id = await dbClient.update(
          'tbFichaSici',
          _Modelo.toJson(),
          where: 'idFichaSiciApp = ?',
          whereArgs: [_Modelo.idFichaSiciApp],
        );
        _Modelo.idFichaSiciApp = id;
      }
      for (var prop in _Modelo.distribuicaoFisicosServicoQuantitativo) {
        prop.idFichaSiciApp = _Modelo.idFichaSiciApp;
        Operacao _respLocal = await OnAddDistribuicaoQuantitativoAcessosFisicosServico(prop);
        if (_respLocal.erro)
          throw (_respLocal.mensagem);
        else {

        }
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = _Modelo;
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarFichaSiciId(String Id) async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbFichaSici WHERE idFichaSiciApp = ' + Id;
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
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarFichaSici() async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbFichaSici';
      var results = await dbClient.rawQuery(Query);
      List<TbFichaSici> listFichaSici = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listFichaSici.add(TbFichaSici.fromJson(results[i]));
          Operacao _FichaSiciLocal = await onSelecionarDistribuicaoQuantitativoAcessosFisicosServicoByIdFichaSiciApp(listFichaSici[i].idFichaSiciApp);
          if (_FichaSiciLocal.erro)
            throw (_FichaSiciLocal.mensagem);
          else if (_FichaSiciLocal.resultado != null) {
            List<TbDistribuicaoQuantitativoAcessosFisicosServico>resp = _FichaSiciLocal.resultado;
            listFichaSici[i].distribuicaoFisicosServicoQuantitativo = resp;
          }

        }
        _Operacao.resultado = listFichaSici;
      }
      else
        _Operacao.resultado = null;
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarFichaSici(int idFichaSiciApp) async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var resp = await dbClient.delete(
        'tbFichaSici',
        where: 'idFichaSiciApp = ?',
        whereArgs: [idFichaSiciApp],
      );
      if(resp == 0)
        {
          _Operacao.erro = true;
          _Operacao.mensagem = "Erro não identificado.";
          _Operacao.resultado = "Erro não identificado.";
        }
      else
        {
          _Operacao.erro = false;
          _Operacao.mensagem = "Operação realizada com sucesso.";
          _Operacao.resultado = "Operação realizada com sucesso.";
        }

    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  //---------------------------------------------------------------------------------------


  // DISTRIBUIÇÃO DO QUANTITATIVO DE ACESSOS FÍSICOS EM SERVIÇO ---------------------------------------------------------------------------

  Future<Operacao> OnAddDistribuicaoQuantitativoAcessosFisicosServico(TbDistribuicaoQuantitativoAcessosFisicosServico _Modelo) async {
    Operacao _Operacao = new Operacao();
    try {

      var dbClient = await db;
      if (_Modelo.idDistribuicaoQuantitativoAcessosFisicosServicoApp == 0 || _Modelo.idDistribuicaoQuantitativoAcessosFisicosServicoApp == null)
      {
        _Modelo.idDistribuicaoQuantitativoAcessosFisicosServicoApp = null;
        _Modelo.idDistribuicaoQuantitativoAcessosFisicosServicoApp = await dbClient.insert('tbDistribuicaoQuantitativoAcessosFisicosServico', _Modelo.toJson());
      }
      else {
        int id = await dbClient.update(
          'tbDistribuicaoQuantitativoAcessosFisicosServico',
          _Modelo.toJson(),
          where: 'idDistribuicaoQuantitativoAcessosFisicosServicoApp = ?',
          whereArgs: [_Modelo.idDistribuicaoQuantitativoAcessosFisicosServicoApp],
        );
        _Modelo.idDistribuicaoQuantitativoAcessosFisicosServicoApp = id;
      }
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = _Modelo;
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> onSelecionarDistribuicaoQuantitativoAcessosFisicosServicoByIdFichaSiciApp(int Id) async {
    Operacao _Operacao = new Operacao();
    try {
      _Operacao.erro = false;
      _Operacao.mensagem = "";
      _Operacao.resultado = null;
      final dbClient = await db;
      String Query = 'SELECT * FROM tbDistribuicaoQuantitativoAcessosFisicosServico WHERE idFichaSiciApp = ' + Id.toString();
      var results = await dbClient.rawQuery(Query);
      List<TbDistribuicaoQuantitativoAcessosFisicosServico> listDistribuicaoQuantitativoAcessosFisicosServico = [];
      if (results.length > 0) {
        for (int i = 0; i < results.length; i++) {
          listDistribuicaoQuantitativoAcessosFisicosServico.add(TbDistribuicaoQuantitativoAcessosFisicosServico.fromJson(results[i]));
        }
        _Operacao.resultado = listDistribuicaoQuantitativoAcessosFisicosServico;
      }
      else
        _Operacao.resultado = null;
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnDeletarDistribuicaoQuantitativoAcessosFisicosServico(int idDistribuicaoQuantitativoAcessosFisicosServicoApp) async {
    Operacao _Operacao = new Operacao();
    try {
      final dbClient = await db;
      var resp = await dbClient.delete(
        'tbDistribuicaoQuantitativoAcessosFisicosServico',
        where: 'idDistribuicaoQuantitativoAcessosFisicosServicoApp = ?',
        whereArgs: [idDistribuicaoQuantitativoAcessosFisicosServicoApp],
      );
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso.";
      _Operacao.resultado = "Operação realizada com sucesso.";
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