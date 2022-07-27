import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, kIsWeb;
import '../data/app_scm_engenharia_mobile_bll.dart';
import '../data/tb_user.dart';
import '../help/navigation_service/route_paths.dart' as routes;
import '../models/operation.dart';
import 'package:scm_engenharia_app/help/global_user_logged.dart' as global_user_logged;

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
      onInc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF65100),
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
          child: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Image.asset(
                    'assets/img/logo_geap_white_descricao.png',
                    height: 80.0,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),),
          ),
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
        ));
  }
}
