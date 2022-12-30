import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_form_sici_fust.dart';
import '../../models/operation.dart';
import '../../models/input/input_sici_fust_form_model.dart';
import '../../models/output/output_sici_fust_model.dart';
import '../../models/parse_resp_json_to_view.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'formulario_sici_fust_view.dart';


class ListFormularioSiciFustView extends StatefulWidget {
  const ListFormularioSiciFustView({Key? key}) : super(key: key);
  @override
  ListFormularioSiciFustState createState() => ListFormularioSiciFustState();
}

class ListFormularioSiciFustState extends State<ListFormularioSiciFustView> {

  List<InputSiciFileModel> siciFileModelAllList = [];
  List<InputSiciFileModel> siciFileModelUpdateList = [];


  TypeView statusView = TypeView.viewLoading;
  final txtSocialReason = TextEditingController();

  onRestWeb() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        throw ('Verifique sua conexão com a internet e tente novamente.');
      } else {
        GlobalScaffold.instance.onToastPerformingOperation('Web: Buscando lançamentos ... ');
        Operation resultRest = await ServicoMobileService.onRecoversSiciReleases().whenComplete(() => GlobalScaffold.instance.onHideCurrentSnackBar());
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          List<OutputSiciFustFormModel> respSiciFustFormList  = resultRest.resultList.map<OutputSiciFustFormModel>((json) => OutputSiciFustFormModel.fromJson(json)).toList();
          List<OutputSiciFustFormModel> respNewSiciFustFormList = [];
          if (respSiciFustFormList.isNotEmpty) {
            for (var prop in respSiciFustFormList) {
              if (siciFileModelAllList.where((f) => f.id!.startsWith(prop.id!)).isNotEmpty)
              {
                // A ficha  ja esta salva no dispositivo
              }
              else
              {
                respNewSiciFustFormList.add(prop);
              }
            }
            List<InputSiciFileModel>  siciFileModelAllResp = await  ParseRespJsonToView.parseSiciFustFormModelToSiciFileList(respNewSiciFustFormList);
            setState(()  {
              siciFileModelAllList.addAll(siciFileModelAllResp);
              siciFileModelUpdateList.addAll(siciFileModelAllResp);
              statusView = TypeView.viewRenderInformation;
            });
          }
        }
      }
    } catch (error) {
      OnAlertError(error.toString());
    }
  }

  onRestDb() async {
    try {
      setState(() {statusView = TypeView.viewLoading;});
      Operation respUser = await AppScmEngenhariaMobileBll.instance.onSelectFormSiciFustAll();
      if (respUser.erro) {
        throw respUser.message!;
      } else if (respUser.result != null) {
        List<TbFormSiciFust> res =  respUser.result as  List<TbFormSiciFust>;
        siciFileModelAllList = await  ParseRespJsonToView.parseDbLOcalSiciFustFormModelToSiciFileList(res);
        siciFileModelUpdateList = siciFileModelAllList;
        if(siciFileModelAllList.isEmpty)
        {
          throw ('Não é possível converter as informações');
        }
        setState(() {statusView = TypeView.viewRenderInformation;});
        onRestWeb();
      } else {
        setState(() {
          statusView = TypeView.viewErrorInformation;
          GlobalScaffold.erroInformacao = 'Não há registros salvos no celular';
        });
        onRestWeb();
      }
    } catch (error, s) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.erroInformacao = error.toString();
      });
    }
  }

  onUpload(InputSiciFileModel siciFileModel) async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        GlobalScaffold.instance.onToastPerformingOperation('Sincronizando ... ');
        Operation resultRest = await ServicoMobileService.onMakeReleasesSici(siciFileModel).whenComplete(() => GlobalScaffold.instance.onHideCurrentSnackBar());
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          Operation respUser = await AppScmEngenhariaMobileBll().onDeleteFormSiciFustId(siciFileModel.idFichaSiciApp.toString());
          if (respUser.erro || respUser.result == null) {
            throw respUser.message!;
          } else {
            setState(() {
              siciFileModelAllList.remove(siciFileModel);
            });
            GlobalScaffold.instance.onToastSuccess(resultRest.message!);
            onRestWeb();
          }
        }
      }
    } catch (error) {
      OnAlertError(error.toString());
    }
  }

  selectPopupMenuButton() => PopupMenuButton(
        icon: const Icon(Icons.filter_list, color: Color(0xFFFFFFFF), size: 25),
        onSelected: (value) async {
          try {
            setState(() {
              if(value == 1)
              {
                siciFileModelAllList = siciFileModelUpdateList.where((element) => element.idFichaSiciApp!.isNotEmpty).toList();
                if(siciFileModelAllList.isEmpty)
                {
                  statusView = TypeView.viewErrorInformation;
                  GlobalScaffold.erroInformacao = 'Não a registro para esta solicitação';
                }
                else  {
                  statusView = TypeView.viewRenderInformation;
                }
              }
              else if(value == 2)
              {
                siciFileModelAllList = siciFileModelUpdateList.where((element) => element.idFichaSiciApp!.isEmpty).toList();
                if(siciFileModelAllList.isEmpty)
                {
                  statusView = TypeView.viewErrorInformation;
                  GlobalScaffold.erroInformacao = 'Não a registro para esta solicitação';
                }
                else  {
                  statusView = TypeView.viewRenderInformation;
                }
              }
              else
              {
                siciFileModelAllList = siciFileModelUpdateList.toList();
                if(siciFileModelAllList.isEmpty)
                {
                  statusView = TypeView.viewErrorInformation;
                  GlobalScaffold.erroInformacao = 'Não a registro para esta solicitação';
                }
                else  {
                  statusView = TypeView.viewRenderInformation;
                }
              }
            });
          } catch (error) {
            GlobalScaffold.instance.onToastError(error.toString());
          }
        },
        itemBuilder: (cxt) =>
        [
          PopupMenuItem(
            value: 1,
            child: Container(
              width: 180,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.file_upload_outlined,
                      size: 23, color: Color(0xFF424242)),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Upload',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF424242),
                          fontFamily: "Poppins-Medium"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Container(
              alignment: Alignment.center,
              width: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.file_download_outlined,
                      size: 23, color: Color(0xFF424242)),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Download',
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF424242),
                          fontFamily: "Poppins-Medium"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Container(
              alignment: Alignment.center,
              width: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.file_open_outlined,
                      size: 23, color: Color(0xFF424242)),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Todos',
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  onToview(InputSiciFileModel? prop) {
    try {
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                FormularioSiciFustView(siciFileModel:prop),
          )).then((value) {
        onRestDb();
      });
    } catch (error) {
      OnAlertError(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    onRestDb();
    Future.delayed(Duration.zero, () {

    });
  }

  @override
  void dispose() {
    try {

    } catch (exception, stackTrace) {
      print("exception.toString()");
      print(exception.toString());
    } finally {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child:  AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          elevation: 0.0,
          title: const Text('Sici/Fust Enviados - Período'),
          actions: [
            if(siciFileModelAllList.isNotEmpty)
              ...[
                selectPopupMenuButton()
              ]
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Container(
              width: double.infinity,
              constraints:  const BoxConstraints(
                maxWidth: 900,
              ),
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
              child:  Row(
                children: [
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Theme(
                      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.text,
                        controller: txtSocialReason,
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
                        ),
                        onChanged: (value) {
                          setState(() {
                            siciFileModelAllList = siciFileModelUpdateList.where((element) => element.razaoSocial!.toLowerCase().contains(txtSocialReason.text.toLowerCase())).toList();
                            if(siciFileModelAllList.isEmpty)
                            {
                              setState(() {
                                statusView = TypeView.viewErrorInformation;
                                GlobalScaffold.erroInformacao = 'Não a registro para esta solicitação';
                              });
                            }
                            else  {
                              setState(() {statusView = TypeView.viewRenderInformation;});
                            }
                          });
                        },
                        onSubmitted: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());

                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          siciFileModelAllList = siciFileModelUpdateList.where((element) => element.razaoSocial!.toLowerCase().contains(txtSocialReason.text.toLowerCase())).toList();
                          if(siciFileModelAllList.isEmpty)
                          {
                            setState(() {
                              statusView = TypeView.viewErrorInformation;
                              GlobalScaffold.erroInformacao = 'Não a registro para esta solicitação';
                            });
                          }
                          else  {
                            setState(() {statusView = TypeView.viewRenderInformation;});
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        return  Align( alignment: Alignment.topCenter,child: Container(
          alignment: Alignment.topCenter,
          constraints:  const BoxConstraints(
              minHeight: 500,
              maxWidth: 1000
          ),
          child: RefreshIndicator(
            onRefresh: () async {

            },
            child:Card(

              child:  ListView.builder(
              padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: siciFileModelAllList.length,
              itemBuilder: (BuildContext context, int index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 70.0,
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              siciFileModelAllList[index].razaoSocial.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: Color(0xff333333),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                textAlign: TextAlign.start,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: siciFileModelAllList[index].periodoReferencia,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xff333333),
                                    ),
                                  ),
                                ])),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                        ]),
                  ),
                  const SizedBox(
                    height: 9.0,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 80,
                    color: const Color(0xffFFFFFF),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if( siciFileModelAllList[index].idFichaSiciApp!.isNotEmpty)...[
                          Container(
                            color: const Color(0xffFFFFFF),
                            //width: MediaQuery.of(context).size.width / 3,
                            child: InkWell(
                              onTap: () async {
                                onUpload(siciFileModelAllList[index]);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.file_upload_outlined, size: 25, color: Color(0xFF27584f)),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Upload',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                        color: Color(0xFF27584f),
                                        fontFamily: "Poppins-Regular"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const  SizedBox(width: 25.0),
                          Container(
                            color: const Color(0xffFFFFFF),
                            //width: MediaQuery.of(context).size.width / 3,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.all(25.0),
                                          constraints: const BoxConstraints(
                                            minWidth: 70,
                                            maxWidth: 450,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                                                height: 50.0,
                                                child: const Text(
                                                  'Deseja realmente remover ?',
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                constraints: const BoxConstraints(
                                                  maxWidth: 400,
                                                ),
                                                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 14.0),
                                                        child:  OutlinedButton(
                                                          style: TextButton.styleFrom(
                                                            backgroundColor: const Color(0xFFffffff),
                                                            side: const BorderSide(
                                                              color: Color(0xffef7d00), //Color of the border
                                                            ),
                                                            minimumSize: const Size(130, 43),
                                                            maximumSize: const Size(130, 43),
                                                            textStyle: const TextStyle(
                                                              color:  Color(0xffFFFFFF),
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            try {
                                                              Operation respUser = await AppScmEngenhariaMobileBll().onDeleteFormSiciFustId(siciFileModelAllList[index].idFichaSiciApp.toString());
                                                              if (respUser.erro || respUser.result == null) {
                                                                throw respUser.message!;
                                                              } else {
                                                                setState(() {
                                                                  print(index);
                                                                  siciFileModelAllList.remove(siciFileModelAllList[index]);
                                                                  //siciFileModelUpdateList.remove(siciFileModelUpdateList[index]);
                                                                });
                                                                Navigator.pop(context);
                                                                GlobalScaffold.instance.onToastSuccess(respUser.message!);
                                                              }
                                                            } catch (error) {
                                                              GlobalScaffold.instance.onToastError(error.toString());
                                                              Navigator.pop(context);
                                                            }
                                                          },
                                                          child: const Text('  Sim  ',
                                                              style: TextStyle(
                                                                color: Color(0xffef7d00),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 14.0),
                                                        child: OutlinedButton(
                                                          style: TextButton.styleFrom(
                                                            minimumSize: const Size(130, 43),
                                                            maximumSize: const Size(130, 43),
                                                            textStyle: const TextStyle(
                                                              color:  Color(0xffFFFFFF),
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            try {
                                                              Navigator.pop(context);
                                                            } catch (error) {
                                                              GlobalScaffold.instance.onToastError(error.toString());
                                                            }
                                                          },
                                                          child: const Text('  Não  ',
                                                              style: TextStyle(
                                                                color: Color(0xFFffffff),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                  },
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.delete_outlined,
                                      size: 20, color: Color(0xfff44336)),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Remover',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                        color: Color(0xfff44336),
                                        fontFamily: 'Poppins-Regular'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const  SizedBox(width: 25.0),
                        ]
                        else ...[
                          Container(
                            color: const Color(0xffFFFFFF),
                            //width: MediaQuery.of(context).size.width / 3,
                            child: InkWell(
                              onTap: () async {
                                onToview(siciFileModelAllList[index]);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.file_download_outlined,
                                      size: 20, color: Color(0xFF4caf50)),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                        color: Color(0xFF4caf50),
                                        fontFamily: "Poppins-Regular"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 25.0),
                        ],
                        Container(
                          color: const Color(0xffFFFFFF),
                          //width: MediaQuery.of(context).size.width / 3,
                          child: InkWell(
                            onTap: () {
                              onToview(siciFileModelAllList[index]);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.visibility_outlined, size: 20, color: Color(0xFFffc107)),
                                SizedBox(height: 10.0),
                                Text(
                                  'Visualizar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0,
                                      color: Color(0xFFffc107),
                                      fontFamily: "Poppins-Regular"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color:  Color(0xffCCCCCC),
                  ),
                ],
              ),
            ),),
          ),),);
    }
  }
}
