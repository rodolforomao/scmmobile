import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:scm_engenharia_app/help/components.dart';

class PerfilPage  extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage > {
  TextEditingController _TxtControllerEmail = TextEditingController();
  List<String> Uf = new List<String>();
  String UfTxt, errorTextControllerSenha, errorTextControllerEmail;



  Inc() async {
    try {
      Uf = await Components.OnlistaEstados() as List<String>;
      setState(() {
        UfTxt = Uf.first;
      });
    } catch (error) {
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    Inc();

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
        actions: <Widget>[

        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                  hintText: 'Digite seu nome completo',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Digite seu CPF',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Telefone fixo',
                  hintText: 'Digite telefone fixo',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Whatsapp',
                  hintText: 'Digite Whatsapp',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Nome da empresa',
                  hintText: 'avenir-lt-std-medium',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  height: 55.0,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Nome da estado',
                          hintText: 'avenir-lt-std-medium',
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                          child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            elevation: 16,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'avenir-lt-std-medium',
                              color: Color(0xFF000000),),
                            iconEnabledColor: Colors.white,
                            value: UfTxt,
                            isExpanded: true,
                            iconSize: 35,
                            items: Uf.map((String value) {
                              return new DropdownMenuItem<String>(
                                onTap: () {
                                  setState(() {

                                  });
                                },
                                value: value,
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      color: Color(0xFF000000),
                                      fontFamily: "avenir-next-rounded-pro-regular"),
                                ),
                              );
                            }).toList(),
                            onTap: () {
                              setState(() {

                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                UfTxt = value;
                              });
                            },
                          ),
                        ),)
                      );
                    },
                  )),
              SizedBox(height: 40.0),
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
                    'Atualizar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'avenir-lt-std-roman',
                      fontSize: 15.0,
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
