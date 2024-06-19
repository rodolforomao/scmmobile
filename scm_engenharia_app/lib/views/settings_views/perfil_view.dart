import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../help/formatter/cpf_input_formatter.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../help/parameter_result_view.dart';
import '../../models/operation.dart';
import '../../models/output/output_environment_variables_model.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;

import '../help_views/global_view.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});
  @override
  PerfilState createState() => PerfilState();
}

class PerfilState extends State<PerfilView> with ParameterResultViewEvent {

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
        if(global_user_logged.globalUserLogged != null)
        {
          ufModel = ufList!.where((c) => c.uf == global_user_logged.globalUserLogged!.uf).first;
        }
        statusView = TypeView.viewRenderInformation;
      });

    } catch (error) {
      OnAlert.onAlertError(context,error.toString());
    }
  }

  onUpdate() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
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
        OnRealizandoOperacao('Realizando operação',context);
        Operation restWeb = await ServicoMobileService.onRegisterUser(txtControlleNomeCompleto.text,txtControllerCPF.text,txtControllerEmail.text,txtControllerTelefoneFixo.text,txtControllerWhatsapp.text,txtControllerNomeDaEmpresa.text,ufModel.id!).whenComplete(() =>
            OnRealizandoOperacao('',context)
        );
        if (restWeb.erro || restWeb.result == null) {
          throw (restWeb.message!);
        }
        else {

        }
      }
    } catch (error) {
      OnAlert.onAlertError(context,error.toString());
    }
  }

  @override
  void initState() {
     onInc();
    if(global_user_logged.globalUserLogged != null)
      {
         txtControlleNomeCompleto.text = global_user_logged.globalUserLogged!.name;
         txtControllerCPF.text = global_user_logged.globalUserLogged!.cpf;
         txtControllerEmail.text = global_user_logged.globalUserLogged!.email;
         txtControllerTelefoneFixo.text = global_user_logged.globalUserLogged!.telephone;
         txtControllerWhatsapp.text = global_user_logged.globalUserLogged!.password;
         txtControllerNomeDaEmpresa.text = global_user_logged.globalUserLogged!.company;
      }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Configurações',
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
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
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0, bottom: 10.0),
              constraints:  BoxConstraints(
                minHeight: 500,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -140,
            child:SingleChildScrollView(child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child: Text(
                  'Meu Perfil',
                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
                ),),
                const Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),child: Divider(color:Colors.black54),),

                Padding(padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: txtControlleNomeCompleto,
                  focusNode: txtFocusNodeNomeCompleto,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  onSubmitted: (term) {
                    txtFocusNodeNomeCompleto!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeCPF);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    hintText: 'Digite seu nome completo',
                  ),
                ),),
                Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                  controller: txtControllerCPF,
                  focusNode: txtFocusNodeCPF,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
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
                ),),
                Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  focusNode: txtFocusNodeEmail,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  onSubmitted: (term) {
                    txtFocusNodeEmail!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeTelefoneFixo);
                  },
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Digite seu e-mail',
                  ),
                ),),
                Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  controller: txtControllerTelefoneFixo,
                  focusNode: txtFocusNodeTelefoneFixo,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  onSubmitted: (term) {
                    txtFocusNodeTelefoneFixo!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeWhatsapp);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Telefone fixo',
                    hintText: 'Digite telefone fixo',
                  ),
                ),),
                Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  controller: txtControllerWhatsapp,
                  focusNode: txtFocusNodeWhatsapp,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  onSubmitted: (term) {
                    txtFocusNodeWhatsapp!.unfocus();
                    FocusScope.of(context).requestFocus(txtFocusNodeNomeDaEmpresa);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Whatsapp',
                    hintText: 'Digite Whatsapp',
                  ),
                ),),
                Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child:  TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  controller: txtControllerNomeDaEmpresa,
                  focusNode: txtFocusNodeNomeDaEmpresa,
                  textInputAction: TextInputAction.go,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  onSubmitted: (term) {
                    // txtFocusNodeWhatsapp!.unfocus();
                    // FocusScope.of(context).requestFocus(txtFocusNodeNomeDaEmpresa);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome da empresa',
                    hintText: 'Digite nome da empresa',
                  ),
                ),),
                Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: DropdownButtonFormField<Uf>(
                  elevation: 7,
                  isExpanded: true,
                  isDense: true,
                  icon: const Icon(
                    Icons.expand_more,
                    size: 23,
                    color: Color(0xFFb8b8b8),
                  ),
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
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
                ),),
                Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),child:   Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [TextButton(
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
                    child: const Text(' ATUALIZAR ',style:  TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins-Regular',
                      color: Color(0xFFffffff),
                    ),),
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      onUpdate();
                    },
                  )],),)
              ],
            ),),),),
        );
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,erroInformation,context);
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }
}
