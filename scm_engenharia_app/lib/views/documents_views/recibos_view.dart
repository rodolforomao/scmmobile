import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../help/components.dart';
import '../../models/operation.dart';
import '../../models/notification_models/notification_model.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;

class RecibosDocumentosView extends StatefulWidget {
  const RecibosDocumentosView({Key? key}) : super(key: key);
  @override
  RecibosDocumentosState createState() => RecibosDocumentosState();
}

class RecibosDocumentosState extends State<RecibosDocumentosView> {

  List<NotificationScmEngineering> listNotificationScmEngineering = [];
  TypeView statusTypeView = TypeView.viewLoading;
  late List mapDocumentos = [];
  late bool isSearching = false;

  onGetDocumentsList() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        statusTypeView = TypeView.viewLoading;
        Operation resultRest = await ServicoMobileService.onGetDocumentsList();
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          setState(() {
            mapDocumentos =  resultRest.resultList;
            statusTypeView = TypeView.viewRenderInformation;
          });
        }
      }
    } catch (error) {
      setState(() {
        if (listNotificationScmEngineering.isNotEmpty) {
          statusTypeView = TypeView.viewRenderInformation;
          OnAlertError(error.toString());
        } else {
          statusTypeView = TypeView.viewErrorInformation;
          GlobalScaffold.erroInformacao = error.toString();
        }
      });
    }
  }

  onDownloadDocuments(String idDocumento) async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        OnRealizandoOperacao('Realizando operação',context);
        Operation resultRest = await ServicoMobileService.onDocumentsById(idDocumento).whenComplete(() => OnRealizandoOperacao('',context));
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          final _base64 = resultRest.result.toString();
          launchUrl(Uri.parse(_base64));
          //launchUrl(Uri.parse("data:application/octet-stream;base64,$_base64"));
          Components.downloadCompartilharArquivos(resultRest.result.toString(), 'recibo_', 'Recibo', 'Download','.pdf');
        }
      }
    } catch (error) {
      OnAlertError(error.toString());
    }
  }

  onInc() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
      {
        GlobalScaffold.instance.navigatorKey.currentState?.pushNamed(
          routes.erroInternetRoute,
        ).then((value) async {
          if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
            GlobalScaffold.instance.navigatorKey.currentState?.pushNamedAndRemoveUntil(routes.splashScreenRoute, (Route<dynamic> route) => false);
          }
          else
          {
            onInc();
          }
        });
      }
      else {
        onGetDocumentsList();
      }
    } catch (error) {
      GlobalScaffold.map = {
        'view': routes.recibosRoute,
        'error': error
      };
      Navigator.of(context).pushNamed(
        routes.errorInformationRoute,
        arguments: GlobalScaffold.map,
      ).then((value) {
        GlobalScaffold.instance.navigatorKey.currentState?.pushNamedAndRemoveUntil(routes.splashScreenRoute, (Route<dynamic> route) => false);
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

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: !isSearching
              ? const Text('Documentos')
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width:600, child: Theme(
                data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                child: Expanded(child: TextField(
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFFffffff)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff70ffffff),
                    hintStyle: const TextStyle(fontSize: 14.0, color: Color(0xff80ffffff)),
                    hintText: 'Razão social',
                    contentPadding: const EdgeInsets.fromLTRB(10.0, 9.0, 10.0, 11.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.9),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    icon: const Icon(
                      Icons.search,
                      size: 23,
                      color: Colors.white,
                    ),

                  ),
                  onChanged: (value) {
                    setState(() {

                    });
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());

                  },
                ),),
              ),),
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                  size: 23.0,
                ),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },),
            ],),
          actions: <Widget>[
            if(isSearching == false)...[
                 IconButton(
            icon: const Icon(
              Icons.search,
              size: 23,
            ),
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
          )
              ],

          ],
          toolbarHeight: 55,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }

  viewType(double maxHeight) {
    switch (statusTypeView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.erroInformacao,context);
      case TypeView.viewRenderInformation:
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(padding:  const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0, bottom: 5.0) , child: Card(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
          elevation: 5, child: Container(
            padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0, bottom: 10.0),
            constraints:  const BoxConstraints(
                minHeight: 500,
                maxWidth: 1000
            ),
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),child: Text(
                'contratos',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
              ),),
              const Padding(padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),child: Divider(color:Colors.black54),),
                Expanded(
                child:ListView.builder(
                  shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: mapDocumentos.length,
                itemBuilder: (context, index) {
                  return Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                          child: RichText(
                              textAlign: TextAlign.left,
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Razão social : ',
                                  style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 17),
                                ),
                                TextSpan(
                                  text: mapDocumentos[index]['razao_social'] ?? '',
                                  style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 16),
                                ),
                              ]))),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        child:  RichText(
                            textAlign: TextAlign.start,
                            softWrap: false,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Cnpj : ',
                                style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 17),
                              ),
                              TextSpan(
                                text: mapDocumentos[index]['cnpj'] ?? '',
                                style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 15),
                              ),
                            ])),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        child:  RichText(
                            textAlign: TextAlign.start,
                            softWrap: false,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Período referência: ',
                                style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 17),
                              ),
                              TextSpan(
                                text: Components.dateFormatDDMMYYYY(mapDocumentos[index]['periodo_referencia'])  ?? '',
                                style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 15),
                              ),
                            ])),),
                      Align(alignment: Alignment.bottomRight,child: Padding( padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0), child: IconButton(
                        icon: const Icon(Icons.download_outlined , size: 25,),
                        iconSize: 25.0,
                        color: Color(0xff606060), onPressed: () {
                        onDownloadDocuments(mapDocumentos[index]['id'] ?? '');
                      },
                      ),),),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Divider(
                            color: Color(0xff093d6c),
                          )),
                    ],),);
                },
              ) ,)
              ],),),),),);
    }
  }
}
