import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


class ForgotYourPasswordView extends StatefulWidget {
  const ForgotYourPasswordView({Key? key}) : super(key: key);
  @override
  ForgotYourPasswordState createState() => ForgotYourPasswordState();
}

class ForgotYourPasswordState extends State<ForgotYourPasswordView> {

  late StreamSubscription<ConnectivityResult> subscription;




  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {

        });
      } else {
        setState(() {

        });
      }
    });
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {

      } else {

      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
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
