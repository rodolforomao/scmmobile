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
          decoration: const BoxDecoration(
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
        title: const Text(
          'Dados',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 200,
              maxWidth: 800,
            ),
            child:  Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
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
              Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: TextButton(
                child: const Text(' ATUALIZAR '),
                onPressed: () async {

                },
              ),),
              SizedBox(height: 30.0),
            ],
          ),),
        ),
      ),
    );
  }
}
