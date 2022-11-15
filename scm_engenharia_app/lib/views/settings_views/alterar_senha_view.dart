import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_user.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;

class AlterarSenhaView extends StatefulWidget {
  const AlterarSenhaView({Key? key}) : super(key: key);
  @override
  AlterarSenhaState createState() => AlterarSenhaState();
}

class AlterarSenhaState extends State<AlterarSenhaView> {

  final txtControlleraPassword = TextEditingController();
  final txtControllerNewPassword = TextEditingController();
  final txtControllerConfirmPassword = TextEditingController();

  FocusNode? focusNodePassword;
  FocusNode? focusNodeNewPassword;
  FocusNode? focusNodeConfirmPassword;

  onUpdatePassword() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        if (txtControlleraPassword.text.isEmpty)
        {
          throw ("O campo senha e obrigatório");
        }
        else if (txtControlleraPassword.text != global_user_logged.globalUserLogged!.password.toString())
        {
          throw ("A senha digitada não confere com sua senha");
        }
        else if (txtControllerNewPassword.text.isEmpty)
        {
          throw ("O nova senha e obrigatório");
        }
        else if (txtControllerConfirmPassword.text.isEmpty)
        {
          throw ("O confirmar e nova senha e obrigatório");
        }
        else if (txtControllerNewPassword.text != txtControllerNewPassword.text)
        {
          throw ("O nova senha e confirmar e nova senha obrigatório");
        }
        else
        {
          OnRealizandoOperacao('Realizando operação',context);
          Operation restWeb = await ServicoMobileService.onUpdatePassword(txtControllerNewPassword.text);
          if (restWeb.erro) {
            throw (restWeb.message!);
          } else {
            TbUser userResul = TbUser(global_user_logged.globalUserLogged!.idUserApp,
              global_user_logged.globalUserLogged!.idUser,
              global_user_logged.globalUserLogged!.idProfile,
              global_user_logged.globalUserLogged!.name,
              txtControllerNewPassword.text,
              global_user_logged.globalUserLogged!.email,
              global_user_logged.globalUserLogged!.telephone,
              global_user_logged.globalUserLogged!.dtLastAcess,
              global_user_logged.globalUserLogged!.company,
              global_user_logged.globalUserLogged!.referencePeriod,
              global_user_logged.globalUserLogged!.cpf,
              global_user_logged.globalUserLogged!.uf,);
            Operation respBll = await AppScmEngenhariaMobileBll.instance.onUpdateUser(global_user_logged.globalUserLogged!.idUserApp,userResul);
            if (respBll.erro) {
              throw respBll.message!;
            } else if (respBll.result == null) {
              throw respBll.message!;
            } else {
              OnRealizandoOperacao('',context);
              global_user_logged.globalUserLogged = userResul;
              OnAlertSuccess(restWeb.message!);
            }
          }
        }
      }
    } catch (error) {
      OnRealizandoOperacao('',context);
      OnAlertError(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Configurações',
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Container(
              padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0, bottom: 10.0),
              constraints:  BoxConstraints(
                minHeight: 500,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -140,
              child: SingleChildScrollView(child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child: Text(
                    'Alterar senha',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
                  ),),
                  const Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),child: Divider(color:Colors.black54),),
                  Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child:  TextField(
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: txtControlleraPassword,
                    focusNode: focusNodePassword,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF323232)),
                    onSubmitted: (term) {
                      focusNodePassword!.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeConfirmPassword);
                    },
                    decoration: const InputDecoration(
                      hintText: "Digite sua senha ",
                      labelText: "Senha",
                    ),
                  ),),
                  Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: txtControllerNewPassword,
                    focusNode: focusNodePassword,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF323232)),
                    onSubmitted: (term) {
                      focusNodeNewPassword!.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeConfirmPassword);
                    },
                    decoration: const InputDecoration(
                      hintText: "Digite sua nova senha",
                      labelText: "Nova senha",
                    ),
                  ),),
                  Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: txtControllerConfirmPassword,
                    focusNode: focusNodeConfirmPassword,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (term) {
                      onUpdatePassword();
                    },
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Regular',
                        fontWeight: FontWeight.w100,
                        color: Color(0xFF323232)),
                    decoration: const InputDecoration(
                      hintText: "Confirmar senha",
                      labelText: "Confirmar senha",
                    ),
                  ),),
                  Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),child:   Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                        minimumSize: const Size(200, 47),
                        maximumSize: const Size(200, 47),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color:  Color(0xffFFFFFF),
                          fontSize: 15,
                        ),
                      ),
                      child: const Text(' ATUALIZAR '),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        onUpdatePassword();
                      },
                    )],),)
                ],
              ),)),),),
    );
  }

}
