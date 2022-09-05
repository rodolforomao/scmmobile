import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/help/global_user_logged.dart' as global_user_logged;
import '../../models/operation.dart';
import '../../models/notification_models/notification_model.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import '../../help/navigation_service/route_paths.dart' as routes;

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<NotificationsView> {

  List<NotificationScmEngineering> listNotificationScmEngineering = [];
  late StreamSubscription<ConnectivityResult> subscription;
  TypeView statusView = TypeView.viewLoading;


  onGetListNotificationByCpf() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        throw ('Verifique sua conexão com a internet e tente novamente.');
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
          OnAlertaInformacaoErro(error.toString(), context);
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
        GlobalScaffold.map['view'] = 'NotificationsView';
        GlobalScaffold.map['error'] = 'Verifique sua conexão com a internet e tente novamente.';
        Navigator.of(context).pushNamed(
          routes.errorInformationRoute,
          arguments: GlobalScaffold.map,
        ).then((value) {
          onInc();
        });
      }
      else {
        onGetListNotificationByCpf();
      }
    } catch (error) {
      GlobalScaffold.map['view'] = 'NotificationsView';
      //GlobalScaffold.map['isConnectivity'] = 'NotificationsView';
      GlobalScaffold.map['error'] = 'Verifique sua conexão com a internet e tente novamente.';
      Navigator.of(context).pushNamed(
        routes.errorInformationRoute,
        arguments: GlobalScaffold.map,
      ).then((value) {
        onInc();
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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Notificações',
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
    }
  }
}
