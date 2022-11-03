import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, kIsWeb;
import '../data/app_scm_engenharia_mobile_bll.dart';
import '../data/tb_user.dart';
import '../help/navigation_service/route_paths.dart' as routes;
import '../models/operation.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
import '../models/user_response_model.dart';
import '../web_service/servico_mobile_service.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenView> {

  onInc() async {
    try {
      if (kIsWeb) {
        Future.delayed(Duration.zero, () {
          //Navigator.of(context).pushNamedAndRemoveUntil(routes.inicioRoute, (Route<dynamic> route) => false);
        });
      } else {
        Operation respUser = await AppScmEngenhariaMobileBll.instance.onSelectUser();
        if (respUser.erro) {
          throw respUser.message!;
        } else if (respUser.result == null) {
          Navigator.of(context).pushNamedAndRemoveUntil(routes.loginRoute, (Route<dynamic> route) => false);
        } else {
          global_user_logged.globalUserLogged = respUser.result as TbUser;
          if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
          {
            Navigator.of(context).pushNamedAndRemoveUntil(routes.menuNavigationRoute, (Route<dynamic> route) => false);
          }
          else {
            Operation restWeb = await ServicoMobileService.onLogin(global_user_logged.globalUserLogged!.email,global_user_logged.globalUserLogged!.password);
            if (restWeb.erro) {
              throw (restWeb.message!);
            } else if (restWeb.result == null) {
              throw (restWeb.message!);
            } else {
              UserResponseModel resul = UserResponseModel.fromJson(restWeb.result as Map<String, dynamic>);
              TbUser userResul = TbUser(global_user_logged.globalUserLogged!.idUserApp,
                  resul.idUsuario!,
                  resul.idPerfil!,
                  resul.descNome!,
                  global_user_logged.globalUserLogged!.password,
                  resul.email!,
                  resul.telefoneConsultor!,
                  resul.dtUltacesso!,
                  resul.empresa!,
                  resul.periodoReferencia!,
                  resul.cpf!,
                  resul.uf!);
              Operation respBll = await AppScmEngenhariaMobileBll.instance.onUpdateUser(userResul);
              if (respBll.erro) {
                throw respBll.message!;
              } else if (respBll.result == null) {
                throw respBll.message!;
              } else {
                global_user_logged.globalUserLogged = userResul;
                Navigator.of(context).pushNamedAndRemoveUntil(routes.menuNavigationRoute, (Route<dynamic> route) => false);
              }
            }
          }
        }
      }
    } catch (error, s) {
      Map<String, dynamic> map = {};
      map['view'] = 'SplashScreenView';
      map['error'] = error;
      Navigator.of(context).pushNamed(
        routes.errorInformationRoute,
        arguments: map,
      ).then((value) {
        onInc();
      });
    }
  }

  @override
  void initState()
  {
    super.initState();
    Future(() {
      Navigator.of(context).pushNamedAndRemoveUntil(routes.inicioRoute, (Route<dynamic> route) => false);
       //onInc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
            'assets/img/img_background.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            colorBlendMode: BlendMode.dstIn
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true,
              centerTitle: true,
              elevation: 0.0,
              title: const Text(
                'Iniciando . . .',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.start,
              ),
            ),
            body: Center(child:SingleChildScrollView(
              child: Center(child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/img/logo_white_vertical.png',
                      height: 80.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),),
            ),),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              elevation: 0.0,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 70.0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xffFFFFFF)),
                  ),
                  child: const CircularProgressIndicator(color:  Color(0xffFFFFFF),),
                ),
              ),
            ))
      ],
    );
  }
}
