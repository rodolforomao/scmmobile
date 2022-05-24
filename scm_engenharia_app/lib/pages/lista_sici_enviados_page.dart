import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_ficha_sici.dart';
import 'dart:async';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_formulario_sici_fust.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/formulario_sici_fust_page.dart';

import 'help_pages/global_scaffold.dart';

class ListaSiciEnviadosPage extends StatefulWidget {
  @override
  _ListaSiciEnviadosPageState createState() => _ListaSiciEnviadosPageState();
}

class _ListaSiciEnviadosPageState extends State<ListaSiciEnviadosPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  List<TbFichaSici> ListaFichaSici = [];
  late DBHelper dbHelper;
  late BuildContext dialogContext;
  String _StatusTipoWidget = "nao_existe_sici_cadastrado", ErroInformacao = "";
  late StreamSubscription<ConnectivityResult> subscription;

  Future<Null> IncRestWeb() async {
    onRealizandoOperacao("Web: Buscando lançamentos", true, context);
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        if (ListaFichaSici.length > 0) {
          setState(() {
            _StatusTipoWidget = "renderizar_sici";
          });
        } else {
          setState(() {
            _StatusTipoWidget = "sem_internet";
          });
        }
      } else {
        Operacao _RestWeb = await _RestWebService.OnRecuperaLancamentosSici();
        if (_RestWeb.erro || _RestWeb.resultado == null)
          throw (_RestWeb.mensagem!);
        else {
          var data = _RestWeb.resultado as List;
          setState(() {
            List<ModelFormularioSiciFustJson>
                ListaModelFormularioSiciFustModelo = data.map<ModelFormularioSiciFustJson>((json) => ModelFormularioSiciFustJson.fromJson(json)).toList();
            if (ListaModelFormularioSiciFustModelo.length > 0) {
              for (var prop in ListaModelFormularioSiciFustModelo) {
                if (ListaFichaSici.where(
                            (f) => f.idLancamento!.startsWith(prop.idLancamento!))
                        .length >=
                    1) {
                  // A ficha  ja esta salva no dispositivo
                } else {
                  TbFichaSici ModelFichaSici = new TbFichaSici();
                  ModelFichaSici.idFichaSiciApp = 0;
                  ModelFichaSici.idEmpresa = prop.idEmpresa;
                  ModelFichaSici.isSincronizar = "N";
                  ModelFichaSici.idLancamento = prop.idLancamento;
                  ModelFichaSici.periodoReferencia = prop.periodoReferencia;
                  ModelFichaSici.razaoSocial = prop.razaoSocial;
                  ModelFichaSici.telefoneFixo = prop.telefoneFixo;
                  ModelFichaSici.cnpj = prop.cnpj;
                  ModelFichaSici.telefoneMovel = prop.telefoneMovel;
                  ModelFichaSici.receitaBruta = prop.receitaBruta;
                  //ModelFichaSici.idFinanceiro  = prop.idFinanceiro; Não tem
                  ModelFichaSici.simples = prop.simples;
                  ModelFichaSici.simplesPorc = prop.simplesPorc;
                  ModelFichaSici.icms = prop.icms;
                  ModelFichaSici.icmsPorc = prop.icmsPorc;
                  ModelFichaSici.pis = prop.pis;
                  ModelFichaSici.pisPorc = prop.pisPorc;
                  ModelFichaSici.cofins = prop.cofins;
                  ModelFichaSici.cofinsPorc = prop.cofinsPorc;
                  ModelFichaSici.receitaLiquida = prop.receitaLiquida;
                  ModelFichaSici.observacoes = prop.observacoes;
                  ModelFichaSici.distribuicaoFisicosServicoQuantitativo =
                      prop.distribuicaoFisicosServicoQuantitativo;
                  ListaFichaSici.add(ModelFichaSici);
                }
              }
              if (ListaFichaSici.length > 0) {
                setState(() {
                  _StatusTipoWidget = "renderizar_sici";
                });
              } else
                _StatusTipoWidget = "nao_existe_sici_cadastrado";
            } else {
              if (ListaFichaSici.length > 0) {
                setState(() {
                  _StatusTipoWidget = "renderizar_sici";
                });
              } else
                _StatusTipoWidget = "nao_existe_sici_cadastrado";
            }
          });
          //OnRealizandoOperacao("", false);
          if (ListaFichaSici.length > 0) {
            setState(() {
              _StatusTipoWidget = "renderizar_sici";
            });
          } else
            _StatusTipoWidget = "nao_existe_sici_cadastrado";
        }
      }
    } catch (error) {
      //OnRealizandoOperacao("", false);
      if (ListaFichaSici.length > 0) {
        setState(() {
          _StatusTipoWidget = "renderizar_sici";
        });
        onAlertaInformacaoErro(error.toString(), context);
      } else {
        setState(() {
          _StatusTipoWidget = "erro_informacao";
          ErroInformacao = error.toString();
        });
      }
    }
    onRealizandoOperacao('', false, context);
  }

  Future<Null> Inc() async {
    //OnRealizandoOperacao("DB: Buscando Lançamentos", true);
    try {
      Operacao _FichaSiciLocal = await dbHelper.onSelecionarFichaSici();
      if (_FichaSiciLocal.erro) {
        //OnRealizandoOperacao("", false);
        throw (_FichaSiciLocal.mensagem!);
      } else if (_FichaSiciLocal.resultado == null) {
        ListaFichaSici = [];
        IncRestWeb();
      } else {
        setState(() {
          ListaFichaSici = [];
          ListaFichaSici = _FichaSiciLocal.resultado as   List<TbFichaSici>;
          _StatusTipoWidget = "renderizar_sici";
        });
        IncRestWeb();
      }
    } catch (error) {
      if (ListaFichaSici.length > 0) {
        setState(() {
          _StatusTipoWidget = "renderizar_sici";
        });
        onAlertaInformacaoErro(error.toString(), context);
      } else {
        setState(() {
          _StatusTipoWidget = "erro_informacao";
          ErroInformacao = error.toString();
        });
      }
      IncRestWeb();
    }
    //OnRealizandoOperacao("", false);
  }



  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        if (ListaFichaSici.length > 0) {
          setState(() {
            _StatusTipoWidget = "renderizar_sici";
          });
        } else {
          setState(() {
            _StatusTipoWidget = "sem_internet";
          });
        }
      } else {}
    });

    Future.delayed(Duration.zero, () {
      Inc();
    });
  }

  @override
  void dispose() {
    try {
      subscription.cancel();
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
      key: _ScaffoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFF65100),
                Color(0xFFf5821f),
                Color(0xFFff8c49),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Sici/Fust Enviados - Período",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
        actions: <Widget>[],
      ),
      body: _TipoWidget(context),
    );
  }

  _TipoWidget(BuildContext context) {
    switch (_StatusTipoWidget) {
      case "sem_internet":
        {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/imagens/img_sem_sinal.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Não há conexão com a internet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Verifique sua conexão com a internet e tente novamente.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          setState(() {
                            _StatusTipoWidget = "sem_internet";
                          });
                          _ScaffoldKey.currentState!.showSnackBar(SnackBar(
                            onVisible: () {
                              print('Visible');
                            },
                            elevation: 6.0,
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            content: SizedBox(
                              height: 30.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Tentando reconectar a internet",
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: "avenir-lt-std-roman",
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xff2fdf84)),
                                    ),
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                ],
                              ),
                            ),
                            duration: Duration(days: 365),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.black54,
                                width: 2,
                              ),
                            ),
                          ));
                        } else {
                          _ScaffoldKey.currentState!.removeCurrentSnackBar();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 0.0),
                        constraints: BoxConstraints(maxWidth: 300),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Color(0xff8854d0)),
                        child: Text(
                          'TENTE NOVAMENTE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ), /* add child content here */
            ),
          );
        }
        break;
      case "renderizar_sici":
        {
          return Container(
            color: Color(0xffedecf1),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xffCCCCCC), width: 1.0),
                    ),
                  ),
                ),
                Expanded(
                  child: new Builder(
                    builder: (BuildContext context) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: ListaFichaSici.length,
                        itemBuilder: ListaSiciCard,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        break;
      case "nao_existe_sici_cadastrado":
        {
          return SingleChildScrollView(
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
                    "assets/imagens/img_integracao.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Não existe fichas cadastradas.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Realizar nova consulta para verificar se existe fichas cadastradas.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Inc();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 0.0),
                        constraints: BoxConstraints(maxWidth: 300),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Color(0xff8854d0)),
                        child: Text(
                          'SINCRONIZAR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        break;
      case "erro_informacao":
        {
          return SingleChildScrollView(
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
                    "assets/imagens/img_error.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Houve um problema de comunicação com a base de dados.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    ErroInformacao,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    softWrap: false,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Inc();
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 0.0),
                        constraints: BoxConstraints(maxWidth: 300),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Color(0xff8854d0)),
                        child: Text(
                          'TENTE NOVAMENTE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        break;
    }
  }

  Container ListaSiciCard(BuildContext context, int index) => Container(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
        height: 210,
        color: Color(0xffedecf1),
        child: Card(
          elevation: 7.0,
          color: Color(0xffedecf1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 111.0,
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
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
                          TextSpan(
                            text: 'Período referencia :  ',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xff333333),
                                fontFamily: "avenir-lt-std-medium"),
                          ),
                          TextSpan(
                            text: ListaFichaSici[index].periodoReferencia,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xff333333),
                                fontFamily: "avenir-lt-std-medium"),
                          ),
                        ])),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ListaFichaSici[index].razaoSocial!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff333333),
                          fontFamily: "avenir-lt-std-medium-oblique"),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:Text(
                      ListaFichaSici[index].observacoes!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff333333),
                          fontFamily: "avenir-lt-std-medium-oblique"),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 9.0,
              ),
              ListaFichaSici[index].isSincronizar == "S"
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
                          try {
                            var connectivityResult =
                            await (Connectivity()
                                .checkConnectivity());
                            if (connectivityResult ==
                                ConnectivityResult.none) {
                              onAlertaInformacaoErro("Por favor conecte-se à internet.", context);
                            } else {
                              onRealizandoOperacao('Realizando cadastro ... ', true, context);
                              Operacao _RestWeb =
                              await _RestWebService
                                  .OnRealizarLancamentosSici(
                                  ListaFichaSici[index]);
                              onRealizandoOperacao('', false, context);
                              if (_RestWeb.erro)
                                throw (_RestWeb.mensagem!);
                              else if (_RestWeb.resultado == null)
                                throw (_RestWeb.mensagem!);
                              else {
                                Operacao _respLocal =
                                await dbHelper.OnDeletarFichaSici(
                                    ListaFichaSici[index]
                                        .idFichaSiciApp!);

                                if (_respLocal.erro)
                                  throw (_respLocal.mensagem!);
                                else {
                                  setState(() {
                                    ListaFichaSici.remove([index]);
                                  });

                                  Inc();
                                }
                                onAlertaInformacaoErro(_RestWeb.mensagem!, context);
                              }
                            }
                          } catch (error) {
                            onAlertaInformacaoErro(error.toString(), context);
                          }

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
                              "Upload",
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
                                            "Deseja realmente remover ?",
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
                                              OutlineButton(
                                                color: Color(0xFFf2f2f2),
                                                //`Icon` to display
                                                child: Text('Sim',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontFamily:
                                                      'avenir-lt-std-roman',
                                                      color: Color(
                                                          0xff018a8a),
                                                      fontSize: 16.0,
                                                    )),
                                                onPressed: () async {
                                                  try {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                        new FocusNode());
                                                    Operacao _respLoca = await dbHelper
                                                        .OnDeletarFichaSici(
                                                        ListaFichaSici[
                                                        index]
                                                            .idFichaSiciApp!);
                                                    if (_respLoca.erro)
                                                      throw (_respLoca
                                                          .mensagem!);
                                                    else {
                                                      Navigator.of(
                                                          context,
                                                          rootNavigator:
                                                          true)
                                                          .pop('dialog');
                                                      onAlertaInformacaoErro(_respLoca.mensagem!, context);
                                                      Inc();
                                                    }
                                                  } catch (error) {
                                                    onAlertaInformacaoErro(error.toString(), context);
                                                  }
                                                },
                                                //callback when button is clicked
                                                borderSide: BorderSide(
                                                  color:
                                                  Color(0xFFf2f2f2),
                                                  //Color of the border
                                                  style:
                                                  BorderStyle.solid,
                                                  //Style of the border
                                                  width:
                                                  1.0, //width of the border
                                                ),
                                              ),
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
                              "Remover",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
                                  color: Color(0xfff44336),
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
                          FocusScope.of(context)
                              .requestFocus(new FocusNode());
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    FormularioSiciFustPage(
                                        FichaSiciModel:
                                        ListaFichaSici[index]),
                              ));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.visibility,
                                size: 25, color: Color(0xFFffc107)),
                            SizedBox(height: 10.0),
                            Text(
                              "Visualizar",
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
                          Future.delayed(Duration.zero, () async {
                            try {
                              onRealizandoOperacao("Realizando cadastro.", true, context);
                              Operacao _respLocal =
                              await dbHelper.OnAddFichaSici(
                                  ListaFichaSici[index]);
                              if (_respLocal.erro)
                                throw (_respLocal.mensagem!);
                              else {
                                onRealizandoOperacao('', false, context);
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  8.0))),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 15.0),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Informação",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Color(
                                                        0xff212529),
                                                    fontFamily:
                                                    "avenir-lt-std-roman"),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(
                                                color: Colors.black12,
                                              ),
                                              Padding(
                                                padding: EdgeInsets
                                                    .fromLTRB(
                                                    15.0,
                                                    10.0,
                                                    15.0,
                                                    10.0),
                                                child: Text(
                                                  _respLocal.mensagem!,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxLines: 4,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      color: Color(
                                                          0xff212529),
                                                      fontFamily:
                                                      "avenir-lt-std-roman"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black12,
                                          ),
                                          Container(
                                            margin:
                                            EdgeInsets.fromLTRB(
                                                0.0,
                                                10.0,
                                                0.0,
                                                15.0),
                                            child: new Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisSize:
                                              MainAxisSize.max,
                                              children: <Widget>[
                                                FlatButton(
                                                  color: Color(
                                                      0xff018a8a),
                                                  //`Icon` to display
                                                  child: Text(
                                                    '           OK           ',
                                                    style: TextStyle(
                                                        fontSize:
                                                        17.0,
                                                        color: Color(
                                                            0xffFFFFFF),
                                                        fontFamily:
                                                        "avenir-lt-std-roman"),
                                                  ),
                                                  //`Text` to display
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context);
                                                    Inc();
                                                  },
                                                  shape:
                                                  new RoundedRectangleBorder(
                                                    borderRadius:
                                                    new BorderRadius
                                                        .circular(
                                                        5.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            } catch (error) {
                              onRealizandoOperacao('', false, context);
                              onAlertaInformacaoErro(error.toString(), context);
                            }
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.file_download,
                                size: 25, color: Color(0xFF4caf50)),
                            SizedBox(height: 10.0),
                            Text(
                              "Download",
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
                          FocusScope.of(context)
                              .requestFocus(new FocusNode());
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    FormularioSiciFustPage(
                                        FichaSiciModel:
                                        ListaFichaSici[index]),
                              ));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.visibility,
                                size: 25, color: Color(0xFFffc107)),
                            SizedBox(height: 10.0),
                            Text(
                              "Visualizar",
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
