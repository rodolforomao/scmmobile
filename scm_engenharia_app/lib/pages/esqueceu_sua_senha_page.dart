import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class EsqueceuSuaSenhaPageState extends StatefulWidget {
  @override
  _EsqueceuSuaSenhaPageState createState() => _EsqueceuSuaSenhaPageState();
}

class _EsqueceuSuaSenhaPageState extends State<EsqueceuSuaSenhaPageState> {
  TextEditingController _TxtControllerEmail = TextEditingController();

  late String errorTextControllerSenha, errorTextControllerEmail;
  bool _IsLogando = false, isVisualizarSenha = false;

  @override
  void initState() {
    super.initState();
    _TxtControllerEmail.text = "allessandrojs@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Recuperar senha",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/login_logo.png",
                    height: 180.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Center(
                  child: Text(
                    'Entre com o e-mail utilizado no cadastro.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                        fontFamily: "avenir-next-rounded-pro-regular"),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text("E-mail",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.white,),),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'avenir-lt-std-medium',
                        color: const Color(0xFF373737)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                width: 1,
                                color: errorTextControllerEmail == null
                                    ? Color(0xFFb8b8b8)
                                    : Colors.redAccent)),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          size: 20,
                          color: const Color(0xffFFFFFF),
                        ),
                        hintText: "Digite seu email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: const Color(0xFF90ffffff)),
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF90ffffff),
                            fontFamily: 'open-sans-regular'),
                        errorStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontFamily: 'open-sans-regular'),
                        fillColor: Color(0xff80ff9b7b),
                        filled: true)),
                SizedBox(
                  height: 25.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        border: Border.all(color: Color(0xff018a8a), width: 2),
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
