import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
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

class NotificationState extends State<NotificacaoDetalhesView> {

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
        GlobalScaffold.map['view'] = 'NotificationView';
        GlobalScaffold.map['error'] = 'Verifique sua conexão com a internet e tente novamente.';
        Navigator.of(context).pushNamed(
          routes.errorInformationRoute,
          arguments: GlobalScaffold.map,
        ).then((value) {
          onInc();
        });
      }
      else {
        onGetNotificationById();
      }
    } catch (error) {
      GlobalScaffold.map['view'] = 'NotificationView';
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
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.erroInformacao,context);
    }
  }

}
