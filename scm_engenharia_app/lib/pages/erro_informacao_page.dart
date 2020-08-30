import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/splash_screen.dart';

class ErroInformacaoPage extends StatefulWidget {
  String informacao;

  ErroInformacaoPage({Key key, @required this.informacao}) : super(key: key);

  @override
  _ErroInformacaoPage createState() => _ErroInformacaoPage();
}

class _ErroInformacaoPage extends State<ErroInformacaoPage> {
  final GlobalKey<ScaffoldState> _ScaffoldKey = GlobalKey<ScaffoldState>();
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    Future(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  OnToastInformacao(String Mensagem) {
    _ScaffoldKey.currentState.removeCurrentSnackBar();
    final snackBar = SnackBar(
        backgroundColor: Color(0xFF000000),
        duration: Duration(seconds: 4),
        content: Text(
          Mensagem,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          softWrap: false,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ));
    _ScaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<Null> onSairApp(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: new Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    height: 50.0,
                    child: new Text("Deseja realmente sair do aplicativo ?",
                        style: TextStyle(
                            fontFamily: 'open-sans-regular',
                            fontSize: 17.0,
                            color: Color(0xFF000000))),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        OutlineButton(
                          color: Color(0xFFf2f2f2),
                          //`Icon` to display
                          child: Text(
                            'Sim',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'avenir-lt-std-roman',
                              color: Color(0xffa55eea),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Operacao _UsuarioLogado = await dbHelper.OnDeletarUsuario();
                              if (_UsuarioLogado.erro) {
                                throw (_UsuarioLogado.mensagem);
                              } else {
                                Navigator.of(context).pushAndRemoveUntil(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new SplashScreen()),
                                        (Route<dynamic> route) => false);
                              }
                            } catch (error) {
                              setState(() {
                                widget.informacao = error;
                              });
                              OnToastInformacao(error);
                            }
                          },
                          //callback when button is clicked
                          borderSide: BorderSide(
                            color: Color(0xFFf2f2f2), //Color of the border
                            style: BorderStyle.solid, //Style of the border
                            width: 1.0, //width of the border
                          ),
                        ),
                        SizedBox(width: 15.0),
                        FlatButton(
                          color: Color(0xffa55eea),
                          //`Icon` to display
                          child: Text(
                            'Não',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'avenir-lt-std-roman',
                              color: Colors.white,
                            ),
                          ),
                          //`Text` to display
                          onPressed: () {
                            Navigator.pop(context);
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
            ));
      },
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      key: _ScaffoldKey,
      appBar: PreferredSize(
        child: AppBar(
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Informação",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () {
                onSairApp(context);
              },
            )
          ],
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 50.0),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Image.asset(
                "assets/imagens/img_informacao.png",
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                widget.informacao,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xff575757),
                    fontFamily: "avenir-lt-medium"),
              ),
              SizedBox(height: 40.0),
              Center(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
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
                      'TENTAR NOVAMENTE',
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
      ),
    );
  }
}
