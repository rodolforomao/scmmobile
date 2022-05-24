import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_notificacao.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/help/usuario_logado.dart' as UsuarioLogado;
import 'package:scm_engenharia_app/pages/notificacao_page.dart';

import 'help_pages/global_scaffold.dart';

class NotificacoesPage extends StatefulWidget {
  @override
  _NotificacoesPageState createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends State<NotificacoesPage> {
  ServicoMobileService _RestWebService = new ServicoMobileService();
  List<NotificacaoScmEngenharia> ListaNotificacaoScmEngenharia =
       [];
  late StreamSubscription<ConnectivityResult> subscription;

  String _StatusTipoWidget = "view_realizando_busca", ErroInformacao = "";

  Future<Null> OnRecuperaNotificacaoPeloCpf() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        if (ListaNotificacaoScmEngenharia.length == 0)
          setState(() {
            _StatusTipoWidget = "sem_internet";
          });
       // else
          //GlobalScaffold.instance.OnToastInformacaoErro("Verifique sua conexão com a internet e tente novamente.");
      } else {
        setState(() {
          _StatusTipoWidget = "view_realizando_busca";
        });
        Operacao _RespResultado = await _RestWebService.OnNotificacoesPeloCPF(
            UsuarioLogado.DadosUsuarioLogado!.cpf!);
        if (_RespResultado.erro)
          throw (_RespResultado.mensagem!);
        else {
          var data = _RespResultado.resultado as List;
          if (data.length == 0)
            throw ("Não foram encontradas solicitações cadastradas para os filtros informados.");
          else {
            setState(() {
              ListaNotificacaoScmEngenharia = data
                  .map<NotificacaoScmEngenharia>(
                      (json) => NotificacaoScmEngenharia.fromJson(json))
                  .toList();
              _StatusTipoWidget = "renderizar_tela";
            });
          }
        }
      }
    } catch (error) {
      setState(() {
        if (ListaNotificacaoScmEngenharia.length > 0) {
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
            if (ListaNotificacaoScmEngenharia.length > 0) {
              setState(() {
                _StatusTipoWidget = "renderizar_tela";
              });
              //GlobalScaffold.instance.OnToastInformacaoErro("Verifique sua conexão com a internet e tente novamente.");
            } else {
              setState(() {
                _StatusTipoWidget = "sem_internet";
              });
            }
          } else {
            setState(() {
              if (ListaNotificacaoScmEngenharia.length == 0 &&
                  _StatusTipoWidget == "view_realizando_busca") {
                _StatusTipoWidget = "view_realizando_busca";
              } else if (ListaNotificacaoScmEngenharia.length > 0) {
                _StatusTipoWidget = "renderizar_tela";
              } else {
                throw ("Ops! Houve um problema e não foi possível exibir o conteúdo");
              }
            });
          }
        });
        OnRecuperaNotificacaoPeloCpf();
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
    Inc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
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
          "Notificações",
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
                        if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
                          {
                            if (ListaNotificacaoScmEngenharia.length == 0)
                              {
                                setState(() {
                                  _StatusTipoWidget = "sem_internet";
                                });
                                //GlobalScaffold.instance.OnToastConexaoInternet("Tentando reconectar a internet");
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
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: RefreshIndicator(
              onRefresh: () async {},
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Color(0xffCCCCCC),
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ListaNotificacaoScmEngenharia.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  NotificacaoPage(
                                      idNotificacao:
                                          ListaNotificacaoScmEngenharia[index].idTbNotificacoes!))).then((value) {
                        OnRecuperaNotificacaoPeloCpf();

                      });
                    },
                    contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    leading: Container(
                      width: 30,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 15.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Color(0xFF545454)))),
                      child: ListaNotificacaoScmEngenharia[index].lida == "0"
                          ? Icon(Icons.error_outline,
                              color: Color(0xFFd37d0e), size: 25.0)
                          : Icon(Icons.check_circle_outline_outlined,
                              color: Color(0xFF2fac51), size: 25.0),
                    ),
                    dense: true,
                    title: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        ListaNotificacaoScmEngenharia[index].titulo!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 15.0,
                            color: Color(0xff333333),
                            fontFamily: "avenir-lt-std-medium"),
                      ),
                    ),
                    subtitle: Container(
                      alignment: Alignment.centerLeft,
                      height: 45,
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(
                        ListaNotificacaoScmEngenharia[index].mensagem!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 13.0,
                            color: Color(0xff333333),
                            fontFamily: "avenir-lt-std-medium"),
                      ),
                    ),
                    trailing: Container(
                      width: 30,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.keyboard_arrow_right,
                          color: Color(0xff848484), size: 30.0),
                    )),
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
