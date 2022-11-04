import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../help_views/global_view.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
class Configuracoesview extends StatefulWidget {
  const Configuracoesview({Key? key}) : super(key: key);
  @override
  ConfiguracoesState createState() => ConfiguracoesState();
}

class ConfiguracoesState extends State<Configuracoesview> {


  final txtControllerEmail = TextEditingController();
  bool isTemaEscuroAppOn = false, isNotificacoesAtivarDesativada = false;
  onSwitchNotificacoesAtivarDesativadaChanged(bool value) async {
    try {
      setState(() {
        isNotificacoesAtivarDesativada = value;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        setState(() {

        });
      } else {
        setState(() {

        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Configurações'),
        toolbarHeight: 80,
        flexibleSpace: const Image(
          image: AssetImage('assets/img/fundo_tela_configuracoes.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
         elevation: 5,
          child: Container(
            padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0, bottom: 10.0),
          constraints:  BoxConstraints(
            minHeight: 500,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -140,
          child:  SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child: Text(
                'Configurações',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
              ),),
              const Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),child: Divider(color:Colors.black54),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),child:  ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                title: const Text(
                  'Notificação',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                ),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: const Icon(Icons.notifications_none,
                      color: Color(0xff9e9e9e), size: 25.0),
                ),
                trailing:  SizedBox(
                  height: 50,
                  width: 50,
                  child: Transform.scale(
                    transformHitTests: false,
                    scale: .7,
                    child: Center(child:CupertinoSwitch(
                      trackColor: const Color(0xff303e7ec1),
                      activeColor: const Color(0xff3F7EC1),
                      value: isNotificacoesAtivarDesativada,
                      onChanged: (value) {
                        setState(() {
                          isNotificacoesAtivarDesativada = value;
                        });
                      },
                    ),),
                  ),
                ),
              ),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),child:ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    routes.alterarSenhaRoute,
                  );
                },
                contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  child:
                  const Icon(Icons.https_outlined, color: Color(0xff9e9e9e), size: 25.0),
                ),
                title: const Text(
                  'Alterar senha',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF323232)),
                ),),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),child:ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    routes.perfilRoute,
                  );
                },
                contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: const Icon(Icons.perm_identity,
                      color: Color(0xff9e9e9e), size: 25.0),
                ),
                title: const Text(
                  'Meu perfil',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                ),),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),child: ListTile(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.of(context).pushNamed(
                    routes.variaveisDeAmbienteRoute,
                  );
                },
                contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: const Icon(Icons.compare_outlined,
                      color: Color(0xff9e9e9e), size: 24.0),
                ),
                title: const Text(
                  'Variável de ambiente',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                ),),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),child:  ListTile(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.of(context).pushNamed(
                    routes.sobreRoute,
                  );
                },
                contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: const Icon(Icons.info_outline_rounded,
                      color: Color(0xff9e9e9e), size: 24.0),
                ),
                title: const Text(
                  'Sobre',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                ),),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),child: ListTile(
                onTap: () {
                  if(global_user_logged.globalUserLogged != null)
                  {
                    OnExitApp(context,global_user_logged.globalUserLogged!.cpf);
                  }
                },
                contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                leading: Container(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: const Icon(Icons.exit_to_app,
                      color: Color(0xff9e9e9e), size: 25.0),
                ),
                title: const Text(
                  'Sair',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                ),),),
            ],
          ),)),),),
    );
  }

}
