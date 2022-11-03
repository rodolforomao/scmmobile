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

  static List<String> friendsList = [];

  late TextEditingController _nameController;

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
    _nameController =  TextEditingController();
    // upon creation, copy the starting count to the current count
    fieldCount = 1;
    //onInc();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  void didUpdateWidget(CreateNewAccountView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // generate the list of TextFields
    final List<Widget> children = _buildList();
    // append an 'add player' button to the end of the list
    children.add(
        Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: (){
                // when adding a player, we only need to inc the fieldCount, because the _buildList()
                // will handle the creation of the new TextEditingController
                setState(() {
                  fieldCount++;
                });
              },
              icon: Icon(Icons.add ,color: Color(0xffef7d00),),
            ),
          ],),)

    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:  const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        toolbarHeight: 120,
        actions: [
          Padding(padding: const EdgeInsets.fromLTRB(20.0,50.0,20.0,10.0), child: Image.asset(
              'assets/img/logo-smc-fundo-branco.png',
              height: 20,
              fit: BoxFit.fill,
              colorBlendMode: BlendMode.dstIn
          ),)
        ],
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
        child: Container(
          constraints:  BoxConstraints(
            minHeight: 500,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child:  Container(constraints: const BoxConstraints(
            maxWidth: 1000,
          ),child:  Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding( padding: const EdgeInsets.fromLTRB(10,10,10,10) ,child:     Text('nava conta',style:Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22,color:  Colors.black54,),),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {

                  },
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  decoration: const InputDecoration(
                    contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    labelText: "nome",
                    hintText: "Digite seu nome",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    labelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF65100),),
                    ),
                  )),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {

                  },
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  decoration: const InputDecoration(
                    contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    labelText: "e-mail",
                    hintText: "Digite seu e-mail",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    labelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF65100),),
                    ),
                  )),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {

                  },
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  decoration: const InputDecoration(
                    contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    labelText: "cpf",
                    hintText: "Digite seu cpf",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    labelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF65100),),
                    ),
                  )),),
              Card(child: Padding( padding: const EdgeInsets.fromLTRB(15.0,10.0,15.0,10.0),child:  Column(children: [
                Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: txtControllerEmail,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {

                    },
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF323232)),
                    decoration: const InputDecoration(
                      contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
                      filled: true,
                      fillColor: Color(0xFFf5f5f5),
                      labelText: "Senha",
                      hintText: "Digite seu senha",
                      hintStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w200,
                          color:  Colors.black54),
                      labelStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w200,
                          color:  Colors.black54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF65100),),
                      ),
                    )),),
                Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: txtControllerEmail,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {

                    },
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF323232)),
                    decoration: const InputDecoration(
                      contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
                      filled: true,
                      fillColor: Color(0xFFf5f5f5),
                      labelText: "confirme sua senha",
                      hintText: "Confirme sua senha",
                      hintStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w200,
                          color:  Colors.black54),
                      labelStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w200,
                          color:  Colors.black54),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF65100),),
                      ),
                    )),),
              ],),),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {

                  },
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  decoration: const InputDecoration(
                    contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    labelText: "cnpj",
                    hintText: "Digite seu cnpj",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    labelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF65100),),
                    ),
                  )),),
              ListView(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: children,
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                style: TextButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  elevation: 0,
                  backgroundColor: const Color(0xffef7d00),
                  padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                  minimumSize: const Size(350, 50),
                  maximumSize: const Size(350, 50),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color:  Color(0xffFFFFFF),
                    fontSize: 15,
                  ),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: Text(
                    'Recuperar senha',
                    style:  TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                onPressed: () async {

                },
              ),
              const SizedBox(height: 25.0),
            ],
          ),),),),
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
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.erroInformacao,context);
    }
  }


  //region ADD CNPjs

  int fieldCount = 0;
  int nextIndex = 0;
  // you must keep track of the TextEditingControllers if you want the values to persist correctly
  List<TextEditingController> controllers = <TextEditingController>[];

  // create the list of TextFields, based off the list of TextControllers
  List<Widget> _buildList() {
    int i;
    // fill in keys if the list is not long enough (in case we added one)
    if (controllers.length < fieldCount) {
      for (i = controllers.length; i < fieldCount; i++) {
        controllers.add(TextEditingController());
      }
    }

    i = 0;
    // cycle through the controllers, and recreate each, one per available controller
    return controllers.map<Widget>((TextEditingController controller) {
      int displayNumber = i + 1;i++;
      return TextField(
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          controller: txtControllerEmail,
          textInputAction: TextInputAction.next,
          onSubmitted: (term) {

          },
          style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins-Regular',
              fontWeight: FontWeight.w100,
              color: Color(0xFF323232)),
          decoration:  InputDecoration(
            counterText: "",
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                // when removing a TextField, you must do two things:
                // 1. decrement the number of controllers you should have (fieldCount)
                // 2. actually remove this field's controller from the list of controllers
                setState(() {
                  fieldCount--;
                  controllers.remove(controller);
                });
              },
            ),
            contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
            filled: true,
            fillColor: Color(0xFFf5f5f5),
            labelText: "cnpj $displayNumber",
            hintText: "Digite seu cnpj",
            hintStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins-Medium',
                fontWeight: FontWeight.w200,
                color:  Colors.black54),
            labelStyle: TextStyle(
                fontSize: 13,
                fontFamily: 'Poppins-Medium',
                fontWeight: FontWeight.w200,
                color:  Colors.black54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF65100),),
            ),
          ));
      return TextField(
        controller: controller,
        maxLength: 20,
        decoration: InputDecoration(
          labelText: "Player $displayNumber",
          counterText: "",
          prefixIcon: const Icon(Icons.person),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              // when removing a TextField, you must do two things:
              // 1. decrement the number of controllers you should have (fieldCount)
              // 2. actually remove this field's controller from the list of controllers
              setState(() {
                fieldCount--;
                controllers.remove(controller);
              });
            },
          ),
        ),
      );
    }).toList(); // convert to a list
  }

//endregion
}



