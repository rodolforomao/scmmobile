import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'dart:convert';
import '../../help/formatter/cpf_input_formatter.dart';
import '../../models/operation.dart';
import '../../models/output/output_environment_variables_model.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
import '../help_views/global_view.dart';


class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileView> {
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

  late Uf ufModel;
  List<Uf>? ufList;

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(() {
        OutputEnvironmentVariablesModel  resulEnvironmentVariables = OutputEnvironmentVariablesModel.fromJson(jsonDecode(response) as Map<String, dynamic>);
        ufList = resulEnvironmentVariables.uf;
        ufModel = resulEnvironmentVariables.uf!.first;
        ufModel = ufList!.where((c) => c.uf == global_user_logged.globalUserLogged!.uf).first;
        statusView = TypeView.viewRenderInformation;
      });

    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  onUpdate() async {
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
        } else if (ufModel.id!.isEmpty) {
          throw ("UF deve ser selecionada");
        }
        OnRealizandoOperacao('Realizando operação', true,context);
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
    } catch (error) {

      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  @override
  void initState() {
     onInc();
     txtControlleNomeCompleto.text = global_user_logged.globalUserLogged!.name;
     txtControllerCPF.text = global_user_logged.globalUserLogged!.cpf;
     txtControllerEmail.text = global_user_logged.globalUserLogged!.email;
     txtControllerTelefoneFixo.text = global_user_logged.globalUserLogged!.telephone;
     txtControllerWhatsapp.text = global_user_logged.globalUserLogged!.password;
     txtControllerNomeDaEmpresa.text = global_user_logged.globalUserLogged!.company;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: const Text(
          'Dados',
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewRenderInformation:
        return Container(
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
                    controller: txtControlleNomeCompleto,
                    focusNode: txtFocusNodeNomeCompleto,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      txtFocusNodeNomeCompleto!.unfocus();
                      FocusScope.of(context).requestFocus(txtFocusNodeCPF);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome completo',
                      hintText: 'Digite seu nome completo',
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                      hintText: 'Digite seu CPF',
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'Digite seu e-mail',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.phone,
                    controller: txtControllerTelefoneFixo,
                    focusNode: txtFocusNodeTelefoneFixo,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      txtFocusNodeTelefoneFixo!.unfocus();
                      FocusScope.of(context).requestFocus(txtFocusNodeWhatsapp);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Telefone fixo',
                      hintText: 'Digite telefone fixo',
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                    decoration: const InputDecoration(
                      labelText: 'Whatsapp',
                      hintText: 'Digite Whatsapp',
                    ),
                  ),
                  const SizedBox(height: 20.0),
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
                    decoration: const InputDecoration(
                      labelText: 'Nome da empresa',
                      hintText: 'avenir-lt-std-medium',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField<Uf>(
                    elevation: 7,
                    isExpanded: true,
                    isDense: true,
                    icon: const Icon(
                      Icons.expand_more,
                      size: 23,
                      color: Color(0xFFb8b8b8),
                    ),
                    decoration:  const InputDecoration(
                      filled: true,
                      labelText: 'Nome da estado',
                      hintText: 'Nome da estado',
                      //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                      border: InputBorder.none,
                      //focusColor: Colors.transparent,
                    ),
                    value: ufModel,
                    items: ufList!.map((v) => DropdownMenuItem<Uf>(
                          value: v,
                          child: Text(
                            v.uf!,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          )),).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        ufModel = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const SizedBox(height: 25.0),
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
                    child: const Text(' ATUALIZAR '),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      onUpdate();
                    },
                  ),),),
                  const SizedBox(height: 30.0),
                ],
              ),),
          ),
        );
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.erroInformacao,context);
    }
  }
}
