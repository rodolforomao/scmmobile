import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:scm_engenharia_app/help/notification_firebase.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/menu_navigation.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/criar_nova_conta_page.dart';
import 'package:scm_engenharia_app/pages/esqueceu_sua_senha_page.dart';
import 'package:scm_engenharia_app/help/usuario_logado.dart' as UsuarioLogado;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _launchWhatsApp() async {
    String phoneNumber = "+5561982205225";
    String message = 'Olá, gostaria de ter acesso ao aplicativo da SCM.';
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  void whatsappopen() {
    FlutterOpenWhatsapp.sendSingleMessage("5561982205225",
        "Olá Pessoal, Gostaria de ter acesso ao aplicativo da SCM. Esta é uma mensagem automática gerada pelo aplicativo SCM Mobile.");
  }

  ServicoMobileService _RestWebService = new ServicoMobileService();
  DBHelper dbHelper;
  TextEditingController _TxtControllerEmail = TextEditingController();
  TextEditingController _TxtControllerSenha = TextEditingController();
  String errorTextControllerSenha, errorTextControllerEmail;
  ModelLoginJson _UsuarioLoginModelo = new ModelLoginJson();
  bool isVisualizarSenha = false;
  BuildContext dialogContext;

  Future<Null> RealizandoLogin(BuildContext context) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        OnAlertaInformacao("Não há conexão com a Internet");
      } else {
        if (_TxtControllerEmail.text.isEmpty)
          throw ("E-mail é obrigatório");
        else if (_TxtControllerSenha.text.isEmpty)
          throw ("Senha é obrigatória");
        OnRealizandoOperacao("Realizando login..");
        _UsuarioLoginModelo.usuario = _TxtControllerEmail.text.trim();
        _UsuarioLoginModelo.password = _TxtControllerSenha.text.trim();
        Operacao _RestWebUsuario = await _RestWebService.OnLogin(_UsuarioLoginModelo);
        if (_RestWebUsuario.erro)
          throw (_RestWebUsuario.mensagem);
        else if (_RestWebUsuario.resultado == null)
          throw (_RestWebUsuario.mensagem);
        else {
          ModelInformacaoUsuario _UsuarioModelo = ModelInformacaoUsuario.fromJson(_RestWebUsuario.resultado);
          TbUsuario Usuario = new TbUsuario();
          Usuario.idUsuarioApp = null;
          Usuario.idUsuario = _UsuarioModelo.idUsuario;
          Usuario.idPerfil = _UsuarioModelo.idPerfil;
          Usuario.nome = _UsuarioModelo.descNome;
          Usuario.senha = _TxtControllerSenha.text.trim();
          Usuario.email = _TxtControllerEmail.text.trim();
          Usuario.telefone = _UsuarioModelo.telefoneConsultor;
          Usuario.dtUltacesso = _UsuarioModelo.dtUltacesso;
          Usuario.empresa = _UsuarioModelo.empresa;
          Usuario.periodoReferencia = _UsuarioModelo.periodoReferencia;
          Usuario.cpf = _UsuarioModelo.cpf;
          Operacao _UsuarioLogado = await dbHelper.OnAddUpdateUsuario(Usuario);
          if (_UsuarioLogado.erro)
            throw (_UsuarioLogado.mensagem);
          else {
            if (dialogContext != null) {
              Navigator.pop(dialogContext);
              setState(() {
                dialogContext = null;
              });
            }
            NotificationHandler().unsubscribeFromTopic("scmengenhariaUserNLogado");
            NotificationHandler().subscribeToTopic("nroCPF-" +Usuario.cpf);
            NotificationHandler().subscribeToTopic("scmengenhariaUserAllLogado");
            Future.delayed(Duration.zero, () {
              UsuarioLogado.DadosUsuarioLogado = Usuario;
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new MenuNavigation()),
                  (Route<dynamic> route) => false);
            });
          }
          if (dialogContext != null) {
            Navigator.pop(dialogContext);
            setState(() {
              dialogContext = null;
            });
          }
        }
      }
    } catch (error) {
      if (dialogContext != null) {
        Navigator.pop(dialogContext);
        setState(() {
          dialogContext = null;
        });
      }
      OnAlertaInformacao(error);
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
                  margin: EdgeInsets.only(
                      left: 10.0, top: 20.0, bottom: 20.0, right: 5.0),
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

  OnAlertaInformacao(String Mensagem) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: Text(
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
     NotificationHandler().subscribeToTopic("scmengenhariaUserNLogado");
    // _TxtControllerEmail.text = "rodolforomao@gmail.com";
    // _TxtControllerSenha.text = "123456";

  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
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
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "E-mail",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _TxtControllerEmail,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'open-sans-regular',
                        color: const Color(0xFF373737)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
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
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.3),
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
                  height: 17.0,
                ),
                Text(
                  "Senha",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    controller: _TxtControllerSenha,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'open-sans-regular',
                        color: const Color(0xFF373737)),
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
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
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        prefixIcon: const Icon(
                          Icons.https,
                          size: 20,
                          color: const Color(0xffFFFFFF),
                        ),
                        hintText: "Digite sua senha",
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
                SizedBox(height: 40.0),
                Center(
                  child: InkWell(
                    onTap: () async {
                      RealizandoLogin(context);
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
                        'LOGIN',
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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigator.of(context, rootNavigator: true).push(
                        new CupertinoPageRoute<bool>(
                          maintainState: false,
                          fullscreenDialog: true,
                          builder: (BuildContext context) =>
                              new CriarNovaContaPageState(),
                        ),
                      );
                    },
                    child: Text(
                      "Criar uma nova conta",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: "avenir-lt-std-roman",
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: showFab
            ? FloatingActionButton(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                onPressed: () {
                  //_launchWhatsApp();
                  whatsappopen();
                },
                child: Image(
                  width: 40,
                  height: 40,
                  image: AssetImage(
                    'assets/ic_whatsapp.png',
                  ),
                  fit: BoxFit.fill,
                ),
              )
            : null,
      ),
    );
  }
}
