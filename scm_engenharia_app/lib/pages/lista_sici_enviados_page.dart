import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'dart:async';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_formulario_sici_fust.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/formulario_sici_fust_page.dart';

class ListaSiciEnviadosPage extends StatefulWidget {
  final TbUsuario UsuarioLogado;
  ListaSiciEnviadosPage({Key key, @required this.UsuarioLogado}) : super(key: key);
  
  @override
  _ListaSiciEnviadosPageState createState() => _ListaSiciEnviadosPageState();
}

class _ListaSiciEnviadosPageState extends State<ListaSiciEnviadosPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  List<ModelFormularioSiciFustJson> ListaModelFormularioSiciFustModelo = new List<ModelFormularioSiciFustJson>();

  String _StatusTipoWidget = "nao_existe_sici_cadastrado", ErroInformacao = "";
  BuildContext dialogContext;
  StreamSubscription<ConnectivityResult> subscription;


  Future<Null> IncRestWeb() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        if (ListaModelFormularioSiciFustModelo.length > 0) {
          setState(() {
            _StatusTipoWidget = "renderizar_sici";
          });
          OnAlertaInformacao("Não há conexão com a internet");
        } else
        {
          setState(() {
            _StatusTipoWidget = "sem_internet";
          });
        }
      } else {
        OnRealizandoOperacao("Realizando busca de fichas sici");
        Operacao _RestWeb = await _RestWebService.OnRecuperaLancamentosSici(widget.UsuarioLogado);
        if (_RestWeb.erro)
          throw (_RestWeb.mensagem);
        else if (_RestWeb.resultado == null)
          throw (_RestWeb.mensagem);
        else
        {
          var data = _RestWeb.resultado as List;
          setState(() {
            ListaModelFormularioSiciFustModelo = data.map<ModelFormularioSiciFustJson>((json) => ModelFormularioSiciFustJson.fromJson(json)).toList();
            var s = ListaModelFormularioSiciFustModelo;
          });
          Navigator.pop(dialogContext);
        }
      }
    } catch (error) {
      Navigator.pop(dialogContext);
      if (ListaModelFormularioSiciFustModelo.length > 0) {
        setState(() {
          _StatusTipoWidget = "renderizar_sici";
        });
        OnAlertaInformacao(error);
      } else
       {
         setState(() {
           _StatusTipoWidget = "erro_informacao";
           ErroInformacao = error.toString();
         });
       }
    }
  }

  Future<Null> IncLocal() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        if (ListaModelFormularioSiciFustModelo.length > 0) {
          setState(() {
            _StatusTipoWidget = "renderizar_sici";
          });
          OnAlertaInformacao("Não há conexão com a internet");
        } else
        {
          setState(() {
            _StatusTipoWidget = "sem_internet";
          });
        }
      } else {
        OnRealizandoOperacao("Realizando busca de Feichas sici");
        Operacao _RestWeb = await _RestWebService.OnRecuperaLancamentosSici(widget.UsuarioLogado);
        if (_RestWeb.erro)
          throw (_RestWeb.mensagem);
        else if (_RestWeb.resultado == null)
          throw (_RestWeb.mensagem);
        else
        {
          var data = _RestWeb.resultado as List;
          setState(() {
            ListaModelFormularioSiciFustModelo = data.map<ModelFormularioSiciFustJson>((json) => ModelFormularioSiciFustJson.fromJson(json)).toList();
            var s = ListaModelFormularioSiciFustModelo;
          });
          Navigator.pop(dialogContext);
        }
      }
    } catch (error) {
      Navigator.pop(dialogContext);
      if (ListaModelFormularioSiciFustModelo.length > 0) {
        setState(() {
          _StatusTipoWidget = "renderizar_sici";
        });
        OnAlertaInformacao(error);
      } else
      {
        setState(() {
          _StatusTipoWidget = "erro_informacao";
          ErroInformacao = error.toString();
        });
      }
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
          child:  Column(
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
                  Padding(padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child:  Text(
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

  OnRealizandoOperacao(String txtInformacao) {
    showDialog(
      context: context,
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
                  margin: EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0, right: 5.0),
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

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        if (ListaModelFormularioSiciFustModelo.length > 0) {
          setState(() {
            _StatusTipoWidget = "renderizar_sici";
          });
        } else
        {
          setState(() {
            _StatusTipoWidget = "sem_internet";
          });
        }
      } else {

      }

    });
     IncRestWeb();
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
        actions: <Widget>[

        ],
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
                    ),),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var connectivityResult = await (Connectivity().checkConnectivity());
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(Color(0xff2fdf84)),
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
                          IncRestWeb();
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
                        itemCount: ListaModelFormularioSiciFustModelo.length,
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
                    ),),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () {
                        IncRestWeb();
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
                    ),),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () {
                        IncRestWeb();
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
    padding: EdgeInsets.all(0.0),
    height: 278,
    color: Color(0xffedecf1),
    width: MediaQuery.of(context).size.width,
    child: Container(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.all(0.0),
        height: 278,
        color: Color(0xffedecf1),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              color: Color(0xffCCCCCC),
            ),
            ListTile(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => FormularioSiciFustPage(),
                      ));
                },
                contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                title: Text(
                  "Razão socia 1 ",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xff333333),
                      fontFamily: "avenir-lt-std-medium"),
                ),
                subtitle: Text(
                  "04/08/2020",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xff333333),
                      fontFamily: "avenir-lt-std-medium"),
                ),
                trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xff6C757D), size: 30.0)),
          ],
        )),
  );
}
