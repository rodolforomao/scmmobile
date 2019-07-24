import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> with TickerProviderStateMixin {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();

  AnimationController animationController;
  Animation<double> animation;
  FocusNode isFocusEmail = new FocusNode();
  FocusNode isFocusSenha = new FocusNode();

  TextEditingController _TxtControllerEmail = TextEditingController();
  TextEditingController _TxtControllerSenha = TextEditingController();
  bool _IsLogando = false, isVisualizarSenha = false;

  void OnToastInformacao(String Mensagem) {
    final snackBar = SnackBar(
        backgroundColor: Color(0xFF000000),
        duration: Duration(seconds: 4),
        content: Text(
          Mensagem,
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontFamily: 'BrandonText_Bold',
              fontSize: 16.0),
        ));
    _ScaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));

    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);

    super.initState();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _ScaffoldKey,
      body: Form(
        key: _FormKey,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                // The containers in the background
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.height / 2,
                      color: Color(0xFF333333),
                    ),
                    new Container(
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white,
                    )
                  ],
                ),
                // The card widget with top padding,
                // incase if you wanted bottom padding to work,
                // set the `alignment` of container to Alignment.bottomCenter
                new Container(
                  alignment: Alignment.topCenter,
                  padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .25,
                      right: 20.0,
                      left: 20.0),
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    child: new Card(
                      color: Colors.white,
                      elevation: 1.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/imagens/scm_logo.png",
                                          width: 500.0, //  height: 180.0,fit: BoxFit.fill,
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                        ),
                                      ],
                                    ),
                                    StreamBuilder<String>(
                                      // stream: bloc.email,
                                      builder: (context, snapshot) => TextFormField(
                                        autofocus: false,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "Digite o seu e-mail",
                                            labelText: "E-mail",
                                            labelStyle: TextStyle(
                                                color: Color(0xFF333333)),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide: const BorderSide(color: const Color(0xFF656565), width: 2.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide: const BorderSide(color: const Color(0xFF333333), width: 2.0),
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.alternate_email,
                                              size:28,
                                              color: const Color(0xFF333333),
                                            ),
                                            border: OutlineInputBorder(),
                                            fillColor:  const Color(0xFF333333),
                                            errorText: snapshot.error),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    StreamBuilder<String>(
                                      // stream: bloc.email,
                                      builder: (context, snapshot) => TextFormField(
                                        autofocus: false,
                                        focusNode: isFocusSenha,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "Digite o sua Senha",
                                            labelText: "Senha",
                                            labelStyle: TextStyle(
                                                color: Color(0xFF333333)),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide: const BorderSide(color: const Color(0xFF656565), width: 2.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide: const BorderSide(color: const Color(0xFF333333), width: 2.0),
                                            ),
                                            prefixIcon: const Icon(
                                              Icons.https,
                                              size:28,
                                              color: const Color(0xFF333333),
                                            ),
                                            border: OutlineInputBorder(),
                                            fillColor:  const Color(0xFF333333),
                                            errorText: snapshot.error),
                                      ),
                                    ),
                                    _RealizarLogin(),
                                    Container(
                                      alignment: Alignment(1.0, 0.0),
                                      padding: EdgeInsets.only(
                                          top: 15.0, left: 20.0),
                                      child: InkWell(
                                        child: Text(
                                          'Esqueci minha senha',
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 17,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontFamily: 'Roboto_Bold'),
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Container(
                                      alignment: Alignment(1.0, 0.0),
                                      padding: EdgeInsets.only(
                                          top: 15.0, left: 20.0),
                                      child: InkWell(
                                        child: Text(
                                          'Registre-se',
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 17,
                                              decoration:
                                              TextDecoration.underline,
                                              fontFamily: 'Roboto_Bold'),
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ), /* add child content here */
        ),
      ),
    );
  }

  @override
  Widget _RealizarLogin() => new Container(
        child: _IsLogando == false
            ? StreamBuilder<bool>(
                builder: (context, snapshot) => Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 45.0, bottom: 20.0),
                  child: new InkWell(
                    child: new Container(
                      //width: 100.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        color: Color(0xFFf5821f),
                        border: new Border.all(
                            color: Color(0xFFf5821f), width: 2.0),
                        borderRadius: new BorderRadius.circular(2.0),
                      ),
                      child: new Center(
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            fontFamily: 'BrandonText_Bold',
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  ),
                ),
              )
            : StreamBuilder<bool>(
                // stream: bloc.submitCheck,
                builder: (context, snapshot) => Padding(
                  padding: EdgeInsets.only(left: 0.0, top: 45.0, bottom: 20.0),
                  child: new InkWell(
                    child: new Container(
                      //width: 100.0,
                      height: 55.0,
                      decoration: new BoxDecoration(
                        color: Color(0xFFf5821f),
                        border: new Border.all(
                            color: Color(0xFFf5821f), width: 2.0),
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      child: new Center(
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: Colors.white),
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      );
}
