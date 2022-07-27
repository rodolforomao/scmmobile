import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordView> {


  StreamSubscription<ConnectivityResult>? subscription;
  TextEditingController _TxtControlleraSenha = TextEditingController();
  TextEditingController _TxtControllerNova = TextEditingController();
  TextEditingController _TxtControllerConfirmarSenha = TextEditingController();
  late String _StatusTipoWidget;





  Inc() async {
    try {

    } catch (error) {

    }
  }

  @override
  void initState() {
    super.initState();
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

  }


  Widget build(BuildContext context) {
    return new Scaffold(
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
      body:Column(children: [],),
    );
  }


}
