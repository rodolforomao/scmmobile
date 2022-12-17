import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../models/operation.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';

class ForgotYourPasswordView extends StatefulWidget {
  const ForgotYourPasswordView({Key? key}) : super(key: key);
  @override
  ForgotYourPasswordState createState() => ForgotYourPasswordState();
}

class ForgotYourPasswordState extends State<ForgotYourPasswordView> {
  final txtControllerEmail = TextEditingController();

  OnSaveAccount() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertError('Verifique sua conexão com a internet e tente novamente.');
      }  else {
        if (txtControllerEmail.text.isEmpty) {
          throw ("Email é obrigatório");
        }
        else
        {
          Operation restWeb = await ServicoMobileService.onForgotYourPassword(txtControllerEmail.text).whenComplete(() =>
              OnRealizandoOperacao('',context)
          );
          if (restWeb.erro || restWeb.result == null) {
            throw (restWeb.message!);
          }
          else {
            OnAlertSuccess(restWeb.message!);
          }
        }
      }
    } catch (error) {
      OnAlertError(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {

        });
      } else {
        setState(() {

        });
      }
    });
  }

  @override
  void dispose() {
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
          alignment: Alignment.topCenter,
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
                      text: 'Esqueceu sua senha , \r\n',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22,color:  Colors.black54,),
                    ),
                    TextSpan(
                      text: 'insira seu email e clique em “recuperar senha”',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22,color:  Colors.black54,),
                    ),
                  ])),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),child:TextField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: txtControllerEmail,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (term) {

                  },
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                  decoration: const InputDecoration(
                    contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
                    filled: true,
                    fillColor: Color(0xFFf5f5f5),
                    labelText: "e-mail",
                    hintText: "Digite seu e-mail",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    labelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w200,
                        color:  Colors.black54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFF65100),),
                    ),
                  )),),
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
                    'Recuperar senha',
                    style:  TextStyle(
                      fontWeight: FontWeight.w400,
                      color:  Color(0xffFFFFFF),
                      fontSize: 20,
                    ),
                  ),
                ),
                onPressed: () async {

                },
              ),
              const SizedBox(height: 25.0),
            ],
          ),),),),
    );
  }

}
