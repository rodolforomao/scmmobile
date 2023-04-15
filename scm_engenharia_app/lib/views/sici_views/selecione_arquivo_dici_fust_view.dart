import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../help/components.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';

class SelecioneArquivoDiciFustView extends StatefulWidget {
  const SelecioneArquivoDiciFustView({Key? key}) : super(key: key);
  @override
  SelecioneArquivoDiciFustState createState() => SelecioneArquivoDiciFustState();
}

class SelecioneArquivoDiciFustState extends State<SelecioneArquivoDiciFustView> {

  TypeView statusView = TypeView.viewRenderInformation;
  TextEditingController txtArquivo = TextEditingController();
  Uint8List bytesPdf = Uint8List(0);

  onUpload() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        GlobalScaffold.instance.onToastPerformingOperation('Sincronizando ... ');
        Operation resultRest = await ServicoMobileService.onCancelAccess('898').whenComplete(() => GlobalScaffold.instance.onHideCurrentSnackBar());
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {

        }
      }
    } catch (error) {
      OnAlertError(error.toString());
    }
  }

  onEscolherArquivo()  {
    FocusScope.of(context).requestFocus(FocusNode());
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) =>
            CupertinoActionSheet(
              title:  Text(
                'Selecione o arquivo',
                textAlign: TextAlign.center,
                softWrap: false,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20,color: const Color(0xff437DC0)),
              ),
              // message: const Text('Your options are '),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child:  Text('Arquivo',
                    textAlign:
                    TextAlign.start,
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15),
                  ),
                  onPressed: () async {
                    try {
                      Map<String, dynamic> mapFilePdf  = await Components.openDiciFile();
                      Navigator.pop(context, '');
                      if(mapFilePdf.values.isNotEmpty)
                      {
                        txtArquivo.text = mapFilePdf['name'];
                        bytesPdf = Uint8List.fromList(File(mapFilePdf['path']).readAsBytesSync());
                      }
                      else
                      {
                        throw ('Não foi possível realizar a operação.');
                      }
                    } catch (error) {
                      GlobalScaffold.instance.onToastError(error.toString());
                    }
                  },
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(
                        context, 'Cancelar');
                  },
                  child:  Text('Cancelar',
                    textAlign: TextAlign.start,
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15,color:  Colors.red),
                  )),
            ));
  }

  onInc() async {
    try {

    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.erroInformacao = error.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      GlobalScaffold.erroInformacao = 'Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.';
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
            'Envio arquivo Dici',
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
                  padding: const EdgeInsets.only(top: 10.0, right: 0.0, left: 0.0, bottom: 10.0),
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
                        'Arquivo',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
                      ),),
                      const Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),child: Divider(color:Colors.black54),),
                      Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          const Padding(padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child:Text('Selecione o arquivo Dici',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'avenir-lt-std-roman',
                              fontSize: 15.0,
                              color: Colors.black54,
                            ),),),
                          Center(child: Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: Card(
                            elevation: 5,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                              ),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 20.0, 10.0),
                                  constraints: const BoxConstraints(
                                    maxWidth: 1000,
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: txtArquivo,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        onTap: () {
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          txtArquivo.text = '';
                                          bytesPdf =  Uint8List(0);
                                          onEscolherArquivo();
                                        },
                                        style: StylesThemas.textStyleTextField(),
                                        decoration:  InputDecoration(
                                          suffixIcon: IconButton(
                                            icon:  const Icon(Icons.folder_open,size: 20),
                                            onPressed: () {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              txtArquivo.text = '';
                                              bytesPdf =  Uint8List(0);
                                              onEscolherArquivo();
                                            },
                                          ),
                                          hintText: 'Escolher arquivo',
                                          labelText: 'Escolher arquivo',
                                        ),

                                      ),
                                      Align(alignment: Alignment.bottomRight,child: Padding( padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 20.0), child:  ElevatedButton(
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
                                            'Upload',
                                            style:  TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color:  Color(0xffFFFFFF),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {

                                        },
                                      ),),),
                                    ],
                                  ),
                                ),

                              ],),
                            ),
                          ),),),
                        ],
                      ),),
                    ],
                  ),)),));
    }
  }
}
