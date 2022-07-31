import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../help/navigation_service/route_paths.dart' as routes;
import 'help_views/global_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsView> {
  bool IsTemaEscuroAppOn = false, IsNotificacoesAtivarDesativada = false;


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
        actions: <Widget>[],
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
                  "Notificação",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xff333333),
                      fontFamily: "avenir-lt-std-roman"),
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
                    value: IsNotificacoesAtivarDesativada == null
                        ? false
                        : IsNotificacoesAtivarDesativada,
                    activeColor: Color(0xFF005a7c)),
              ),
              Divider(
                color: Color(0xffCCCCCC),
              ),
              ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      routes.changePasswordRoute,
                    );
                  },
                  contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Color(0xFF545454)))),
                    child:
                    Icon(Icons.https, color: Color(0xff9e9e9e), size: 25.0),
                  ),
                  title: Text(
                    "Alterar senha",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff333333),
                        fontFamily: "avenir-lt-std-roman"),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Color(0xff6C757D), size: 30.0)),
              Divider(
                color: Color(0xffCCCCCC),
              ),
              ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      routes.perfilRoute,
                    );
                  },
                  contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
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
                        fontFamily: "avenir-lt-std-roman"),
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
                    Navigator.of(context).pushNamed(
                      routes.environmentVariableRoute,
                    );
                  },
                  contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Color(0xFF545454)))),
                    child: Icon(Icons.compare,
                        color: Color(0xff9e9e9e), size: 24.0),
                  ),
                  title: Text(
                    "Variável de ambiente",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff333333),
                        fontFamily: "avenir-lt-std-roman"),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Color(0xff6C757D), size: 30.0)),
              Divider(
                color: Color(0xffCCCCCC),
              ),
              ListTile(
                  onTap: () {
                    OnExitApp(context);
                  },
                  contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Color(0xff6C757D)))),
                    child: Icon(Icons.exit_to_app,
                        color: Color(0xff9e9e9e), size: 25.0),
                  ),
                  title: Text(
                    "Sair",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff212529),
                        fontFamily: "avenir-lt-std-roman"),
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
