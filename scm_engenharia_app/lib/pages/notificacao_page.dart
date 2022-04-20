import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_notificacao.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/help/usuario_logado.dart' as UsuarioLogado;

import 'help_pages/global_scaffold.dart';


class NotificacaoPage extends StatefulWidget {
  String idNotificacao;
  NotificacaoPage({Key? key, required this.idNotificacao}) : super(key: key);
  @override
  _NotificacaoPageState createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {

  ServicoMobileService _RestWebService = new ServicoMobileService();
  NotificacaoScmEngenharia _NotificacaoScmEngenharia = new NotificacaoScmEngenharia();
  late StreamSubscription<ConnectivityResult> subscription;
  String _StatusTipoWidget = "view_realizando_busca", ErroInformacao = "";

  Future<Null> OnRecuperaNotificacaoPeloId() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        if (_NotificacaoScmEngenharia.titulo != "")
          setState(() {
            _StatusTipoWidget = "sem_internet";
          });
        //else
         // GlobalScaffold.instance.OnToastInformacaoErro("Verifique sua conexão com a internet e tente novamente.");
      } else {
        setState(() {
          _StatusTipoWidget = "view_realizando_busca";
        });
        Operacao _RespResultado = await _RestWebService.OnRecuperaNotificacaoPeloId(widget.idNotificacao);
        if(_RespResultado.erro)
          throw(_RespResultado.mensagem!);
        else
        {
          var data = _RespResultado.resultado as List;
          if (data.length == 0)
            throw ("Não foram encontradas solicitações cadastradas para os filtros informados.");
          else {
            setState(() {
              _NotificacaoScmEngenharia = NotificacaoScmEngenharia.fromJson(data[0]);
              _StatusTipoWidget = "renderizar_tela";
            });
          }
        }
      }
    } catch (error) {
      setState(() {
        if (_NotificacaoScmEngenharia.titulo != null) {
          _StatusTipoWidget = "renderizar_tela";
          onAlertaInformacaoErro(error.toString(), context);
        } else {
          _StatusTipoWidget = "view_erro_informacao";
          ErroInformacao = error.toString();
        }
      });
    }
  }


  Inc() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
        setState(() {
          _StatusTipoWidget = "sem_internet";
        });
      else {
        subscription = Connectivity()
            .onConnectivityChanged
            .listen((ConnectivityResult result) {
          if (result == ConnectivityResult.none) {
            if (_NotificacaoScmEngenharia.titulo != null) {
              setState(() {
                _StatusTipoWidget = "renderizar_tela";
              });
             // GlobalScaffold.instance.OnToastInformacaoErro("Verifique sua conexão com a internet e tente novamente.");
            } else {
              setState(() {
                _StatusTipoWidget = "sem_internet";
              });
            }
          } else {
            setState(() {
              if (_NotificacaoScmEngenharia.titulo != null &&
                  _StatusTipoWidget == "view_realizando_busca") {
                _StatusTipoWidget = "view_realizando_busca";
              } else if (_NotificacaoScmEngenharia.titulo != null) {
                _StatusTipoWidget = "renderizar_tela";
              } else {
                throw ("Ops! Houve um problema e não foi possível exibir o conteúdo");
              }
            });
          }
        });
        OnRecuperaNotificacaoPeloId();
      }
    } catch (error) {
      setState(() {
        _StatusTipoWidget = "view_erro_informacao";
        ErroInformacao = error.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _NotificacaoScmEngenharia.titulo = "";
    _NotificacaoScmEngenharia.mensagem = "";
    Inc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }


  Widget build(BuildContext context) {
    return new Scaffold(

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
          "Notificação",
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
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
                          {
                            if (_NotificacaoScmEngenharia.titulo!.isEmpty)
                            {
                              setState(() {
                                _StatusTipoWidget = "sem_internet";
                              });
                             // GlobalScaffold.instance.OnToastConexaoInternet("Tentando reconectar a internet");
                            }
                            else
                              Inc();
                          }
                        } else {
                          //GlobalScaffold.instance.OnHideCurrentSnackBar();
                          Inc();
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
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
                    "Título",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontFamily: 'avenir-lt-std-roman',
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _NotificacaoScmEngenharia.titulo!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      fontFamily: 'avenir-lt-std-roman',
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Descrição",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontFamily: 'avenir-lt-std-roman',
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _NotificacaoScmEngenharia.mensagem!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      fontFamily: 'avenir-lt-std-roman',
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
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
