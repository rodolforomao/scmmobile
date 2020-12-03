import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/help/notification_alert.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_notificacao.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/help/usuario_logado.dart' as UsuarioLogado;
class NotificacoesPage extends StatefulWidget {
  @override
  _NotificacoesPageState createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends State<NotificacoesPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  NotificacaoScmEngenharia _NotificacaoScmEngenharia = new NotificacaoScmEngenharia();

  StreamSubscription<ConnectivityResult> subscription;

  String _StatusTipoWidget = "view_realizando_busca", ErroInformacao = "";

  Future<Null> OnRecuperaNotificacaoPeloCpf() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none)
        OnAlertaInformacaoErro("Verifique sua conexão com a internet e tente novamente.",context);
      else {
        OnRealizandoOperacao("Realizando operação",true,context);
        Operacao _RespResultado = await _RestWebService.OnNotificacoesPeloCPF(UsuarioLogado.DadosUsuarioLogado.cpf);
        if(_RespResultado.erro)
          throw(_RespResultado.mensagem);
        else
        {
          var data = _RespResultado.resultado as List;
          setState(() {
            _NotificacaoScmEngenharia = NotificacaoScmEngenharia.fromJson(data[0]);
            var ds = _NotificacaoScmEngenharia;
          });
        }
      }
    } catch (error) {
      OnRealizandoOperacao("",false,context);
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  Inc() async {
    try {
      OnRecuperaNotificacaoPeloCpf();
    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {
          _StatusTipoWidget = "sem_internet";
        });
      } else {
        setState(() {
          _StatusTipoWidget = "renderizar_tela";
        });
      }
    });
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {

      } else {
        _ScaffoldKey.currentState.removeCurrentSnackBar();
        setState(() {
          _StatusTipoWidget = "renderizar_tela";
        });
      }
    });
    Inc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
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
          "Notificações",
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
                          setState(() {
                            _StatusTipoWidget = "renderizar_tela";
                          });
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
      case "renderizar_tela":
        {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
          );
        }
        break;
      case "view_realizando_busca":
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      height: 80.0,
                      width: 80.0,
                      child: new CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation(Colors.blue),
                          strokeWidth: 6.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Realizando  operação...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 17.0,
                        color: Color(0xFF151515)),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        }
        break;
      case "view_erro_informacao":
        {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/img/img_informacao.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    ErroInformacao,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xff575757),
                        fontFamily: "Ubuntu-Regular"),
                  ),
                  SizedBox(height: 25.0),
                ],
              ),
            ),
          );
        }
        break;
    }
  }
}
