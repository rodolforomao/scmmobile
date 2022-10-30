import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_user.dart';
import '../../models/operation.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;



class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordView> {
  StreamSubscription<ConnectivityResult>? subscription;

  final txtControlleraPassword = TextEditingController();
  final txtControllerNewPassword = TextEditingController();
  final txtControllerConfirmPassword = TextEditingController();

  FocusNode? focusNodePassword;
  FocusNode? focusNodeNewPassword;
  FocusNode? focusNodeConfirmPassword;

    onUpdatePassword() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertaInformacaoErro('Verifique sua conexão com a internet e tente novamente.',context);
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
            OnRealizandoOperacao('Realizando operação', true,context);
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
              Operation respBll = await AppScmEngenhariaMobileBll.instance.onUpdateUser(userResul);
              if (respBll.erro) {
                throw respBll.message!;
              } else if (respBll.result == null) {
                throw respBll.message!;
              } else {
                OnRealizandoOperacao('', false,context);
                global_user_logged.globalUserLogged = userResul;
                OnAlertaInformacaoSucesso(restWeb.message!,context);
              }
            }
          }
      }
    } catch (error) {
      OnRealizandoOperacao('', false,context);
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  onInc() async {
    try {

    } catch (error) {

    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {

    });
    onInc();
  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Alterar senha',
        ),),
      body:Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child:Container(
            constraints: const BoxConstraints(
            minWidth: 200,
            maxWidth: 800,
          ),child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                autofocus: false,
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: txtControlleraPassword,
                focusNode: focusNodePassword,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'nunito-regular',
                    color: const Color(0xFF000000)),
                onSubmitted: (term) {
                   focusNodePassword!.unfocus();
                  FocusScope.of(context).requestFocus(focusNodeConfirmPassword);
                },
                decoration: InputDecoration(
                  hintText: "Digite sua senha ",
                  labelText: "Senha",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                autofocus: false,
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: txtControllerNewPassword,
                focusNode: focusNodePassword,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'nunito-regular',
                    color: const Color(0xFF000000)),
                onSubmitted: (term) {
                  focusNodeNewPassword!.unfocus();
                  FocusScope.of(context).requestFocus(focusNodeConfirmPassword);
                },
                decoration: const InputDecoration(
                  hintText: "Digite sua nova senha",
                  labelText: "Nova senha",
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                autofocus: false,
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: txtControllerConfirmPassword,
                focusNode: focusNodeConfirmPassword,
                textInputAction: TextInputAction.go,
                onSubmitted: (term) {
                  onUpdatePassword();
                },
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'nunito-regular',
                    color: const Color(0xFF000000)),
                decoration: InputDecoration(
                  hintText: "Confirmar senha",
                  labelText: "Confirmar senha",
                ),
              ),
              SizedBox(height: 25.0),
              Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: TextButton(
                child: const Text(' ENVIAR '),
                onPressed: () async {
                  onUpdatePassword();
                },
              ),),
              SizedBox(height: 20.0),
            ],
          ),),
        ),
      ),
    );
  }


}
