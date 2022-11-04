import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../models/operation.dart';
import '../../models/output/output_environment_variables_model.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';

class VariaveisDeAmbienteView extends StatefulWidget {
  const VariaveisDeAmbienteView({Key? key}) : super(key: key);
  @override
  VariaveisDeAmbienteState createState() => VariaveisDeAmbienteState();
}

class VariaveisDeAmbienteState extends State<VariaveisDeAmbienteView> {

  TypeView statusView = TypeView.viewLoading;

  onEnvironmentVariables() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertaInformacaoErro('Verifique sua conexão com a internet e tente novamente.',context);
      } else {
        OnRealizandoOperacao('Realizando operação', true,context);
        Operation resultRest = await ServicoMobileService.onEnvironmentVariables().whenComplete(() =>  OnRealizandoOperacao('', false,context));
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          write(resultRest.result.toString());
        }
      }
    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(()  {
        OutputEnvironmentVariablesModel resul = OutputEnvironmentVariablesModel.fromJson(jsonDecode(response) as Map<String, dynamic>);
        statusView = TypeView.viewRenderInformation;
      });
    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.erroInformacao = error.toString();
      });
    }
  }

//gravar/substituir dados em um arquivo de texto
  write(String content) async {
    try {
      OnRealizandoOperacao('Gravando Dados', true,context);
      final directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/variavel_de_ambiente.json');
      await file.writeAsString(content);
      OnRealizandoOperacao('', false,context);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Configurações'),
        toolbarHeight: 80,
        flexibleSpace: const Image(
          image: AssetImage('assets/img/fundo_tela_configuracoes.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.erroInformacao,context);
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
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -140,
                child: SingleChildScrollView(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child: Text(
                      'Configurações',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
                    ),),
                    const Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),child: Divider(color:Colors.black54),),
                    Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child: Image.asset(
                          "assets/img/img_integracao.png",
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.fill,
                        ),),
                        const Padding(padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child:  Text(
                          'variáveis de ambiente',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: "avenir-lt-std-roman",
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),),
                        const Padding(padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child:Text(
                          "Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: "avenir-lt-std-roman",
                            fontSize: 15.0,
                            color: Colors.black54,
                          ),),),
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
                            onEnvironmentVariables();
                          },
                        ),),),
                      ],
                    ),),
                  ],
                ),)),));
    }
  }
}
