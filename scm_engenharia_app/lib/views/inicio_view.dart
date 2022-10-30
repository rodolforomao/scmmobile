
// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../help/navigation_service/route_paths.dart' as routes;
import '../help/responsive.dart';
import '../thema/app_thema.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;



class InicioView extends StatefulWidget {
  const InicioView({Key? key}) : super(key: key);

  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<InicioView>  {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {

      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.android) {
        await FirebaseMessaging.instance.subscribeToTopic('ScmEngenhariaNLogadoAll');
        await FirebaseMessaging.instance.subscribeToTopic('ScmEngenhariaAll');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            minHeight: Responsive.minHeightView,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }

}



