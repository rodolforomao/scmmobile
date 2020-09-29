import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_ficha_sici.dart';
import 'dart:async';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_formulario_sici_fust.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/formulario_sici_fust_page.dart';

class ListaSiciEnviadosPage extends StatefulWidget {
  @override
  _ListaSiciEnviadosPageState createState() => _ListaSiciEnviadosPageState();
}

class _ListaSiciEnviadosPageState extends State<ListaSiciEnviadosPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  List<TbFichaSici> ListaFichaSici = new List<TbFichaSici>();
  DBHelper dbHelper;
  BuildContext dialogContext;
  String _StatusTipoWidget = "nao_existe_sici_cadastrado", ErroInformacao = "";
  StreamSubscription<ConnectivityResult> subscription;

  Future<Null> IncRestWeb() async {
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
        OnRealizandoOperacao("Realizando busca de fichas sici Web",true);
        Operacao _RestWeb = await _RestWebService.OnRecuperaLancamentosSici();
        if (_RestWeb.erro || _RestWeb.resultado == null)
          throw (_RestWeb.mensagem);
        else {
          var data = _RestWeb.resultado as List;
          setState(() {
            List<ModelFormularioSiciFustJson>
                ListaModelFormularioSiciFustModelo = data
                    .map<ModelFormularioSiciFustJson>(
                        (json) => ModelFormularioSiciFustJson.fromJson(json))
                    .toList();
            if (ListaModelFormularioSiciFustModelo.length > 0) {
              for (var prop in ListaModelFormularioSiciFustModelo) {
                if (ListaFichaSici.where(
                            (f) => f.idLancamento.startsWith(prop.idLancamento))
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
                  ModelFichaSici.distribuicaoFisicosServicoQuantitativo = prop.distribuicaoFisicosServicoQuantitativo;
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
          OnRealizandoOperacao("",false);
          if (ListaFichaSici.length > 0) {
            setState(() {
              _StatusTipoWidget = "renderizar_sici";
            });
          } else
            _StatusTipoWidget = "nao_existe_sici_cadastrado";
        }
      }
    } catch (error) {
      OnRealizandoOperacao("",false);
      if (ListaFichaSici.length > 0) {
        setState(() {
          _StatusTipoWidget = "renderizar_sici";
        });
        OnAlertaInformacao(error);
      } else {
        setState(() {
          _StatusTipoWidget = "erro_informacao";
          ErroInformacao = error.toString();
        });
      }
    }
  }

  Future<Null> Inc() async {
    try {
      OnRealizandoOperacao("Busca de fichas sici local",true);
      Operacao _FichaSiciLocal = await dbHelper.onSelecionarFichaSici();
      if (_FichaSiciLocal.erro)
        throw (_FichaSiciLocal.mensagem);
      else if (_FichaSiciLocal.resultado == null) {
        ListaFichaSici = new List<TbFichaSici>();
        OnRealizandoOperacao("",false);
        IncRestWeb();
      } else {
        setState(() {
          ListaFichaSici = new List<TbFichaSici>();
          ListaFichaSici = _FichaSiciLocal.resultado;
          _StatusTipoWidget = "renderizar_sici";
        });
       // if (dialogContext != null) {
       //   Navigator.of(context, rootNavigator: true).pop('dialog');
       //   setState(() {
        //    dialogContext = null;
        //  });
       // }
        OnRealizandoOperacao("",false);
        IncRestWeb();
      }
    } catch (error) {
      OnRealizandoOperacao("",false);
      if (ListaFichaSici.length > 0) {
        setState(() {
          _StatusTipoWidget = "renderizar_sici";
        });
        OnAlertaInformacao(error.toString());
      } else {
        setState(() {
          _StatusTipoWidget = "erro_informacao";
          ErroInformacao = error.toString();
        });
      }
      IncRestWeb();
    }
  }

  OnAlertaInformacao(String Mensagem) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Informação",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff212529),
                        fontFamily: "avenir-lt-std-roman"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: Text(
                      Mensagem,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff212529),
                          fontFamily: "avenir-lt-std-roman"),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xff018a8a),
                      //`Icon` to display
                      child: Text(
                        '           OK           ',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xffFFFFFF),
                            fontFamily: "avenir-lt-std-roman"),
                      ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus.unfocus();
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
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

  OnRealizandoOperacao(String txtInformacao ,bool IsRealizandoOperacao) {
    if (IsRealizandoOperacao != true && txtInformacao == "") {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      setState(() {
        dialogContext = null;
        IsRealizandoOperacao = false;
      });
    }
    else
      {
        setState(() {
          IsRealizandoOperacao = false;
        });
        showDialog(
          context: _ScaffoldKey.currentContext,
          barrierDismissible: false,
          builder: (BuildContext context) {
            dialogContext = context;
            return Dialog(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        accentColor: Color(0xff018a8a),
                      ),
                      child: new CircularProgressIndicator(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.0, top: 20.0, bottom: 20.0, right: 5.0),
                      child: Text(
                        txtInformacao,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xff212529),
                            fontFamily: "open-sans-regular"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
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
      if (dialogContext != null) {
        Navigator.pop(dialogContext);
        setState(() {
          dialogContext = null;
        });
      }
      Inc();
    });
  }

  @override
  void dispose() {
    super.dispose();
    dialogContext = null;
    subscription?.cancel();
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
                          _ScaffoldKey.currentState.showSnackBar(SnackBar(
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
                          _ScaffoldKey.currentState.removeCurrentSnackBar();
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
            color: Colors.white,
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
        color: Color(0xffFFFFFF),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 7.0,
          color: Color(0xffedecf1),
          child: Container(
              color: Color(0xffedecf1),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  ListTile(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    title: Container(
                      alignment: Alignment.topLeft,
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
                    subtitle: Container(
                        alignment: Alignment.topLeft,
                        height: 70,
                        child: FittedBox(
                            fit: BoxFit.none,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              child: Column(children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  ListaFichaSici[index].razaoSocial,
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Color(0xff333333),
                                      fontFamily:
                                          "avenir-lt-std-medium-oblique"),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  ListaFichaSici[index].observacoes,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xff333333),
                                      fontFamily:
                                          "avenir-lt-std-medium-oblique"),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ]),
                            ))),
                  ),
                  ListaFichaSici[index].isSincronizar == "S"
                      ? Expanded(
                          child: Container(
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
                                        var connectivityResult = await (Connectivity().checkConnectivity());
                                        if (connectivityResult == ConnectivityResult.none) {
                                          OnAlertaInformacao("Por favor conecte-se à internet.");
                                        } else {
                                          OnRealizandoOperacao("Realizando cadastro.", true);
                                          Operacao _RestWeb = await _RestWebService.OnRealizarLancamentosSici(ListaFichaSici[index]);
                                          if (_RestWeb.erro)
                                            throw (_RestWeb.mensagem);
                                          else if (_RestWeb.resultado == null)
                                            throw (_RestWeb.mensagem);
                                          else {
                                            Operacao _respLocal = await dbHelper.OnDeletarFichaSici(ListaFichaSici[index].idFichaSiciApp);
                                            if (_respLocal.erro)
                                              throw (_respLocal.mensagem);
                                            else {
                                              setState(() {
                                                ListaFichaSici.remove(
                                                    [index]);
                                              });
                                              Inc();
                                            }
                                            OnRealizandoOperacao("", false);
                                            OnAlertaInformacao(_RestWeb.mensagem);
                                          }
                                        }
                                      } catch (error) {
                                        OnRealizandoOperacao("", false);
                                        OnAlertaInformacao(error);
                                      }


                                      Future.delayed(Duration.zero, () async {

                                      });
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontFamily:
                                                  "avenir-lt-std-roman"),
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
                                                        color:
                                                            Color(0xFF000000)),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0.0, 10.0, 0.0, 15.0),
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
                                                      OutlineButton(
                                                        color:
                                                            Color(0xFFf2f2f2),
                                                        //`Icon` to display
                                                        child: Text('Sim',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'avenir-lt-std-roman',
                                                              color: Color(
                                                                  0xff018a8a),
                                                              fontSize: 16.0,
                                                            )),
                                                        onPressed: () async {
                                                          try {
                                                            FocusScope.of(context).requestFocus(new FocusNode());
                                                            Operacao _respLoca = await dbHelper.OnDeletarFichaSici(ListaFichaSici[index].idFichaSiciApp);
                                                            if (_respLoca.erro)
                                                              throw (_respLoca.mensagem);
                                                            else {
                                                              Navigator.of(context, rootNavigator: true).pop('dialog');
                                                              OnAlertaInformacao(_respLoca.mensagem);
                                                              Inc();
                                                            }
                                                          } catch (error) {
                                                            OnAlertaInformacao(error.toString());
                                                            print(error);
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
                                                        color:
                                                            Color(0xff018a8a),
                                                        //`Icon` to display
                                                        child: Text('Não',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'avenir-lt-std-roman',
                                                              color: Color(
                                                                  0xffFFFFFF),
                                                              fontSize: 16.0,
                                                            )),
                                                        //`Text` to display
                                                        onPressed: () {
                                                          Navigator.of(context, rootNavigator: true).pop('dialog');
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
                                          ));
                                        },
                                      );
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontFamily:
                                                  "avenir-lt-std-roman"),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontFamily:
                                                  "avenir-lt-std-roman"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
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
                                          OnRealizandoOperacao("Realizando cadastro." , true);
                                          Operacao _respLocal = await dbHelper.OnAddFichaSici(ListaFichaSici[index]);
                                          if (_respLocal.erro)
                                            throw (_respLocal.mensagem);
                                          else {
                                            OnRealizandoOperacao("", false);
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
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                            color:
                                                                Colors.black12,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    15.0,
                                                                    10.0,
                                                                    15.0,
                                                                    10.0),
                                                            child: Text(
                                                              _respLocal
                                                                  .mensagem,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 4,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      17.0,
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
                                          if (dialogContext != null) {
                                            Navigator.of(context, rootNavigator: true).pop('dialog');
                                            setState(() {
                                              dialogContext = null;
                                            });
                                          }
                                          OnAlertaInformacao(error);
                                        }
                                      });
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontFamily:
                                                  "avenir-lt-std-roman"),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontFamily:
                                                  "avenir-lt-std-roman"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              )),
        ),
      );
}
