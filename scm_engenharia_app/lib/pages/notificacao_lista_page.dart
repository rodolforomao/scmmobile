import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/login_page.dart';
import 'package:scm_engenharia_app/splash_screen.dart';

class NotificacaoListaPage extends StatefulWidget {
  @override
  _NotificacaoListaPageState createState() => _NotificacaoListaPageState();
}

class _NotificacaoListaPageState extends State<NotificacaoListaPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  DBHelper dbHelper;
  BuildContext dialogContext;
  TbUsuario _Usuariodb = new TbUsuario();
  StreamSubscription<ConnectivityResult> subscription;
  TextEditingController _TxtControlleraSenha = TextEditingController();
  TextEditingController _TxtControllerNova = TextEditingController();
  TextEditingController _TxtControllerConfirmarSenha = TextEditingController();
  String _StatusTipoWidget;

  Future<Null> OnAtualizarSenha() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none)
        OnAlertaInformacao("Verifique sua conexão com a internet e tente novamente.",0xffde3544);
      else {
        if (_TxtControlleraSenha.text.isEmpty)
          throw ("O campo senha e obrigatório");
        else if (_TxtControllerNova.text.isEmpty)
          throw ("O nova senha e obrigatório");
        else if (_TxtControllerConfirmarSenha.text.isEmpty)
          throw ("O confirmar e nova senha e obrigatório");
        else if (_TxtControllerNova.text != _TxtControllerConfirmarSenha.text)
          throw ("O nova senha e confirmar e nova senha obrigatório");
        OnRealizandoOperacao("Realizando operação",true);
        Operacao _RespResultado = await _RestWebService.OnAlterarSenha(_TxtControllerNova.text);
        if(_RespResultado.erro)
          throw(_RespResultado.mensagem);
        else
        {
          _Usuariodb.senha = _TxtControllerNova.text;
          Operacao _UsuarioLogado = await dbHelper.OnAddUpdateUsuario(_Usuariodb);
          if (_UsuarioLogado.erro)
            throw (_UsuarioLogado.mensagem);
          else {
            OnRealizandoOperacao("",false);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 15.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Informação",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xff212529),
                                fontFamily: "avenir-lt-std-roman"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black12,
                          ),
                          Padding(padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            child:  Text(
                              _RespResultado.mensagem,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xff212529),
                                  fontFamily: "avenir-lt-std-roman"),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black12,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            FlatButton(
                              color: Color(0xff018a8a),
                              //`Icon` to display
                              child: Text(
                                '           OK           ',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xffFFFFFF),
                                    fontFamily: "avenir-lt-std-roman"),
                              ),
                              //`Text` to display
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => new SplashScreen()),
                                        (Route<dynamic> route) => false);
                              },
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }
      }
    } catch (error) {
      OnRealizandoOperacao("",false);
      OnAlertaInformacao(error.toString(),0xffde3544);
    }
  }

  OnAlertaInformacao(String Mensagem, int CorButton) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Informação",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff212529),
                        fontFamily: "avenir-lt-std-roman"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child:  Text(
                      Mensagem,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff212529),
                          fontFamily: "avenir-lt-std-roman"),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      color: Color(CorButton),
                      //`Icon` to display
                      child: Text(
                        '           OK           ',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xffFFFFFF),
                            fontFamily: "avenir-lt-std-roman"),
                      ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus.unfocus();
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  OnRealizandoOperacao(String txtInformacao ,bool IsRealizandoOperacao) {
    if (dialogContext == null) {
      setState(() {
        dialogContext = null;
        IsRealizandoOperacao = false;
      });
    }
    else if (IsRealizandoOperacao != true && txtInformacao == "") {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      setState(() {
        dialogContext = null;
        IsRealizandoOperacao = false;
      });
    }
    else
    {
      setState(() {
        IsRealizandoOperacao = false;
      });
      showDialog(
        context: _ScaffoldKey.currentContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: Color(0xff018a8a),
                    ),
                    child: new CircularProgressIndicator(),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 10.0, top: 20.0, bottom: 20.0, right: 5.0),
                    child: Text(
                      txtInformacao,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff212529),
                          fontFamily: "open-sans-regular"),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Inc() async {
    try {
      Operacao _UsuarioLogado = await dbHelper.onSelecionarUsuario();
      if (_UsuarioLogado.erro)
        throw (_UsuarioLogado.mensagem);
      else if (_UsuarioLogado.resultado == null) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new LoginPage()),
                (Route<dynamic> route) => false);
      }
      else {
        _Usuariodb = _UsuarioLogado.resultado as TbUsuario;
      }
    } catch (error) {
      OnAlertaInformacao(error.toString(),0xffde3544);
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    Future.delayed(Duration.zero, () async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          _StatusTipoWidget = "sem_internet";
        });
      } else {
        setState(() {
          _StatusTipoWidget = "renderizar_tela";
        });
      }
    });
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {

      } else {
        _ScaffoldKey.currentState.removeCurrentSnackBar();
        setState(() {
          _StatusTipoWidget = "renderizar_tela";
        });
      }
    });
    Inc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }


  Widget build(BuildContext context) {
    return new Scaffold(
      key: _ScaffoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFF65100),
                Color(0xFFf5821f),
                Color(0xFFff8c49),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Notificações",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
        actions: <Widget>[

        ],
      ),
      body: _TipoWidget(context),
    );
  }

  _TipoWidget(BuildContext context) {
    switch (_StatusTipoWidget) {
      case "sem_internet":
        {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/imagens/img_sem_sinal.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Não há conexão com a internet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Verifique sua conexão com a internet e tente novamente.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var connectivityResult = await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          setState(() {
                            _StatusTipoWidget = "sem_internet";
                          });
                          _ScaffoldKey.currentState.showSnackBar(SnackBar(
                            onVisible: () {
                              print('Visible');
                            },
                            elevation: 6.0,
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            content: SizedBox(
                              height: 30.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Tentando reconectar a internet",
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: "avenir-lt-std-roman",
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(Color(0xff2fdf84)),
                                    ),
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                ],
                              ),
                            ),
                            duration: Duration(days: 365),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.black54,
                                width: 2,
                              ),
                            ),
                          ));
                        } else {
                          _ScaffoldKey.currentState.removeCurrentSnackBar();
                          setState(() {
                            _StatusTipoWidget = "renderizar_tela";
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 0.0),
                        constraints: BoxConstraints(maxWidth: 300),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Color(0xff8854d0)),
                        child: Text(
                          'TENTE NOVAMENTE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ), /* add child content here */
            ),
          );
        }
        break;
      case "renderizar_tela":
        {
          return Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                ],
              ),
            ),
          );
        }
        break;
    }
  }
}
