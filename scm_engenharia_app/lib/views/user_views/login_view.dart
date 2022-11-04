import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_user.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../models/operation.dart';
import '../../models/user_response_model.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginView> {

  final txtControllerEmail = TextEditingController();
  final txtControllerPassword= TextEditingController();
  bool switchValueDarkMode=false;
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
            if (global_user_logged.globalUserLogged!.isValid)
            {
              if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.android) {
                await FirebaseMessaging.instance.subscribeToTopic('NroCPF-${userResul.cpf}' ?? 'ScmEngenhariaLogadoAll');
                await FirebaseMessaging.instance.subscribeToTopic('ScmEngenhariaLogadoAll');
                await FirebaseMessaging.instance.unsubscribeFromTopic('ScmEngenhariaNLogadoAll');
              }
            }
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
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.transparent,
       leading:  const BackButton(
         color: Colors.black,
       ),
       centerTitle: true,
       toolbarHeight: 120,
       actions: [
         Padding(padding: const EdgeInsets.fromLTRB(20.0,50.0,20.0,10.0), child: Image.asset(
             'assets/img/logo-smc-fundo-branco.png',
             height: 20,
             fit: BoxFit.fill,
             colorBlendMode: BlendMode.dstIn
         ),)
       ],
     ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
        child: Container(
          constraints:  BoxConstraints(
            minHeight: 500,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child:  Container(constraints: const BoxConstraints(
            maxWidth: 1000,
          ),child:  Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding( padding: const EdgeInsets.fromLTRB(10,10,10,10) ,child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Olá, \r\n',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22,color:  Colors.black54,),
                    ),
                    TextSpan(
                      text: 'digite seu e-mail e senha',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22,color:  Colors.black54,),
                    ),
                  ])),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  focusNode: focusNodeEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {
                    focusNodeEmail!.unfocus();
                    FocusScope.of(context).requestFocus(focusNodePassword);
                  },
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  decoration: const InputDecoration(
                    labelText: "e-mail",
                    hintText: "Digite seu e-mail",
                  )),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                autofocus: false,
                keyboardType: TextInputType.text,
                controller: txtControllerPassword,
                textInputAction: TextInputAction.go,
                onSubmitted: (term) {
                  focusNodeEmail!.unfocus();
                  onLoggingIn();
                },
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.w100,
                    color: Color(0xFF323232)),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "senha",
                  hintText: "Digite sua senha",

                ),),),
              const SizedBox(height: 25.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'lembre-me',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w200,
                          color:  Colors.black54),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Transform.scale(
                        transformHitTests: false,
                        scale: .6,
                        child: Center(child:CupertinoSwitch(
                          trackColor: const Color(0xff303e7ec1),
                          activeColor: const Color(0xff3F7EC1),
                          value: switchValueDarkMode,
                          onChanged: (value) {
                            setState(() {
                              switchValueDarkMode = value;
                            });
                          },
                        ),),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                  ]),
              const SizedBox(height: 25.0),
              ElevatedButton(
                style: TextButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  elevation: 0,
                  backgroundColor: const Color(0xffef7d00),
                  padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                  minimumSize: const Size(350, 50),
                  maximumSize: const Size(350, 50),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color:  Color(0xffFFFFFF),
                    fontSize: 15,
                  ),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: Text(
                    'Acessar',
                    style:  TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                onPressed: () async {

                },
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                style: TextButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                      side: BorderSide(color:  Color(0xffef7d00),)
                  ),
                  elevation: 0,
                  backgroundColor:  Colors.white,
                  padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                  minimumSize: const Size(350, 50),
                  maximumSize: const Size(350, 50),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color:  Color(0xffFFFFFF),
                    fontSize: 15,
                  ),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: Text(
                    'Esqueci minha senha',
                    style:  TextStyle(
                      fontWeight: FontWeight.w400,
                      color:  Color(0xffef7d00),
                      fontSize: 20,
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pushNamed(
                    //routes.forgotYourPasswordRoute,
                    routes.configuracoesRoute,
                  );
                },
              ),
            ],
          ),),),),
    );
  }
}
