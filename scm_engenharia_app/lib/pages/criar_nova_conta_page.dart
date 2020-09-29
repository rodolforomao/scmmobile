import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import 'package:scm_engenharia_app/help/masked_text_controller.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/models/variaveis_de_ambiente.dart';

class CriarNovaContaPageState extends StatefulWidget {
  @override
  _CriarNovaContaPageState createState() => _CriarNovaContaPageState();
}

class _CriarNovaContaPageState extends State<CriarNovaContaPageState> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  BuildContext dialogContext;
  StreamSubscription<ConnectivityResult> subscription;
  String _StatusTipoWidget, ErroInformacao = "";
  TextEditingController _TxtControllerNome = TextEditingController();
  TextEditingController _TxtControllerCpf =
      new MaskedTextController(mask: '000.000.000-00');
  TextEditingController _TxtControllerEmail = TextEditingController();
  TextEditingController _TxtControllerTelefone =
      new MaskedTextController(mask: '(00) 0 0000-0000');
  TextEditingController _TxtControllerTelefoneWhatsapp =
      new MaskedTextController(mask: '(00) 0 0000-0000');
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
        else {
          VariaveisDeAmbienteResultado _Resultado =
              _RestWeb.resultado as VariaveisDeAmbienteResultado;
          setState(() {
            ListaUf = _Resultado.uF;
          });
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
      OnToastInformacao(error);
      setState(() {
        _StatusTipoWidget = "widget_informacao";
        ErroInformacao = error;
      });
    }
  }

  Future<Null> OnSalvarConta() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
      } else {
        if (_TxtControllerNome.text.isEmpty)
          throw ("Nome é obrigatório");
        else if (_TxtControllerCpf.text.isEmpty)
          throw ("CPF é obrigatório");
        else if (_TxtControllerEmail.text.isEmpty)
          throw ("Email é obrigatório");
        else if (_TxtControllerTelefone.text.isEmpty)
          throw ("Telefone é obrigatório");
        else if (_TxtControllerTelefoneWhatsapp.text.isEmpty)
          throw ("Telefone Whatsapp é obrigatório");
        else if (_TxtControllerEmpresa.text.isEmpty)
          throw ("Empresa é obrigatório");
        else if (_TxtControllerUf.text.isEmpty)
          throw ("UF deve ser selecionada");
        ModelDadosUsuarioJson _ModelDadosUsuario = new ModelDadosUsuarioJson();
        _ModelDadosUsuario.nome = _TxtControllerNome.text;
        _ModelDadosUsuario.cpf = _TxtControllerCpf.text;
        _ModelDadosUsuario.email = _TxtControllerEmail.text;
        _ModelDadosUsuario.telefone = _TxtControllerTelefone.text;
        _ModelDadosUsuario.telefoneWhatsapp =
            _TxtControllerTelefoneWhatsapp.text;
        _ModelDadosUsuario.empresa = _TxtControllerEmpresa.text;
        _ModelDadosUsuario.uf = UfSelecionada.id;
        OnRealizandoOperacao("Realizando cadastro");
        Operacao _RestWeb =
            await _RestWebService.OnCadastraUsuario(_ModelDadosUsuario);
        if (_RestWeb.erro)
          throw (_RestWeb.mensagem);
        else if (_RestWeb.resultado == null)
          throw (_RestWeb.mensagem);
        else {
          if (dialogContext != null) {
            Navigator.pop(dialogContext);
            setState(() {
              dialogContext = null;
            });
          }
          OnToastInformacao(_RestWeb.mensagem);
        }
      }
    } catch (error) {
      if (dialogContext != null) {
        Navigator.pop(dialogContext);
        setState(() {
          dialogContext = null;
        });
      }
      OnToastInformacao(error);
    }
  }

  Inc() async {
    try {
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
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
        } else {
          _ScaffoldKey.currentState.removeCurrentSnackBar();
          setState(() {
            _StatusTipoWidget = "renderizar_tela";
          });
        }
      });
      OnGetUfs();
    } catch (error) {
      OnToastInformacao(error);
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

  void OnToastInformacao(String Mensagem) {
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
    Inc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
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
        key: _ScaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Registrar usuário",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),
        ),
        body: _TipoWidget(context),
      ),
    );
  }

  _TipoWidget(BuildContext context) {
    switch (_StatusTipoWidget) {
      case "sem_internet":
        {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/imagens/img_sem_sinal.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Não há conexão com a internet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Verifique sua conexão com a internet e tente novamente.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          setState(() {
                            _StatusTipoWidget = "sem_internet";
                          });
                          _ScaffoldKey.currentState.showSnackBar(SnackBar(
                            onVisible: () {
                              print('Visible');
                            },
                            elevation: 6.0,
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            content: SizedBox(
                              height: 30.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Tentando reconectar a internet",
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: "avenir-lt-std-roman",
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xff2fdf84)),
                                    ),
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                ],
                              ),
                            ),
                            duration: Duration(days: 365),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.black54,
                                width: 2,
                              ),
                            ),
                          ));
                        } else {
                          _ScaffoldKey.currentState.removeCurrentSnackBar();
                          setState(() {
                            _StatusTipoWidget = "renderizar_tela";
                          });
                        }
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
                          'TENTE NOVAMENTE',
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
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        break;
      case "widget_informacao":
        {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/imagens/img_informacao.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Problema não identificado",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    ErroInformacao,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        Inc();
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
                          'TENTE NOVAMENTE',
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
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        break;
      case "renderizar_tela":
        {
          return Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "Nome completo",
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
                      controller: _TxtControllerNome,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'avenir-lt-std-medium',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          hintText: "Digite seu nome completo",
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
                    "CPF",
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
                      keyboardType: TextInputType.number,
                      controller: _TxtControllerCpf,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'avenir-lt-std-medium',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          hintText: "Digite seu CPF",
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
                          fontSize: 20,
                          fontFamily: 'avenir-lt-std-medium',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          hintText: "Digite seu e-mail",
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
                    "Telefone fixo",
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
                      keyboardType: TextInputType.number,
                      controller: _TxtControllerTelefone,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'avenir-lt-std-medium',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          hintText: "Digite telefone fixo",
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
                    "Whatsapp",
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
                      keyboardType: TextInputType.number,
                      controller: _TxtControllerTelefoneWhatsapp,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'avenir-lt-std-medium',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          hintText: "Digite Whatsapp",
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
                    "Nome da empresa",
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
                      controller: _TxtControllerEmpresa,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'avenir-lt-std-medium',
                          color: const Color(0xFF000000)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.3),
                          ),
                          hintText: "Digite o nome da empresa",
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
                  SizedBox(height: 20.0),
                  Text(
                    "Selecione a UF",
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
                  Container(
                      height: 55.0,
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.3),
                                ),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: const Color(0xFF90ffffff)),
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF90ffffff),
                                    fontFamily: 'open-sans-regular'),
                                fillColor: Color(0xff80ff9b7b),
                                filled: true),
                            child: Container(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<UF>(
                                  hint: Text(
                                    "Selecione ..",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: const Color(0xFF90ffffff)),
                                  ),
                                  elevation: 16,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'avenir-lt-std-medium',
                                      color: Color(0xFF000000)),
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: Colors.white,
                                  value: UfSelecionada != null
                                      ? UfSelecionada
                                      : null,
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
                              ),
                            ),
                          );
                        },
                      )),
                  SizedBox(height: 40.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus.unfocus();
                        OnSalvarConta();
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
                          'REGISTRAR',
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
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        break;
    }
  }
}
