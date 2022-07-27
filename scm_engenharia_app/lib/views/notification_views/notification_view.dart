import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../models/Operation.dart';
import '../../models/notification_models/notification_model.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';



class NotificationView extends StatefulWidget {
  String idNotificacao;
  NotificationView({Key? key, required this.idNotificacao}) : super(key: key);
  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<NotificationView> {

  NotificationScmEngineering notificationScmEngineering = NotificationScmEngineering();
  late StreamSubscription<ConnectivityResult> subscription;
  TypeView statusView = TypeView.viewLoading;

  onGetNotificationById() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertaInformacaoErro('Verifique sua conexão com a internet e tente novamente.',context);
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
          OnAlertaInformacaoErro(error.toString(), context);
        } else {
          statusView = TypeView.viewErrorInformation;
          GlobalScaffold.ErroInformacao = error.toString();
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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFF65100),
                Color(0xFFf5821f),
                Color(0xFFff8c49),
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          "Notificação",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
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
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.ErroInformacao,context);
    }
  }

}
