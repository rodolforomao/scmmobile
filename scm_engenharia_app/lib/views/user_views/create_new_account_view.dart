import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:async';
import '../../help/formatter/cpf_input_formatter.dart';
import '../../models/operation.dart';
import '../../models/output/output_environment_variables_model.dart';
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
  OutputEnvironmentVariablesModel resulEnvironmentVariables = OutputEnvironmentVariablesModel();

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

  Uf ufModel = Uf();

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(() {
        resulEnvironmentVariables = OutputEnvironmentVariablesModel.fromJson(jsonDecode(response) as Map<String, dynamic>);
        ufModel = resulEnvironmentVariables.uf!.first;
        statusView = TypeView.viewRenderInformation;
      });

    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

    OnSaveAccount() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertaInformacaoErro('Verifique sua conexão com a internet e tente novamente.',context);
      }  else {
        if (txtControlleNomeCompleto.text.isEmpty) {
          throw ("Nome é obrigatório");
        } else if (txtControllerCPF.text.isEmpty) {
          throw ("CPF é obrigatório");
        } else if (txtControllerEmail.text.isEmpty) {
          throw ("Email é obrigatório");
        } else if (txtControllerTelefoneFixo.text.isEmpty) {
          throw ("Telefone é obrigatório");
        } else if (txtControllerWhatsapp.text.isEmpty) {
          throw ("Telefone Whatsapp é obrigatório");
        } else if (txtControllerNomeDaEmpresa.text.isEmpty) {
          throw ("Empresa é obrigatório");
        } else if (ufModel.uf!.isEmpty) {
          throw ("UF deve ser selecionada");
        }
        else
          {
            Operation restWeb = await ServicoMobileService.onRegisterUser(txtControlleNomeCompleto.text,txtControllerCPF.text,txtControllerEmail.text,txtControllerTelefoneFixo.text,txtControllerWhatsapp.text,txtControllerNomeDaEmpresa.text,ufModel.id!).whenComplete(() =>
                OnRealizandoOperacao('', false,context)
            );
            if (restWeb.erro || restWeb.result == null) {
              throw (restWeb.message!);
            }
            else {
              OnAlertaInformacaoSucesso(restWeb.message!,context);
            }
          }
      }
    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  @override
  void initState() {
    super.initState();
    onInc();
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
            'Registrar usuário',
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
          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Nome completo',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: txtControlleNomeCompleto,
                  focusNode: txtFocusNodeNomeCompleto,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    txtFocusNodeNomeCompleto!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeCPF);
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                      border: InputBorder.none,
                      fillColor: Color(0xff80ff9b7b),
                      filled: true,
                      hintText: 'Digite seu nome completo',
                    )),),
              const Text(
                "CPF",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
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
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                    border: InputBorder.none,
                    fillColor: Color(0xff80ff9b7b),
                    filled: true,
                      hintText: 'Digite seu CPF',
                 )),),
              const Text(
                'E-mail',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  focusNode: txtFocusNodeEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    txtFocusNodeEmail!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeTelefoneFixo);
                  },
                  decoration:  const InputDecoration(
                      hintText: 'Digite seu e-mail',
                      contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                      border: InputBorder.none,
                      fillColor: Color(0xff80ff9b7b),
                      filled: true
                  )

              ),),
              const Text(
                'Telefone fixo',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child:TextField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  controller: txtControllerTelefoneFixo,
                  focusNode: txtFocusNodeTelefoneFixo,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    txtFocusNodeTelefoneFixo!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeWhatsapp);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                    border: InputBorder.none,
                    fillColor: Color(0xff80ff9b7b),
                    filled: true,
                      hintText: 'Digite telefone fixo',
                    )),),
              const Text(
                'Whatsapp',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  controller: txtControllerWhatsapp,
                  focusNode: txtFocusNodeWhatsapp,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    txtFocusNodeWhatsapp!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeNomeDaEmpresa);
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                    border: InputBorder.none,
                    fillColor: Color(0xff80ff9b7b),
                    filled: true,
                      hintText: 'Digite Whatsapp',
                     )),),
              const Text(
                "Nome da empresa",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child:  TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: txtControllerNomeDaEmpresa,
                  focusNode: txtFocusNodeNomeDaEmpresa,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (term) {
                    // txtFocusNodeWhatsapp!.unfocus();
                    // FocusScope.of(context).requestFocus(txtFocusNodeNomeDaEmpresa);
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 14.0, 10.0, 12.0),
                      border: InputBorder.none,
                      fillColor: Color(0xff80ff9b7b),
                      filled: true,
                      hintText: 'Digite o nome da empresa')),),
              const Text(
                'Selecione a UF',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: "avenir-lt-std-roman",
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: SizedBox(
                  height: 50.0,
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
                            child: DropdownButton<Uf>(
                              hint: const Text(
                                "Selecione ..",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF90ffffff)),
                              ),
                              elevation: 16,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000)),
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              value: ufModel,
                              isExpanded: true,
                              iconSize: 35,
                              items: resulEnvironmentVariables.uf!.map((v) => DropdownMenuItem<Uf>(
                                  value: v,
                                  child: Text(
                                    v.uf!,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,
                                  )),).toList(),
                              onChanged: ( newValue) {
                                setState(() {
                                  ufModel = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )),),
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                  minimumSize: const Size(200, 47),
                  maximumSize: const Size(200, 47),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color:  Color(0xffFFFFFF),
                    fontSize: 15,
                  ),
                ),
                child: const Text(' REGISTRAR '),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  OnSaveAccount();
                },
              ),),),
            ],
          ),
        );
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.ErroInformacao,context);
    }
  }
}
