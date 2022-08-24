import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../models/output/environment_variables.dart';
import '../../models/operation.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'package:flutter/services.dart';

class EnvironmentVariableView extends StatefulWidget {
  const EnvironmentVariableView({Key? key}) : super(key: key);
  @override
  EnvironmentVariableState createState() => EnvironmentVariableState();
}

class EnvironmentVariableState extends State<EnvironmentVariableView>  {

  TypeView statusView = TypeView.viewLoading;

  onIncOld() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertaInformacaoErro('Verifique sua conexão com a internet e tente novamente.',context);
      } else {
        setState((){statusView = TypeView.viewLoading;});
        final String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
        Operation resultRest = await ServicoMobileService.onEnvironmentVariables();
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          setState(() {
            EnvironmentVariables resul = EnvironmentVariables.fromJson(response as Map<String, dynamic>);
            statusView = TypeView.viewRenderInformation;
          });
        }
      }
    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.ErroInformacao = error.toString();
      });
    }
  }

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(()  {
        EnvironmentVariables resul = EnvironmentVariables.fromJson(jsonDecode(response) as Map<String, dynamic>);
        statusView = TypeView.viewRenderInformation;
      });
    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.ErroInformacao = error.toString();
      });
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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Variável de ambiente',
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.ErroInformacao,context);
      case TypeView.viewRenderInformation:
        return  SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/img/img_integracao.png",
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 30.0),
                Text(
                  "variáveis de ambiente",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10.0),
                const Text(
                  "Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),),
                SizedBox(height: 20.0),
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

                  },
                ),),),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        );
    }
  }
}

