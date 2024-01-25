import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../help/components.dart';
import '../../help/parameter_result_view.dart';
import '../../models/input/input_sici_fust_form_model.dart';
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'formulario_dici_fust_view.dart';


class SelecioneArquivoDiciFustView extends StatefulWidget {
  const SelecioneArquivoDiciFustView({Key? key}) : super(key: key);
  @override
  SelecioneArquivoDiciFustState createState() => SelecioneArquivoDiciFustState();
}

class SelecioneArquivoDiciFustState extends State<SelecioneArquivoDiciFustView> with ParameterResultViewEvent {

  TypeView statusView = TypeView.viewRenderInformation;
  TextEditingController txtArquivo = TextEditingController();
  Uint8List bytesPdf = Uint8List(0);
  Map<String, dynamic> mapFile = {};

  onUpload() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        if(Components.onIsEmpty(mapFile['fileBase64']).isEmpty)
        {
          GlobalScaffold.instance.onToastError('Arquivo  não identificado');
        }
        else if(Components.onIsEmpty(mapFile['name']).isEmpty)
        {
          GlobalScaffold.instance.onToastError('Arquivo  não identificado');
        }
        else
          {
            GlobalScaffold.instance.onToastPerformingOperation('Sincronizando ... ');
            Operation resultRest = await ServicoMobileService.onSiciArquivoUpload(mapFile['name'],base64Decode(mapFile['fileBase64'])).whenComplete(() => GlobalScaffold.instance.onHideCurrentSnackBar());
            if (resultRest.erro) {
              throw (resultRest.message!);
            } else {
              Map<String, dynamic>  mapResult = resultRest.result as Map<String, dynamic>;
              List mapdadosEmServicos = [];
              if(Components.onIsEmpty(mapResult['data']['Dici']) != '')
                {


                 print(mapResult['data']);
                  for (var item in mapResult['data']['Dici'] as List) {
                    mapdadosEmServicos.add({
                      'idLancamento': '',
                      'idSiciFile': '',
                      'codIbge': Components.onIsEmpty(item['cod_ibge']),
                      'uf': Components.onIsEmpty(item['estado']),
                      'tipoCliente': Components.onIsEmpty(item['tipo_cliente']),
                      'tipoAtendimento': Components.onIsEmpty(item['tipo_atendimento']),
                      'tipoAcesso': Components.onIsEmpty(item['tipo_meio_acesso']),
                      'tecnologia': Components.onIsEmpty(item['tecnologia']),
                      'tipoProduto': Components.onIsEmpty(item['tipo_produto']),
                      'velocidade': Components.onIsEmpty(item['velocidade']),
                      'quantidadeAcesso': Components.onIsEmpty(item['quantidade_acesso']),
                    });
                  }
                }

              if(Components.onIsEmpty(mapResult['data']) != '')
                {

                  if(Components.onIsEmpty(mapResult['data']['Empresa']) != '')
                  {

                  }

                  var dsf = InputSiciFileModel.fromJson({



                    'razaoSocial': Components.onIsEmpty(mapResult['data']['Empresa'] ['razao_social']),
                    'telefoneFixo': Components.onIsEmpty(mapResult['data']['Empresa']['telefone_fixo']),
                    'telefoneMovel': Components.onIsEmpty(mapResult['data']['Empresa']['telefone_celular']),
                    'cnpj': Components.onIsEmpty(mapResult['data']['Empresa']['cnpj']),
                    'receitaBruta': Components.onIsEmpty(mapResult['data']['Financeiro']['bruta']),

                    'simplesPorc ': Components.onIsEmpty(mapResult['data1']['Financeiro']['simples']) == '' ? '' : Components.onIsEmpty(mapResult['data']['Financeiro']['simples'][0]),

                    'simplesPorc ': Components.onIsEmpty(mapResult['data']['Financeiro']['simples'][0]),
                    'simples': Components.onIsEmpty(mapResult['data']['Financeiro']['simples'][1]),
                    'icmsPorc ': Components.onIsEmpty(mapResult['data']['Financeiro']['icms'][0]),
                    'icms': Components.onIsEmpty(mapResult['data']['Financeiro']['icms'][1]),
                    'pis': Components.onIsEmpty(mapResult['data']['Financeiro']['pis']),
                    'cofins': Components.onIsEmpty(mapResult['data']['Financeiro']['cofins']),
                    'receitaLiquida': Components.onIsEmpty(mapResult['data']['Financeiro']['líquida']),
                    'dadosEmServicos':mapdadosEmServicos,
                  });
                }


              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        FormularioDiciFustView(map:{
                            'formulario':InputSiciFileModel.fromJson({
                            'razaoSocial': Components.onIsEmpty(mapResult['data']['Empresa']['razao_social']),
                            'telefoneFixo': Components.onIsEmpty(mapResult['data']['Empresa']['telefone_fixo']),
                            'telefoneMovel': Components.onIsEmpty(mapResult['data']['Empresa']['telefone_celular']),
                            'cnpj': Components.onIsEmpty(mapResult['data']['Empresa']['cnpj']),
                            'receitaBruta': Components.onIsEmpty(mapResult['data']['Financeiro']['bruta']),
                              'simplesPorc ': Components.onIsEmpty(mapResult['data']['Financeiro']['simples'][0]),
                              'simples': Components.onIsEmpty(mapResult['data']['Financeiro']['simples'][1]),
                            'icmsPorc ': Components.onIsEmpty(mapResult['data']['Financeiro']['icms'][0]),
                              'icms': Components.onIsEmpty(mapResult['data']['Financeiro']['icms'][1]),
                            'pis': Components.onIsEmpty(mapResult['data']['Financeiro']['pis']),
                            'cofins': Components.onIsEmpty(mapResult['data']['Financeiro']['cofins']),
                            'receitaLiquida': Components.onIsEmpty(mapResult['data']['Financeiro']['líquida']),
                            'dadosEmServicos':mapdadosEmServicos,
                          }),
                            'isLancamentosComBaseMesAnterior':false,
                        }),
                  )).then((value) {
              });
            }
          }
      }
    } catch (error) {
      OnAlert.onAlertError(context, error.toString());
    }
  }

  onSaveLocalDbForm() async {
    try {
      if(Components.onIsEmpty(mapFile['fileBase64']).isEmpty)
      {
        GlobalScaffold.instance.onToastError('Arquivo  não identificado');
      }
      else if(Components.onIsEmpty(mapFile['name']).isEmpty)
      {
        GlobalScaffold.instance.onToastError('Arquivo  não identificado');
      }
      else
        {
          ObjectId id = ObjectId();
          mapFile.addAll({'id':id.toString()});
          mapFile.addAll({'data':DateTime.now().toString()});
          GlobalScaffold.instance.onToastPerformingOperation('Realizando operação');
          Operation respFormSiciFust = await AppScmEngenhariaMobileBll.instance.onSaveArquivoDiciFust(id,jsonEncode(mapFile)).whenComplete(() => GlobalScaffold.instance.onHideCurrentSnackBar());
          if (respFormSiciFust.erro) {
            throw respFormSiciFust.message!;
          } else if (respFormSiciFust.result == null) {
            throw respFormSiciFust.message!;
          } else {
            OnAlertSuccess(respFormSiciFust.message!);
            mapFile = {};
            txtArquivo.text = '';
          }
        }
    } catch (error) {
      OnAlert.onAlertError(context, error.toString());
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
                      Map<String, dynamic> mapFileDiciFile  = await Components.openDiciFile();
                      Navigator.pop(context, '');
                      if(mapFileDiciFile.values.isNotEmpty)
                      {
                        txtArquivo.text = mapFileDiciFile['name'];
                        bytesPdf = Uint8List.fromList(File(mapFileDiciFile['path']).readAsBytesSync());
                        mapFile = mapFileDiciFile;
                        mapFile.addAll({'fileBase64':base64Encode(bytesPdf)});
                        mapFile.remove('bytes');
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
                    Navigator.pop(context, 'Cancelar');
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
                          Center(child: Padding(padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),child: Card(
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
                                          mapFile = {};
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
                                              mapFile = {};
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
                                            'Salvar',
                                            style:  TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color:  Color(0xffFFFFFF),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                               if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
                                               {
                                                 onSaveLocalDbForm();
                                               }
                                               else
                                               {
                                                 onUpload();
                                               }
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
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }
}
