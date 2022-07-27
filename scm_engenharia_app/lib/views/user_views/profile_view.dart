import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileView> {




  @override
  void initState() {
    super.initState();


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
          "Dados",
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
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                autofocus: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                  hintText: 'Digite seu nome completo',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Digite seu CPF',
                ),
                autofocus: false,
                keyboardType: TextInputType.number,

                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                ),
                autofocus: false,
                keyboardType: TextInputType.emailAddress,

                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'Telefone fixo',
                  hintText: 'Digite telefone fixo',
                ),
                autofocus: false,
                keyboardType: TextInputType.phone,

                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Whatsapp',
                  hintText: 'Digite Whatsapp',
                ),
                autofocus: false,
                keyboardType: TextInputType.phone,

                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'Nome da empresa',
                  hintText: 'avenir-lt-std-medium',
                ),
                autofocus: false,
                keyboardType: TextInputType.text,

                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 5.0,
              ),

              SizedBox(height: 25.0),
              Center(
                child: InkWell(
                  onTap: () async {},
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
                      'ATUALIZAR',
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
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
