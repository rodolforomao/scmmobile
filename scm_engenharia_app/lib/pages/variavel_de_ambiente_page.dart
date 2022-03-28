import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_tecnologia.dart';
import 'package:scm_engenharia_app/data/tb_uf.dart';
import 'package:scm_engenharia_app/data/tb_uf_municipio.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'dart:async';
import 'package:scm_engenharia_app/help/masked_text_controller.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/models/variaveis_de_ambiente.dart';
import 'package:scm_engenharia_app/pages/login_page.dart';

import 'help_pages/global_scaffold.dart';

class VariavelDeAmbientePage  extends StatefulWidget {
  @override
  _VariavelDeAmbientePageState createState() => _VariavelDeAmbientePageState();
}

class _VariavelDeAmbientePageState extends State<VariavelDeAmbientePage > {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  TbUsuario _Usuariodb = new TbUsuario();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  late BuildContext dialogContext;
  late DBHelper dbHelper;
  late String _StatusTipoWidget,ErroInformacao="";
  late StreamSubscription<ConnectivityResult> subscription;


  Future<Null> OnGetUfs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
      } else {
        onRealizandoOperacao('Realizando operação ... ', true, context);
        Operacao _RestWeb = await _RestWebService.OnVariaveisDeAmbiente();
        if (_RestWeb.erro)
          throw (_RestWeb.mensagem!);
        else if (_RestWeb.resultado == null)
          throw (_RestWeb.mensagem!);
        else
        {
          VariaveisDeAmbienteResultado  _Resultado = _RestWeb.resultado as VariaveisDeAmbienteResultado;
          List<UF> ListaUf =  [];
          List<UFMunicipios> ListaUFMunicipios  =  [];
          List<Tecnologias> ListaTecnologias  =  [];
          setState(() {
            ListaUf = _Resultado.uF!;
            ListaUFMunicipios= _Resultado.uFMunicipios!;
            ListaTecnologias= _Resultado.tecnologias!;
          });

          if(ListaUf != null)
          {
            for (var prop in  ListaUf) {
              TbUf Uf = new TbUf();
              Uf.id = prop.id;
              Uf.uf = prop.uf;
              Operacao _respLocalUf = await dbHelper.OnAddUpdateUf(Uf);
              if (_respLocalUf.erro)
                throw (_respLocalUf.mensagem!);
              else {

              }
            }
          }
          if(ListaUFMunicipios != null)
          {
            for (var prop in  ListaUFMunicipios) {
              TbUfMunicipio tbUfMunicipio = new TbUfMunicipio();
              tbUfMunicipio.ufId = prop.ufId;
              tbUfMunicipio.uf = prop.uf;
              tbUfMunicipio.id = prop.id;
              tbUfMunicipio.municipio = prop.municipio;
              Operacao _respLocalUf = await dbHelper.OnAddUpdateUfMunicipio(tbUfMunicipio);
              if (_respLocalUf.erro)
                throw (_respLocalUf.mensagem!);
              else {

              }
            }
          }
          if(ListaUFMunicipios != null)
          {
            for (var prop in  ListaTecnologias) {
              TbTecnologia tbTecnologia = new TbTecnologia();
              tbTecnologia.id = prop.id;
              tbTecnologia.tecnologia = prop.tecnologia;
              Operacao _respLocalUf = await dbHelper.OnAddUpdateTecnologia(tbTecnologia);
              if (_respLocalUf.erro)
                throw (_respLocalUf.mensagem!);
              else {

              }
            }
          }
          onRealizandoOperacao('', false, context);
          onAlertaInformacaoSucesso("Variáveis de ambiente atualizadas com sucesso", context);
        }
      }
    } catch (error) {
      onRealizandoOperacao('', false, context);
      onAlertaInformacaoErro(error.toString(), context);
    }
  }

  Inc() async {
    try {
      Operacao _UsuarioLogado = await dbHelper.onSelecionarUsuario();
      if (_UsuarioLogado.erro)
        throw (_UsuarioLogado.mensagem!);
      else if (_UsuarioLogado.resultado == null) {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => new LoginPage()),
                (Route<dynamic> route) => false);
      }
      else {
        _Usuariodb = _UsuarioLogado.resultado as TbUsuario;
      }
      setState(() {
        // UfTxt = Uf.first;
      });
    } catch (error) {
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }



  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
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
        _ScaffoldKey.currentState!.removeCurrentSnackBar();
        setState(() {
          _StatusTipoWidget = "renderizar_tela";
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
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
          "Variável de ambiente",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
        actions: <Widget>[

        ],
      ),
      body: _TipoWidget(),
    );
  }

  _TipoWidget() {
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
                          _ScaffoldKey.currentState!.removeCurrentSnackBar();
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
                    "variáveis de ambiente",
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
                    "Vamos atualizar as variáveis de ambiente para que o aplicativo funcione corretamente.",
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
                        OnGetUfs();
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
                          'ATUALIZAR',
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

}
