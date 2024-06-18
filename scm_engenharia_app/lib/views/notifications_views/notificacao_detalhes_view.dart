import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../help/parameter_result_view.dart';
import '../../models/operation.dart';
import '../../models/notification_models/notification_model.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';



class NotificacaoDetalhesView extends StatefulWidget {
  String idNotificacao;
  NotificacaoDetalhesView({Key? key, required this.idNotificacao}) : super(key: key);
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<NotificacaoDetalhesView> with ParameterResultViewEvent {

  NotificationScmEngineering notificationScmEngineering = NotificationScmEngineering();
  late StreamSubscription<ConnectivityResult> subscription;
  TypeView statusView = TypeView.viewLoading;

  onGetNotificationById() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        GlobalScaffold.instance.onToastInternetConnection();
      } else {
        setState(() {
          statusView = TypeView.viewLoading;
        });
        Operation resultRest = await ServicoMobileService.onRecuperaNotificacaoPeloId(widget.idNotificacao);
        if(resultRest.erro) {
          throw(resultRest.message!);
        } else
        {
          var data = resultRest.result as List;
          if (data.isEmpty)
            throw ("Não foram encontradas solicitações cadastradas para os filtros informados.");
          else {
            setState(() {
              notificationScmEngineering = NotificationScmEngineering.fromJson(data[0]);
              statusView = TypeView.viewRenderInformation;
            });
          }
        }
      }
    } catch (error) {
      setState(() {
        if (notificationScmEngineering.titulo!.isEmpty) {
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
        onGetNotificationById();
      }
    } catch (error) {
      GlobalScaffold.map = {
        'view': routes.notificacaoRoute,
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
    notificationScmEngineering.titulo = '';
    notificationScmEngineering.mensagem = '';
    onInc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Notificação',
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
        // TODO: Handle this case.
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }

}
