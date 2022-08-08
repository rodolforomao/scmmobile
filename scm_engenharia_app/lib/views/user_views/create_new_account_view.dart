import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import '../../help/formatter/cpf_input_formatter.dart';
import '../../models/operation.dart';
import '../../models/environment_variables.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import '../../help/navigation_service/route_paths.dart' as routes;


class CreateNewAccountView extends StatefulWidget {
  const CreateNewAccountView({Key? key}) : super(key: key);
  @override
  CreateNewAccountState createState() => CreateNewAccountState();
}

class CreateNewAccountState extends State<CreateNewAccountView> {

  late StreamSubscription<ConnectivityResult> subscription;
  TypeView statusView = TypeView.viewLoading;
  final txtControlleNomeCompleto = TextEditingController();
  final txtControllerCPF = TextEditingController();
  final txtControllerEmail = TextEditingController();
  final txtControllerTelefoneFixo = TextEditingController();
  final txtControllerWhatsapp = TextEditingController();
  final txtControllerNomeDaEmpresa = TextEditingController();

  FocusNode? txtFocusNodeNomeCompleto;
  FocusNode? txtFocusNodeCPF;
  FocusNode? txtFocusNodeEmail;
  FocusNode? txtFocusNodeTelefoneFixo;
  FocusNode? txtFocusNodeWhatsapp;
  FocusNode? txtFocusNodeNomeDaEmpresa;

  List<Uf> listUf = [];

  onGetUfs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw 'Parece que você está sem internet 😑 !';
      } else {
        setState(() {
           statusView = TypeView.viewLoading;
        });
        Operation restWeb = await ServicoMobileService.onEnvironmentVariables();
        if (restWeb.erro)
          throw (restWeb.message!);
        else if (restWeb.result == null)
          throw (restWeb.message!);
        else {
          EnvironmentVariables result = restWeb.result as EnvironmentVariables;
          setState(() {
            listUf = result.uf!;
            statusView = TypeView.viewRenderInformation;
          });
        }
      }
    } catch (error) {
      Map<String, dynamic> map = {};
      map['view'] = 'CreateNewAccountView';
      map['error'] = error;
      Navigator.of(context).pushNamed(
        routes.errorInformationRoute,
        arguments: map,
      ).then((value) {
        onGetUfs();
      });
    }
  }


  @override
  void initState() {
    super.initState();
    onGetUfs();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
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
          title: const Text(
            "Registrar usuário",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),
        ),
        body: tipoPageView(MediaQuery.of(context).size.height),
      ),
    );
  }


  tipoPageView(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewRenderInformation:
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                'Nome completo',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: txtControlleNomeCompleto,
                  focusNode: txtFocusNodeNomeCompleto,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'avenir-lt-std-medium',
                      color: Color(0xFF000000)),
                  onSubmitted: (term) {
                    txtFocusNodeNomeCompleto!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeCPF);
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
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
                          fontSize: 16.0, color: Color(0xFF90ffffff)),
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
              const Text(
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
              TextField(
                  controller: txtControllerCPF,
                  focusNode: txtFocusNodeCPF,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    // obrigatório
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  onSubmitted: (term) {
                    txtFocusNodeCPF!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeTelefoneFixo);
                  },
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
              const SizedBox(
                height: 17.0,
              ),
              const Text(
                "E-mail",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  focusNode: txtFocusNodeEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    txtFocusNodeEmail!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeTelefoneFixo);
                  },
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
              TextField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  controller: txtControllerTelefoneFixo,
                  focusNode: txtFocusNodeTelefoneFixo,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    txtFocusNodeTelefoneFixo!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeWhatsapp);
                  },
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
              TextField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  controller: txtControllerWhatsapp,
                  focusNode: txtFocusNodeWhatsapp,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    txtFocusNodeWhatsapp!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeNomeDaEmpresa);
                  },
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
              TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: txtControllerNomeDaEmpresa,
                  focusNode: txtFocusNodeNomeDaEmpresa,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (term) {
                   // txtFocusNodeWhatsapp!.unfocus();
                   // FocusScope.of(context).requestFocus(txtFocusNodeNomeDaEmpresa);
                  },
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

              SizedBox(height: 40.0),
              Center(
                child: InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

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
        );
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.ErroInformacao,context);
    }
  }
}
