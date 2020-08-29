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
  ServicoMobileService _RestWebService = new ServicoMobileService();
  List<ModelFormularioSiciFustJson> ListaModelFormularioSiciFustModelo = new List<ModelFormularioSiciFustJson>();

  Future<Null> Inc() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
      } else {
        
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
        }
      }
    } catch (error) {
      var s = error;
    }
  }
  


  @override
  void initState() {
    super.initState();
    Inc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        child: Expanded(
          child: new Builder(
            builder: (BuildContext context) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ListaModelFormularioSiciFustModelo.length,
                itemBuilder: GrupoServicoCard,
              );
            },
          ),
        ),
      ),
    );
  }
  
  Container GrupoServicoCard(BuildContext context, int index) => Container(
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
