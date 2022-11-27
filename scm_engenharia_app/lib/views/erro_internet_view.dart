import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/responsive.dart';
import 'help_views/global_scaffold.dart';


class ErroInternetView extends StatefulWidget {
  const ErroInternetView({super.key});
  @override
  ErroInternetState createState() => ErroInternetState();
}

class ErroInternetState extends State<ErroInternetView> {
  StreamSubscription<ConnectivityResult>? subscription;

  onInc() async {
    try {
      if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      OnAlertInternet();
    }
  }

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        Navigator.of(context).pop();
      }
    });
    onInc();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = maxHeightAppBar(context, 55);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: AppBar(
            title: const Text('Internet. Conexão. Caiu'),),
        ),
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                minHeight: maxHeight,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child:  Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Image.asset(
                     'assets/img/img_sem_sinal.png',
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                   Padding( padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),child:Text(
                    'Não há conexão com a internet.',
                    textAlign: TextAlign.center,
                     style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17),
                  ),),
                   Padding( padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),child:Text(
                    'Verifique sua conexão com a internet e tente novamente.',
                    textAlign: TextAlign.center,
                     style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
                  ),),
                   Padding( padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),child: TextButton(
                    child: const Padding( padding: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0), child: Text(' TENTE NOVAMENTE ',),),
                    onPressed: () async {
                      GlobalScaffold.instance.onToastInternetConnection();
                    },
                  ),),
                ],
              )),
        )
    );
  }
}



