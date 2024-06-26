import 'dart:convert';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/components.dart';
import '../../help/parameter_result_view.dart';
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';


class RecibosDocumentosView extends StatefulWidget {
  const RecibosDocumentosView({super.key});
  @override
  RecibosDocumentosState createState() => RecibosDocumentosState();
}

class RecibosDocumentosState extends State<RecibosDocumentosView> with ParameterView, ParameterResultViewEvent , ParameterResultFunctions {

  onGetDocumentsList() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        setState(() =>  statusTypeView = TypeView.viewLoading);
        Operation resultRest = await ServicoMobileService.onGetDocumentsList();
        if (resultRest.erro || resultRest.result == null) {
          throw (resultRest.message!);
        } else {
          if(resultRest.resultList.isEmpty)
            {
              throw ("Nenhum registro encontrado para esta solicitação");
            }
          else
            {
              setState(() {
                mapDocumentos = [];
                 mapDocumentos =  resultRest.resultList;
                 statusTypeView = TypeView.viewRenderInformation;
              });
            }
        }
      }
    } catch (error) {
      setState(() {
        if (mapDocumentos.isNotEmpty) {
          statusTypeView = TypeView.viewRenderInformation;
          OnAlert.onAlertError(context, error.toString());
        } else {
          statusTypeView = TypeView.viewErrorInformation;
          erroInformation = error.toString();
        }
      });
    }
  }

  onDownloadDocuments(String idDocumento ,String nomeArquivo) async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        OnRealizandoOperacao('Realizando operação',context);
        Operation resultRest = await ServicoMobileService.onDocumentsById(idDocumento).whenComplete(() => OnRealizandoOperacao('',context));
        if (resultRest.erro  == true || resultRest.result == null) {
          throw (resultRest.message!);
        } else {
          Uint8List bytes= base64.decode(resultRest.result.toString());
          Operation respSaveLocation = await Components.onSaveLocation('application/${nomeArquivo.split('.').last}',nomeArquivo,bytes);
          if (respSaveLocation.erro || respSaveLocation.result == null) {
            throw respSaveLocation.message!;
          } else {
            GlobalScaffold.instance.onToastSuccess(respSaveLocation.message!);
          }
        }
      }
    } catch (error) {
      OnAlert.onAlertError(context, error.toString());
    }
  }

  onInc() async {
    try {
      if (await onIncConnectivity()) {
        onGetDocumentsList();
      } else {
        GlobalScaffold.instance.navigatorKey.currentState?.popUntil((route) => route.isFirst);
        GlobalScaffold.instance.onToastInternetConnection();
      }
    } catch (error) {
      onError(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() =>  statusTypeView = TypeView.viewLoading);
    onInc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
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
        return GlobalView.viewErrorInformation(maxHeight,erroInformation,context);
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
                style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
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
                                  style: StylesThemas.textStyleTextSpanTitle(),
                                ),
                                TextSpan(
                                  text: mapDocumentos[index]['razao_social'] ?? '',
                                    style: StylesThemas.textStyleTextSpanSubtitle()
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
                                style: StylesThemas.textStyleTextSpanTitle(),
                              ),
                              TextSpan(
                                text: mapDocumentos[index]['cnpj'] ?? '',
                                  style: StylesThemas.textStyleTextSpanSubtitle()
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
                                style: StylesThemas.textStyleTextSpanTitle(),
                              ),
                              TextSpan(
                                text: Components.dateFormatDDMMYYYY(mapDocumentos[index]['periodo_referencia'])  ?? '',
                                  style: StylesThemas.textStyleTextSpanSubtitle()
                              ),
                            ])),),
                      Align(alignment: Alignment.bottomRight,child: Padding( padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0), child: IconButton(
                        icon: const Icon(Icons.download_outlined , size: 25,),
                        iconSize: 25.0,
                        color: Color(0xff606060), onPressed: () {
                          if(Components.onIsEmpty(mapDocumentos[index]['id']) == '' || Components.onIsEmpty(mapDocumentos[index]['arquivo']) == '')
                            {
                              GlobalScaffold.instance.onToastSuccess('Não foi Possível Realizar o Download');
                            }
                          else
                            {
                              onDownloadDocuments(mapDocumentos[index]['id'], mapDocumentos[index]['arquivo']);
                            }
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
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }
}

mixin class ParameterView  {

  late List mapDocumentos = [];
  late bool isSearching = false;

}