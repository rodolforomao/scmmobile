import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_environment_variable.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../help/parameter_result_view.dart';
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';

class VariaveisDeAmbienteView extends StatefulWidget {
  const VariaveisDeAmbienteView({super.key});
  @override
  VariaveisDeAmbienteState createState() => VariaveisDeAmbienteState();
}

class VariaveisDeAmbienteState extends State<VariaveisDeAmbienteView> with ParameterResultViewEvent {

  TypeView statusView = TypeView.viewLoading;
  TbEnvironmntVariable? inputEnvironmntVariable;

  onEnvironmentVariables() async {
    try {
      if (await (Connectivity().checkConnectivity().asStream()).contains(ConnectivityResult.none)) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        OnRealizandoOperacao('Realizando operação',context);
        Operation resultRest = await ServicoMobileService.onEnvironmentVariables().whenComplete(() =>  OnRealizandoOperacao('',context));
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          GlobalScaffold.instance.onToastPerformingOperation('Gravando Dados');
          if(inputEnvironmntVariable == null)
            {
              inputEnvironmntVariable = TbEnvironmntVariable(ObjectId(),resultRest.result.toString() ?? "");
            }
          else
            {
              inputEnvironmntVariable = TbEnvironmntVariable(inputEnvironmntVariable!.idEnvironmntVariableApp,resultRest.result.toString() ?? "");
            }
          Operation respFormSiciFust = await AppScmEngenhariaMobileBll.instance.onSaveUpdateEnvironmentVariable(inputEnvironmntVariable!).whenComplete(() => GlobalScaffold.instance.onHideCurrentSnackBar());
          if (respFormSiciFust.erro) {
            throw respFormSiciFust.message!;
          } else if (respFormSiciFust.result == null) {
            throw respFormSiciFust.message!;
          } else {
            setState(() {
              inputEnvironmntVariable = respFormSiciFust.result as TbEnvironmntVariable;
              statusView = TypeView.viewRenderInformation;
              erroInformation = 'Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.';
            });
            showDialog(
              context: GlobalScaffold.instance.navigatorKey.currentContext!,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 70,
                        maxWidth: 600,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Informação',
                                style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20, color: const Color(0xff737373),fontWeight: FontWeight.w200,),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: Colors.black12,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                child: Text(
                                  respFormSiciFust.message!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  softWrap: false,
                                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15, color: const Color(0xff737373),fontWeight: FontWeight.w100,),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black12,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                            child:Center(child:  OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor:  const Color(0xff2ecd8f),
                                side: const BorderSide(
                                  color: Color(0xff2ecd8f), //Color of the border
                                  style: BorderStyle.solid, //Style of the border
                                  width: 1.0, //width of the border
                                ),
                              ),
                              child:  const Text('OK' ,style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),),
                              //`Text` to display
                              onPressed: () {
                                Navigator.pop(context);
                                //GlobalScaffold.instance.navigatorKey.currentState?.pop(true);
                              },
                            ),),
                          ),
                        ],
                      ),
                    ));
              },
            );
          }
        }
      }
    } catch (error) {
      GlobalScaffold.instance.onHideCurrentSnackBar();
      OnAlert.onAlertError(context,error.toString());
    }
  }

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      Operation respEnvironmentVariable = await AppScmEngenhariaMobileBll.instance.onSelectEnvironmentVariableAll();
      if (respEnvironmentVariable.erro) {
        throw respEnvironmentVariable.message!;
      } else if (respEnvironmentVariable.result == null) {
        setState(() {
          statusView = TypeView.viewRenderInformation;
          erroInformation = respEnvironmentVariable.message!;
        });
      } else {
        setState(() {
          inputEnvironmntVariable = respEnvironmentVariable.result as TbEnvironmntVariable;
          statusView = TypeView.viewRenderInformation;
          erroInformation = respEnvironmentVariable.message!;
        });
      }
    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        erroInformation = error.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      erroInformation = 'Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.';
    });

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
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,erroInformation,context);
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
                child: SingleChildScrollView(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child: Text(
                      'Configurações',
                      style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
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
                         Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child:Text(erroInformation,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                          child: const Text(' ATUALIZAR ', style:  TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins-Regular',
                            color: Color(0xFFffffff),
                          ),),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            onEnvironmentVariables();
                          },
                        ),),),
                      ],
                    ),),
                  ],
                ),)),));
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }
}
