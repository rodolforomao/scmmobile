import 'package:flutter/material.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:url_launcher/url_launcher.dart';
import '../help_views/global_scaffold.dart';



class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginView> {

  final txtControllerEmail = TextEditingController();
  final txtControllerPassword= TextEditingController();
  late String errorTextControllerSenha, errorTextControllerEmail;

  bool isVisualizarSenha = false;
  
  @override
  void initState() {

    super.initState();

     //NotificationHandler().subscribeToTopic("scmengenhariaUserNLogado");
    // _TxtControllerEmail.text = "rodolforomao@gmail.com";
    // _TxtControllerSenha.text = "123456";

  }

  @override
  void dispose() {
    txtControllerEmail.dispose();
    txtControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFF65100),
            Color(0xFFff8c49),
            Color(0xFFf5821f),
            Color(0xffffba49)
          ],
        ),
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "assets/login_logo.png",
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "E-mail",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: txtControllerEmail,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'open-sans-regular',
                        color: const Color(0xFF373737)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          size: 20,
                          color: const Color(0xffFFFFFF),
                        ),
                        hintText: "Digite seu email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: const Color(0xFF90ffffff)),
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF90ffffff),
                            fontFamily: 'open-sans-regular'),
                        errorStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontFamily: 'open-sans-regular'),
                        fillColor: Color(0xff80ff9b7b),
                        filled: true)),
                SizedBox(
                  height: 17.0,
                ),
                Text(
                  "Senha",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    controller: txtControllerPassword,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'open-sans-regular',
                        color: const Color(0xFF373737)),
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0),
                        ),
                        prefixIcon: const Icon(
                          Icons.https,
                          size: 20,
                          color: const Color(0xffFFFFFF),
                        ),
                        hintText: "Digite sua senha",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: const Color(0xFF90ffffff)),
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF90ffffff),
                            fontFamily: 'open-sans-regular'),
                        errorStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontFamily: 'open-sans-regular'),
                        fillColor: Color(0xff80ff9b7b),
                        filled: true)),
                SizedBox(height: 40.0),
                Center(
                  child: InkWell(
                    onTap: () async {

                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 0.0),
                      constraints: const BoxConstraints(maxWidth: 300),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Color(0xff8854d0)),
                      child: const Text(
                        'LOGIN',
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
                SizedBox(height: 30.0),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.of(context).pushNamed(
                        routes.createNewAccountRoute,
                      );
                    },
                    child: const Text(
                      "Criar uma nova conta",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontFamily: "avenir-lt-std-roman",
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: showFab
            ? FloatingActionButton(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                onPressed: () {
                  GlobalScaffold.instance.onRedirectUri(Uri.parse('https://api.whatsapp.com/send?phone=5561982205225'));
                },
                child: const Image(
                  width: 40,
                  height: 40,
                  image: AssetImage(
                    'assets/ic_whatsapp.png',
                  ),
                  fit: BoxFit.fill,
                ),
              )
            : null,
      ),
    );
  }
}
