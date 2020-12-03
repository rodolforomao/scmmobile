import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, kIsWeb;
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'package:scm_engenharia_app/help/notification_firebase.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/menu_navigation.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/erro_informacao_page.dart';
import 'package:scm_engenharia_app/pages/login_page.dart';
import 'package:scm_engenharia_app/pages/variavel_de_ambiente_page.dart';
import 'package:scm_engenharia_app/help/usuario_logado.dart' as UsuarioLogado;


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  TbUsuario _Usuariodb = new TbUsuario();
  DBHelper dbHelper;
  StreamSubscription<ConnectivityResult> subscription;

  OnInc() async {
    try {
      if (kIsWeb) {

      } else {
        print("Inicio busca");
        Operacao _UsuarioLogado = await dbHelper.onSelecionarUsuario();
        print("Fim busca  busca");
        if (_UsuarioLogado.erro)
          throw (_UsuarioLogado.mensagem);
        else if (_UsuarioLogado.resultado == null) {
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginPage()),
                  (Route<dynamic> route) => false);
        }
        else {
          Operacao _ExisteVariavelDeAmbiente = await dbHelper.OnExisteVariavelDeAmbiente();
          if (_ExisteVariavelDeAmbiente.erro)
            throw (_ExisteVariavelDeAmbiente.mensagem);
          else if (_ExisteVariavelDeAmbiente.resultado == true) {
            Navigator.of(context, rootNavigator: true).push(
              new CupertinoPageRoute<bool>(
                maintainState: false,
                fullscreenDialog: true,
                builder: (BuildContext context) => new VariavelDeAmbientePage(),
              ),
            ).then((value) {
              OnInc();
            });
          } else {
            _Usuariodb = _UsuarioLogado.resultado as TbUsuario;
            if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
              UsuarioLogado.DadosUsuarioLogado = _Usuariodb;
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new MenuNavigation()),
                      (Route<dynamic> route) => false);
            } else {

              ModelLoginJson _UsuarioLoginModelo = new ModelLoginJson();
              _UsuarioLoginModelo.password = _Usuariodb.senha;
              _UsuarioLoginModelo.usuario = _Usuariodb.email;
              Operacao _RestWebUsuario = await _RestWebService.OnLogin(_UsuarioLoginModelo);
              if (_RestWebUsuario.erro)
                throw (_RestWebUsuario.mensagem);
              else if (_RestWebUsuario.resultado == null)
                throw (_RestWebUsuario.mensagem);
              else {
                ModelInformacaoUsuario _UsuarioModelo = ModelInformacaoUsuario.fromJson( _RestWebUsuario.resultado);
                TbUsuario Usuario = new TbUsuario();
                Usuario.idUsuarioApp = _Usuariodb.idUsuarioApp;
                Usuario.idUsuario = _UsuarioModelo.idUsuario;
                Usuario.idPerfil = _UsuarioModelo.idPerfil;
                Usuario.nome = _UsuarioModelo.descNome;
                Usuario.senha = _Usuariodb.senha;
                Usuario.email = _Usuariodb.email;
                Usuario.telefone = _UsuarioModelo.telefoneConsultor;
                Usuario.dtUltacesso = _UsuarioModelo.dtUltacesso;
                Usuario.empresa = _UsuarioModelo.empresa;
                Usuario.periodoReferencia = _UsuarioModelo.periodoReferencia;
                Usuario.cpf = _UsuarioModelo.cpf;
                Operacao _UsuarioLogado = await dbHelper.OnAddUpdateUsuario(Usuario);
                if (_UsuarioLogado.erro)
                  throw (_UsuarioLogado.mensagem);
                else {
                  UsuarioLogado.DadosUsuarioLogado = Usuario;
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                          new MenuNavigation()),
                          (Route<dynamic> route) => false);
                }
              }
            }
          }
        }
      }
    } catch (error) {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => new ErroInformacaoPage(informacao:error))).then((value) {
            OnInc();
      });
    }
  }

  @override
  void initState()
  {
    super.initState();
    dbHelper = DBHelper();
    NotificationHandler().initializeFcmNotification();
    Future(() {
       OnInc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFF65100),
            Color(0xFFff8c49),
            Color(0xFFf5821f),
            Color(0xffffba49)
          ],
        ),
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Scaffold(
          key: _ScaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              "Iniciando . . .",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 19.0,
                  color: Color(0xffFFFFFF),
                  fontFamily: "open-sans-regular"),
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/login_logo.png",
                        height: 200.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ), /* add child content here */
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0.0,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 70.0,
              child: Theme(
                data: Theme.of(context).copyWith(
                  accentColor: Color(0xffFFFFFF),
                ),
                child: new CircularProgressIndicator(),
              ),
            ),
          ))
    );
  }
}
