import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/pages/alterar_senha_page.dart';
import 'package:scm_engenharia_app/pages/formulario_sici_fust_page.dart';
import 'package:scm_engenharia_app/pages/login_page.dart';
import 'package:scm_engenharia_app/pages/perfil_page.dart';

class ConfiguracaoPage extends StatefulWidget {
  @override
  _ConfiguracaoPageState createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {

  bool  IsTemaEscuroAppOn = false, IsNotificacoesAtivarDesativada = false;

  @override
  void initState() {
    super.initState();


  }

  Future<void> OnSwitchNotificacoesAtivarDesativadaChanged(bool value) async {
    try {
      setState(() {
        IsNotificacoesAtivarDesativada = value;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<Null> onSairApp(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: new Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    height: 50.0,
                    child: new Text("Deseja realmente sair do aplicativo ?",
                        style: TextStyle(
                            fontFamily: 'open-sans-regular',
                            fontSize: 17.0,
                            color: Color(0xFF000000))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        OutlineButton(
                          color: Color(0xFFf2f2f2),
                          //`Icon` to display
                          child: Text(
                            'Sim',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'avenir-lt-std-roman',
                              color: Color(0xff018a8a),
                            ),
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()), (Route<dynamic> route) => false);
                          },
                          //callback when button is clicked
                          borderSide: BorderSide(
                            color: Color(0xFFf2f2f2), //Color of the border
                            style: BorderStyle.solid, //Style of the border
                            width: 1.0, //width of the border
                          ),
                        ),
                        SizedBox(width: 15.0),
                        FlatButton(
                          color: Color(0xff018a8a),
                          //`Icon` to display
                          child: Text(
                            'Não',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'avenir-lt-std-roman',
                              color: Colors.white,
                            ),
                          ),
                          //`Text` to display
                          onPressed: () {
                            Navigator.pop(context);
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
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Configurações",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
        actions: <Widget>[

        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              SizedBox(height: 5.0),
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                title: Text(
                  "Notificações",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xff333333),
                      fontFamily: "lato-regular"),
                ),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Color(0xFF545454)))),
                  child: Icon(Icons.notifications_none,
                      color: Color(0xff9e9e9e), size: 25.0),
                ),
                trailing: CupertinoSwitch(
                    onChanged: OnSwitchNotificacoesAtivarDesativadaChanged,
                    value: IsNotificacoesAtivarDesativada  == null
                        ? false
                        : IsNotificacoesAtivarDesativada ,
                    activeColor: Color(0xFF005a7c)),
              ),
              Divider(
                color: Color(0xffCCCCCC),
              ),
              ListTile(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Navigator.of(context, rootNavigator: true).push(
                      new CupertinoPageRoute<bool>(
                        maintainState: false,
                        fullscreenDialog: true,
                        builder: (BuildContext context) =>
                        new AlterarSenhaPage(),
                      ),
                    );
                  },
                  contentPadding:
                  EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Color(0xFF545454)))),
                    child: Icon(Icons.https,
                        color: Color(0xff9e9e9e), size: 25.0),
                  ),
                  title: Text(
                    "Alterar senha",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff333333),
                        fontFamily: "Lato-Regular"),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Color(0xff6C757D), size: 30.0)),
              Divider(
                color: Color(0xffCCCCCC),
              ),
              ListTile(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Navigator.of(context, rootNavigator: true).push(
                      new CupertinoPageRoute<bool>(
                        maintainState: false,
                        fullscreenDialog: true,
                        builder: (BuildContext context) =>
                        new PerfilPage(),
                      ),
                    );
                  },
                  contentPadding:
                  EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Color(0xFF545454)))),
                    child: Icon(Icons.perm_identity,
                        color: Color(0xff9e9e9e), size: 25.0),
                  ),
                  title: Text(
                    "Meu perfil",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff333333),
                        fontFamily: "Lato-Regular"),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Color(0xff6C757D), size: 30.0)),
              Divider(
                color: Color(0xffCCCCCC),
              ),
              ListTile(
                  onTap: () {
                    onSairApp(context);
                  },
                  contentPadding:
                  EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0,
                                color: Color(0xff6C757D)))),
                    child: Icon(Icons.exit_to_app,
                        color: Color(0xff9e9e9e), size: 25.0),
                  ),
                  title: Text(
                    "Sair",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff212529),
                        fontFamily: "Lato-Regular"),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Color(0xff6C757D), size: 30.0)),
              Divider(
                color: Color(0xffCCCCCC),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
