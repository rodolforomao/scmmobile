import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlterarSenhaPage extends StatefulWidget {
  @override
  _AlterarSenhaPageState createState() => _AlterarSenhaPageState();
}

class _AlterarSenhaPageState extends State<AlterarSenhaPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<ConnectivityResult> subscription;
  TextEditingController _TxtControlleraSenha = TextEditingController();
  TextEditingController _TxtControllerNova = TextEditingController();
  TextEditingController _TxtControllerConfirmarSenha = TextEditingController();
  String _StatusTipoWidget;
  bool _IsCarregandoButton = false;


  Future<Null> onIncApp(BuildContext context) async {
    try {

    } catch (error) {

    }
  }

  Future<Null> OnCadastroAtualizarSenha(BuildContext context) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none)
        OnToastInformacao("Verifique sua conexão com a internet e tente novamente.", 0xFFffbb33);
      else {

      }
    } catch (error) {
      setState(() {
        _IsCarregandoButton = false;
      });
      print(error);
      OnToastInformacao(error.toString(), 0xFFCC0000);
    }
  }

  void OnToastInformacao(String Mensagem, int CorInformacao) {
    final snackBar = SnackBar(
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        Mensagem,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: false,
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xffFFFFFF),
            fontFamily: "avenir-lt-medium"),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Color(CorInformacao),
    );
    _ScaffoldKey.currentState.showSnackBar(snackBar);
  }

  IncOnConexaoComInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _StatusTipoWidget = "sem_internet";
      });
    } else {
      onIncApp(context);
      setState(() {
        _StatusTipoWidget = "alterar_senha";
      });
    }
  }

  OnStatusDaConexaoInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      onIncApp(context);
      setState(() {
        _StatusTipoWidget = "alterar_senha";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future(() {
      IncOnConexaoComInternet();
    });
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      OnStatusDaConexaoInternet();
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  _TipoWidget(BuildContext context) {
    switch (_StatusTipoWidget) {
      case "sem_internet":
        {
          return Container(
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
                    Image.asset(
                      "assets/imagens/img_no_rede.png",
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      "Não há conexão com a internet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato-Regular',
                          fontSize: 20.0,
                          color: Color(0xFF000000)),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Verifique sua conexão com a internet e tente novamente.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato-Regular',
                          fontSize: 17.0,
                          color: Color(0xFF545454)),
                    ),
                    SizedBox(height: 25.0),
                    InkWell(
                      onTap: () async {
                        try {
                          OnToastInformacao("Tentando conectar a internet.",0xFFffbb33);
                          IncOnConexaoComInternet();
                        } catch (error) {
                          print(error);
                          OnToastInformacao(error.toString(), 0xFFCC0000);
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: new Border.all(color: Colors.transparent, width: 0.0),
                          borderRadius: new BorderRadius.circular(50.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color(0xfff89d05),
                              Color(0xffe74c1b),
                            ],
                          ),
                        ),
                        child: Center(
                          child: _IsCarregandoButton == false
                              ? Text(
                            'TENTE NOVAMENTE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'avenir-lt-medium',
                              fontSize: 14.0,
                            ),
                          )
                              : Center(
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(accentColor: Colors.white),
                              child: new CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ), /* add child content here */
          );
        }
        break;
      case "alterar_senha":
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
                  SizedBox(
                    height: 30.0,
                  ),
                  StreamBuilder<String>(
                    builder: (context, snapshot) => TextFormField(
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _TxtControlleraSenha,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'nunito-regular',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                        hintText: "Digite sua senha ",
                        labelText: "Senha",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                    builder: (context, snapshot) => TextFormField(
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _TxtControllerNova,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'nunito-regular',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                        hintText: "Digite sua nova senha",
                        labelText: "Nova senha",
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  StreamBuilder<String>(
                    builder: (context, snapshot) => TextFormField(
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _TxtControllerConfirmarSenha,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'nunito-regular',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                        hintText: "Confirmar senha",
                        labelText: "Confirmar senha",
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0),
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      padding: EdgeInsets.symmetric(vertical: 13),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          border:
                          Border.all(color: Color(0xff018a8a), width: 2),
                          color: Color(0xff018a8a)),
                      child: Text(
                        'ENVIAR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'avenir-lt-std-roman',
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        break;
    }
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
          "Alterar senha",
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
}
