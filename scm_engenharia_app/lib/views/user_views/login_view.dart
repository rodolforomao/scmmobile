import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_user.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../models/operation.dart';
import '../../models/user_response_model.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';



class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginView> {

  final txtControllerEmail = TextEditingController();
  final txtControllerPassword= TextEditingController();

  FocusNode? focusNodeEmail;
  FocusNode? focusNodePassword;


  late String errorTextControllerSenha, errorTextControllerEmail;
  bool isVisualizarSenha = false;

  onLoggingIn() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertaInformacaoErro('Verifique sua conexão com a internet e tente novamente.',context);
      } else {
        if (txtControllerEmail.text.isEmpty)
          {
            throw ("E-mail é obrigatório");
          }
        else if (txtControllerPassword.text.isEmpty)
         {
           throw ("Senha é obrigatória");
         }
        OnRealizandoOperacao('Realizando operação', true,context);
        Operation restWeb = await ServicoMobileService.onLogin(txtControllerEmail.text, txtControllerPassword.text);
        if (restWeb.erro) {
          throw (restWeb.message!);
        } else if (restWeb.result == null) {
          throw (restWeb.message!);
        } else {
            UserResponseModel resul = UserResponseModel.fromJson(restWeb.result as Map<String, dynamic>);
             TbUser userResul = TbUser(ObjectId(),
                 resul.idUsuario!,
                 resul.idPerfil!,
                 resul.descNome!,
                 txtControllerPassword.text,
                 resul.email!,
                 resul.telefoneConsultor!,
                 resul.dtUltacesso!,
                 resul.empresa!,
                 resul.periodoReferencia!,
                 resul.cpf!,
                 resul.uf!);
            Operation respBll = await AppScmEngenhariaMobileBll.instance.onSaveUser(userResul);
            if (respBll.erro) {
              throw respBll.message!;
            } else if (respBll.result == null) {
              throw respBll.message!;
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(routes.menuNavigationRoute, (Route<dynamic> route) => false);
            }
            //NotificationHandler().unsubscribeFromTopic("scmengenhariaUserNLogado");
            //NotificationHandler().subscribeToTopic("nroCPF-" +Usuario.cpf);
            //NotificationHandler().subscribeToTopic("scmengenhariaUserAllLogado");
        }
      }
    } catch (error) {
      OnRealizandoOperacao('', false,context);
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  @override
  void initState() {

    super.initState();
    // NotificationHandler().subscribeToTopic("scmengenhariaUserNLogado");
    txtControllerEmail.text = "rodolforomao@gmail.com";
    txtControllerPassword.text = "1234567";

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
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Container( constraints: const BoxConstraints(
              minWidth: 200,
              maxWidth: 800,
            ),
              padding: const EdgeInsets.only(top: 10.0, right: 30.0, left: 30.0, bottom: 50.0),child:  Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  'assets/imagens/logo_white.png',
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
                const Text(
                  "E-mail",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                Padding(child:TextField(
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: txtControllerEmail,
                    focusNode: focusNodeEmail,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      focusNodeEmail!.unfocus();
                      FocusScope.of(context).requestFocus(focusNodePassword);
                    },
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'open-sans-regular',
                        color: const Color(0xFF373737)),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
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
                        prefixIcon: Icon(
                          Icons.email,
                          size: 20,
                          color: Color(0xffFFFFFF),
                        ),
                        hintText: "Digite seu email",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 16.0, color: Color(0xFF90ffffff)),
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF90ffffff),
                            fontFamily: 'open-sans-regular'),
                        errorStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontFamily: 'open-sans-regular'),
                        fillColor: Color(0xff80ff9b7b),
                        filled: true)), padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),),
                const Text(
                  "Senha",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: "avenir-lt-std-roman",
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                Padding(child:TextField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    controller: txtControllerPassword,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (term) {
                      focusNodeEmail!.unfocus();
                      onLoggingIn();
                    },
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'open-sans-regular',
                        color: const Color(0xFF373737)),
                    obscureText: true,
                    decoration: InputDecoration(contentPadding:
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
                        filled: true)), padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),),
                Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: TextButton(
                  child: const Text(' LOGIN '),
                  onPressed: () async {
                    onLoggingIn();
                  },
                ),),
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
            ),),
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
                    'assets/imagens/ic_whatsapp.png',
                  ),
                  fit: BoxFit.fill,
                ),
              )
            : null,
      ),
    );
  }
}
