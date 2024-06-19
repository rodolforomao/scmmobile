import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
import '../../help/parameter_result_view.dart';
import '../../models/operation.dart';
import '../../models/notification_models/notification_model.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import '../../help/navigation_service/route_paths.dart' as routes;

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<NotificationsView> with ParameterResultViewEvent {

  List<NotificationScmEngineering> listNotificationScmEngineering = [];
  late StreamSubscription<ConnectivityResult> subscription;
  TypeView statusView = TypeView.viewLoading;


  onGetListNotificationByCpf() async {
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
          OnAlert.onAlertError(context, error.toString());
        } else {
          statusView = TypeView.viewErrorInformation;
          erroInformation = error.toString();
        }
      });
    }
  }

  onInc() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
      {
        GlobalScaffold.instance.navigatorKey.currentState?.pushNamed(routes.erroInternetRoute,).then((value) async {
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
        onGetListNotificationByCpf();
      }
    } catch (error) {
      GlobalScaffold.map = {
        'view': routes.notificacoesRoute,
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
    onInc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
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
            'Notificações',
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
        return GlobalView.viewErrorInformation(maxHeight,erroInformation,context);
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
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    height: 80.0,
                    width: 80.0,
                    child: new CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation(Colors.blue),
                        strokeWidth: 6.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Realizando  operação...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat-Medium',
                      fontSize: 17.0,
                      color: Color(0xFF151515)),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        );
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }
}
