import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/navigation_service/route_paths.dart' as routes;

class AlterarSenhaView extends StatefulWidget {
  const AlterarSenhaView({Key? key}) : super(key: key);
  @override
  AlterarSenhaState createState() => AlterarSenhaState();
}

class AlterarSenhaState extends State<AlterarSenhaView> {



  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {

    });
  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Alterar senha'),
        toolbarHeight: 80,
        flexibleSpace: const Image(
          image: AssetImage('assets/img/fundo_tela_configuracoes.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
              padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0, bottom: 10.0),
              constraints:  BoxConstraints(
                minHeight: 500,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -140,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[

                ],
              )),),),
    );
  }

}
