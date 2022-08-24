import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../models/operation.dart';
import '../../models/output/sici_file_model.dart';
import '../../models/output/sici_fust_form_model.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';


class ListSiciSentView extends StatefulWidget {
  const ListSiciSentView({Key? key}) : super(key: key);
  @override
  ListSiciSentState createState() => ListSiciSentState();
}

class ListSiciSentState extends State<ListSiciSentView> {

  List<SiciFustFormModel> siciFustFormList = [];
  late StreamSubscription<ConnectivityResult> subscription;
  TypeView statusView = TypeView.viewLoading;


  onRestWeb() async {
  //  OnRealizandoOperacao("Web: Buscando lançamentos", true);
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        throw ('Verifique sua conexão com a internet e tente novamente.');
      } else {
        Operation resultRest = await ServicoMobileService.onRecoversSiciReleases();
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          setState(() {
            List<SiciFustFormModel> RespSiciFustFormList  = resultRest.resultList.map<SiciFustFormModel>((json) => SiciFustFormModel.fromJson(json)).toList();
            if (RespSiciFustFormList.isNotEmpty) {
              for (var prop in RespSiciFustFormList) {
                if (siciFustFormList.where((f) => f.id!.startsWith(prop.id!)).isNotEmpty) {
                  // A ficha  ja esta salva no dispositivo
                  continue;
                } else {
                  siciFustFormList.add(prop);
                }
              }
            }

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

  onVisualizar(SiciFustFormModel prop ) {
    //  OnRealizandoOperacao("Web: Buscando lançamentos", true);
    try {
      SiciFileModel modelSici = SiciFileModel();
      modelSici.idFichaSiciApp = 0;
      modelSici.idEmpresa = prop.idEmpresa;
      modelSici.isSincronizar = 'N';
      modelSici.idLancamento = prop.idLancamento;
      modelSici.periodoReferencia = prop.periodoReferencia;
      modelSici.razaoSocial = prop.razaoSocial;
      modelSici.telefoneFixo = prop.telefoneFixo;
      modelSici.cnpj = prop.cnpj;
      modelSici.telefoneMovel = prop.telefoneMovel;
      modelSici.receitaBruta = prop.receitaBruta;
      //ModelFichaSici.idFinanceiro  = prop.idFinanceiro; Não tem
      modelSici.simples = prop.simples;
      modelSici.simplesPorc = prop.simplesPorc;
      modelSici.icms = prop.icms;
      modelSici.icmsPorc = prop.icmsPorc;
      modelSici.pis = prop.pis;
      modelSici.pisPorc = prop.pisPorc;
      modelSici.cofins = prop.cofins;
      modelSici.cofinsPorc = prop.cofinsPorc;
      modelSici.receitaLiquida = prop.receitaLiquida;
      modelSici.observacoes = prop.observacoes;

    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  @override
  void initState() {
    super.initState();
    onRestWeb();

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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Sici/Fust Enviados - Período'),
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
        return  RefreshIndicator(
          onRefresh: () async {


          },
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            separatorBuilder: (context, index) => const Divider(
              color:  Color(0xffCCCCCC),
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: siciFustFormList.length,
            itemBuilder: (BuildContext context, int index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 111.0,
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              textAlign: TextAlign.start,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'Período referencia :  ',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff333333),
                                     ),
                                ),
                                TextSpan(
                                  text: siciFustFormList[index].periodoReferencia,
                                  style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xff333333),
                                      ),
                                ),
                              ])),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            siciFustFormList[index].razaoSocial.toString(),
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
                          child:Text(
                            siciFustFormList[index].observacoes.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Color(0xff333333),
                                ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 9.0,
                ),
                siciFustFormList[index].icms == "S"
                    ? Container(
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  color: Color(0xffFFFFFF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        color: Color(0xffFFFFFF),
                        child: InkWell(
                          onTap: () async {

                            Future.delayed(Duration.zero, () async {});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.file_upload,
                                  size: 25, color: Color(0xFF4caf50)),
                              SizedBox(height: 10.0),
                              Text(
                                'Upload',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Color(0xFF4caf50),
                                    fontFamily: 'avenir-lt-std-roman'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Color(0xFF000000),
                      ),
                      Container(
                        color: Color(0xffFFFFFF),
                        //width: MediaQuery.of(context).size.width / 3,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(
                                    child: new Padding(
                                      padding: EdgeInsets.all(25.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0.0, 10.0, 0.0, 15.0),
                                            height: 50.0,
                                            child: new Text(
                                              'Deseja realmente remover ?',
                                              textAlign: TextAlign.start,
                                              softWrap: false,
                                              maxLines: 2,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'open-sans-regular',
                                                  fontSize: 17.0,
                                                  color: Color(0xFF000000)),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0.0, 10.0, 0.0, 15.0),
                                            child: new Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              children: <Widget>[

                                                SizedBox(width: 15.0),
                                                FlatButton(
                                                  color: Color(0xff018a8a),
                                                  //`Icon` to display
                                                  child: Text('Não',
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontFamily:
                                                        'avenir-lt-std-roman',
                                                        color: Color(
                                                            0xffFFFFFF),
                                                        fontSize: 16.0,
                                                      )),
                                                  //`Text` to display
                                                  onPressed: () {
                                                    Navigator.of(context,
                                                        rootNavigator:
                                                        true)
                                                        .pop('dialog');
                                                  },
                                                  shape:
                                                  new RoundedRectangleBorder(
                                                    borderRadius:
                                                    new BorderRadius
                                                        .circular(5.0),
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
                            children: <Widget>[
                              Icon(Icons.delete_outline,
                                  size: 25, color: Color(0xfff44336)),
                              SizedBox(height: 10.0),
                              Text(
                                'Remover',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Color(0xfff44336),
                                    fontFamily: 'avenir-lt-std-roman'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Color(0xFF000000),
                      ),
                      Container(
                        color: Color(0xffFFFFFF),
                        //width: MediaQuery.of(context).size.width / 3,
                        child: InkWell(
                          onTap: () {

                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.visibility,
                                  size: 25, color: Color(0xFFffc107)),
                              SizedBox(height: 10.0),
                              Text(
                                'Visualizar',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Color(0xFFffc107),
                                   ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : Container(
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  color: Color(0xffFFFFFF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        color: Color(0xffFFFFFF),
                        //width: MediaQuery.of(context).size.width / 3,
                        child: InkWell(
                          onTap: () async {

                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.file_download,
                                  size: 25, color: Color(0xFF4caf50)),
                              SizedBox(height: 10.0),
                              Text(
                                'Download',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Color(0xFF4caf50),
                                    fontFamily: "avenir-lt-std-roman"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Color(0xFF000000),
                      ),
                      Container(
                        color: Color(0xffFFFFFF),
                        //width: MediaQuery.of(context).size.width / 3,
                        child: InkWell(
                          onTap: () {
                            onVisualizar(siciFustFormList[index]);

                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(Icons.visibility,
                                  size: 25, color: Color(0xFFffc107)),
                              SizedBox(height: 10.0),
                              Text(
                                'Visualizar',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                    color: Color(0xFFffc107),
                                    fontFamily: "avenir-lt-std-roman"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
    }
  }
}
