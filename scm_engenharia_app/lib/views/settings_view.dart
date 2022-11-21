import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../help/navigation_service/route_paths.dart' as routes;
import 'help_views/global_scaffold.dart';
import 'help_views/global_view.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsView> {
  bool isTemaEscuroAppOn = false, isNotificacoesAtivarDesativada = false;


  @override
  void initState() {
    super.initState();

  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Configurações'),
      ),
      body: Align(child: Container(
        constraints:  const BoxConstraints(
            minHeight: 500,
            maxWidth: 1000
        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            constraints: const BoxConstraints(
                minHeight: 500,
                maxWidth: 1000
            ),
            child:Align(child: Container(
              constraints:  const BoxConstraints(
                  minHeight: 500,
                  maxWidth: 1000
              ),
              alignment: Alignment.topCenter,
              child: Card(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  const SizedBox(height: 5.0),
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    title: Text(
                      'Notificação',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 17),
                    ),
                    leading: Container(
                      padding: const EdgeInsets.only(right: 12.0),
                      decoration:  const BoxDecoration(
                          border:  Border(
                              right:  BorderSide(
                                  width: 1.0, color: Color(0xFF545454)))),
                      child: const Icon(Icons.notifications_none,
                          color: Color(0xff9e9e9e), size: 25.0),
                    ),
                    trailing: CupertinoSwitch(
                        onChanged: onSwitchNotificacoesAtivarDesativadaChanged,
                        value: isNotificacoesAtivarDesativada,
                        activeColor: const Color(0xFF005a7c)),
                  ),
                  const Divider(
                    color: Color(0xffCCCCCC),
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          routes.changePasswordRoute,
                        );
                      },
                      contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Color(0xFF545454)))),
                        child:
                        const Icon(Icons.https_outlined, color: Color(0xff9e9e9e), size: 25.0),
                      ),
                      title: Text(
                        'Alterar senha',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 17),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xff6C757D), size: 30.0)),
                  const Divider(
                    color: Color(0xffCCCCCC),
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          routes.perfilRoute,
                        );
                      },
                      contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Color(0xFF545454)))),
                        child: const Icon(Icons.perm_identity,
                            color: Color(0xff9e9e9e), size: 25.0),
                      ),
                      title: Text(
                        'Meu perfil',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 17),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xff6C757D), size: 30.0)),
                  const Divider(
                    color: Color(0xffCCCCCC),
                  ),
                  ListTile(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pushNamed(
                          routes.environmentVariableRoute,
                        );
                      },
                      contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Color(0xFF545454)))),
                        child: const Icon(Icons.compare_outlined,
                            color: Color(0xff9e9e9e), size: 24.0),
                      ),
                      title: Text(
                        'Variável de ambiente',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 17),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xff6C757D), size: 30.0)),
                  const Divider(
                    color: Color(0xffCCCCCC),
                  ),
                  ListTile(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pushNamed(
                          routes.aboutAppRoute,
                        );
                      },
                      contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Color(0xFF545454)))),
                        child: const Icon(Icons.info_outline_rounded,
                            color: Color(0xff9e9e9e), size: 24.0),
                      ),
                      title: Text(
                        'Sobre',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 17),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xff6C757D), size: 30.0)),
                  const Divider(
                    color: Color(0xffCCCCCC),
                  ),
                  ListTile(
                      onTap: () {
                        if (global_user_logged.globalUserLogged!.isValid)
                        {
                          OnExitApp(context,global_user_logged.globalUserLogged!.cpf);
                        }
                        else
                        {
                          GlobalScaffold.instance.onToastError('Não foi possível  identificar o usuario logado');
                        }
                      },
                      contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration:  const BoxDecoration(
                            border:  Border(
                                right:  BorderSide(
                                    width: 1.0, color: Color(0xff6C757D)))),
                        child: const Icon(Icons.exit_to_app,
                            color: Color(0xff9e9e9e), size: 25.0),
                      ),
                      title: Text(
                        'Sair',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 17),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xff6C757D), size: 30.0)),
                  const SizedBox(height: 5.0),
                ],
              ),),),),
          ),
        ),),),
    );
  }
}
