import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../help/responsive.dart';
import '../thema/app_thema.dart';
import 'help_views/global_scaffold.dart';


class ErroInternetView extends StatefulWidget {
  const ErroInternetView({super.key});
  @override
  ErroInternetState createState() => ErroInternetState();
}

class ErroInternetState extends State<ErroInternetView> {


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

    onInc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = maxHeightAppBar(context, 55);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Internet. Conexão. Caiu'),
          toolbarHeight: 55,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          backgroundColor: Colors.transparent,
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
                     style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 17),
                  ),),
                   Padding( padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),child:Text(
                    'Verifique sua conexão com a internet e tente novamente.',
                    textAlign: TextAlign.center,
                     style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20),
                  ),),
                   Padding( padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),child: TextButton(
                     style: TextButton.styleFrom(
                       elevation: 0,
                       backgroundColor: Color(0xffef7d00),
                       padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                       minimumSize: const Size(350, 50),
                       maximumSize: const Size(350, 50),
                       textStyle: const TextStyle(
                         fontWeight: FontWeight.w500,
                         color:  Color(0xffFFFFFF),
                         fontSize: 15,
                       ),
                     ),
                     child: const Padding(
                       padding:
                       EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                       child: Text(
                         'TENTE NOVAMENTE',
                         style:  TextStyle(
                           fontWeight: FontWeight.w400,
                           color:  Colors.white,
                           fontSize: 20,
                         ),
                       ),
                     ),
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



