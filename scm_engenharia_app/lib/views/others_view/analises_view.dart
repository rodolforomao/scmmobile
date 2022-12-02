import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../models/operation.dart';
import '../../models/notification_models/notification_model.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;

class AnalisesView extends StatefulWidget {
  const AnalisesView({Key? key}) : super(key: key);
  @override
  AnalisesState createState() => AnalisesState();
}

class AnalisesState extends State<AnalisesView> {

  List<NotificationScmEngineering> listNotificationScmEngineering = [];
  TypeView statusView = TypeView.viewLoading;

  onGetListUsuarios() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        statusView = TypeView.viewLoading;
        Operation resultRest = await ServicoMobileService.onGetListNotificationByCpf(global_user_logged.globalUserLogged!.cpf);
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          setState(() {
            listNotificationScmEngineering = resultRest.resultList.map<NotificationScmEngineering>((json) => NotificationScmEngineering.fromJson(json)).toList();
            statusView = TypeView.viewRenderInformation;
          });
        }
      }
    } catch (error) {
      setState(() {
        if (listNotificationScmEngineering.isNotEmpty) {
          statusView = TypeView.viewRenderInformation;
          OnAlertError(error.toString());
        } else {
          statusView = TypeView.viewErrorInformation;
          GlobalScaffold.erroInformacao = error.toString();
        }
      });
    }
  }

  onInc() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
      {
        GlobalScaffold.instance.navigatorKey.currentState?.pushNamed(
          routes.erroInternetRoute,
        ).then((value) async {
          if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
            GlobalScaffold.instance.navigatorKey.currentState?.pushNamedAndRemoveUntil(routes.splashScreenRoute, (Route<dynamic> route) => false);
          }
          else
          {
            onInc();
          }
        });
      }
      else {
        //onGetListUsuarios();
      }
    } catch (error) {
      GlobalScaffold.map = {
        'view': routes.alertasRoute,
        'error': error
      };
      Navigator.of(context).pushNamed(
        routes.errorInformationRoute,
        arguments: GlobalScaffold.map,
      ).then((value) {
        GlobalScaffold.instance.navigatorKey.currentState?.pushNamedAndRemoveUntil(routes.splashScreenRoute, (Route<dynamic> route) => false);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      statusView = TypeView.viewErrorInformation;
      GlobalScaffold.erroInformacao = 'No momento não a informação';
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Análises',
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.erroInformacao,context);
      case TypeView.viewRenderInformation:
        return  SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Pagina em construção",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat-Medium',
                      fontSize: 17.0,
                      color: Color(0xFF151515)),
                ),
              ],
            ),
          ),
        );
    }
  }
}
