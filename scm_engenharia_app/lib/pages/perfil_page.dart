import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/help/masked_text_controller.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/models/variaveis_de_ambiente.dart';
import 'package:scm_engenharia_app/pages/login_page.dart';

class PerfilPage  extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage > {
  TbUsuario _Usuariodb = new TbUsuario();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  BuildContext dialogContext;
  DBHelper dbHelper;

  TextEditingController _TxtControllerNome = TextEditingController();
  TextEditingController _TxtControllerCpf = new MaskedTextController(mask: '000.000.000-00');
  TextEditingController _TxtControllerEmail = TextEditingController();
  TextEditingController _TxtControllerTelefone = new MaskedTextController(mask: '(00) 0 0000-0000');
  TextEditingController _TxtControllerTelefoneWhatsapp = new MaskedTextController(mask: '(00) 0 0000-0000');
  TextEditingController _TxtControllerEmpresa = TextEditingController();
  TextEditingController _TxtControllerUf = TextEditingController();

  UF UfSelecionada;
  List<UF> ListaUf = new List<UF>();


  Future<Null> OnGetUfs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
      } else {
        OnRealizandoOperacao("Realizando operação");
        Operacao _RestWeb = await _RestWebService.OnVariaveisDeAmbiente();
        if (_RestWeb.erro)
          throw (_RestWeb.mensagem);
        else if (_RestWeb.resultado == null)
          throw (_RestWeb.mensagem);
        else
        {
          VariaveisDeAmbienteResultado  _Resultado = _RestWeb.resultado as VariaveisDeAmbienteResultado;
          setState(() {
            ListaUf = _Resultado.uF;
          });
          Navigator.pop(dialogContext);
        }
      }
    } catch (error) {
      Navigator.pop(dialogContext);
      OnToastInformacao(error);
    }
  }

  Future<Null> OnSalvarConta() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
      } else {
        if (_TxtControllerNome.text.isEmpty)
          throw ("Nome e obrigatório");
        else if (_TxtControllerCpf.text.isEmpty)
          throw ("CPF e obrigatório");
        else if (_TxtControllerEmail.text.isEmpty)
          throw ("Email e obrigatório");
        else if (_TxtControllerTelefone.text.isEmpty)
          throw ("Telefone e obrigatório");
        else if (_TxtControllerTelefoneWhatsapp.text.isEmpty)
          throw ("Telefone Whatsapp e obrigatório");
        else if (_TxtControllerEmpresa.text.isEmpty)
          throw ("Empresa e obrigatório");
        else if (_TxtControllerUf.text.isEmpty)
          throw ("UF deve ser selecionada");
        ModelDadosUsuarioJson _ModelDadosUsuario = new ModelDadosUsuarioJson();
        _ModelDadosUsuario.nome = _TxtControllerNome.text;
        _ModelDadosUsuario.cpf= _TxtControllerCpf.text;
        _ModelDadosUsuario.email= _TxtControllerEmail.text;
        _ModelDadosUsuario.telefone= _TxtControllerTelefone.text;
        _ModelDadosUsuario.telefoneWhatsapp= _TxtControllerTelefoneWhatsapp.text;
        _ModelDadosUsuario.empresa= _TxtControllerEmpresa.text;
        _ModelDadosUsuario.uf = UfSelecionada.id;
        OnRealizandoOperacao("Realizando cadastro");
        Operacao _RestWeb = await _RestWebService.OnCadastraUsuario(_ModelDadosUsuario);
        if (_RestWeb.erro)
          throw (_RestWeb.mensagem);
        else if (_RestWeb.resultado == null)
          throw (_RestWeb.mensagem);
        else
        {
          Navigator.pop(dialogContext);
          OnToastInformacao(_RestWeb.mensagem);
        }
      }
    } catch (error) {
      Navigator.pop(dialogContext);
      OnToastInformacao(error);
    }
  }

  Inc() async {
    try {
      Operacao _UsuarioLogado = await dbHelper.onSelecionarUsuario();
      if (_UsuarioLogado.erro)
        throw (_UsuarioLogado.mensagem);
      else if (_UsuarioLogado.resultado == null) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new LoginPage()),
                (Route<dynamic> route) => false);
      }
      else {
         _Usuariodb = _UsuarioLogado.resultado as TbUsuario;
         _TxtControllerNome.text = _Usuariodb.nome;
         _TxtControllerCpf.text = _Usuariodb.cpf;
         _TxtControllerEmail.text = _Usuariodb.email;
         _TxtControllerTelefone.text = _Usuariodb.telefone;
         _TxtControllerTelefoneWhatsapp.text = _Usuariodb.telefone;
         _TxtControllerEmpresa.text = _Usuariodb.empresa;
      }


     // OnGetUfs();
      //Uf = await Components.OnlistaEstados() as List<String>;
      setState(() {
        // UfTxt = Uf.first;
      });
    } catch (error) {
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  OnRealizandoOperacao(String txtInformacao) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    accentColor: Color(0xff018a8a),
                  ),
                  child: new CircularProgressIndicator(),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0, right: 5.0),
                  child: Text(
                    txtInformacao,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xff212529),
                        fontFamily: "open-sans-regular"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void OnToastInformacao(String Mensagem) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Informação",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff212529),
                        fontFamily: "avenir-lt-std-roman"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child:  Text(
                      Mensagem,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff212529),
                          fontFamily: "avenir-lt-std-roman"),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xff018a8a),
                      //`Icon` to display
                      child: Text(
                        '           OK           ',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xffFFFFFF),
                            fontFamily: "avenir-lt-std-roman"),
                      ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus.unfocus();
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
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
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
                controller: _TxtControllerNome,
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
                controller: _TxtControllerCpf,
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
                controller: _TxtControllerEmail,
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
                controller: _TxtControllerTelefone,
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
                controller: _TxtControllerTelefoneWhatsapp,
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
                controller: _TxtControllerEmpresa,
                textInputAction: TextInputAction.done,
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
                          child:  DropdownButton<UF>(
                            hint: Text("Selecione ..", style: TextStyle(
                                fontSize: 16.0,
                                color: const Color(0xFF90ffffff)),),
                            elevation: 16,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'avenir-lt-std-medium',
                                color: Color(0xFF000000)),
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: Colors.white,
                            value: UfSelecionada != null ? UfSelecionada : null,
                            isExpanded: true,
                            iconSize: 35,
                            items: ListaUf.map((UF value) {
                              return new DropdownMenuItem<UF>(
                                value: value,
                                child: Text(
                                  value.uf,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      color: Color(0xFF000000),
                                      fontFamily:
                                      "avenir-next-rounded-pro-regular"),
                                ),
                              );
                            }).toList(),
                            onChanged: (UF newValue) {
                              setState(() {
                                UfSelecionada = newValue;
                                _TxtControllerUf.text = newValue.uf;
                              });
                            },
                          ),
                        ),)
                      );
                    },
                  )),
              SizedBox(height: 25.0),
              Center(
                child: InkWell(
                  onTap: () async {

                  },
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
