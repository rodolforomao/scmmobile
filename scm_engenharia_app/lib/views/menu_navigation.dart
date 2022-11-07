import 'package:flutter/material.dart';
import 'business_views/empresas_view.dart';
import 'documents_views/documents_view.dart';
import 'financial_views/recibos_view.dart';
import 'help_views/global_scaffold.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
import 'help_views/global_view.dart';
import 'notifications_views/alertas_view.dart';
import 'notifications_views/notificacoes_view.dart';
import 'others_view/analises_view.dart';
import 'settings_views/configuracoes_view.dart';
import 'user_views/usuarios_view.dart';
class MenuNavigation extends StatefulWidget {
  @override
  MenuNavigationState createState() => MenuNavigationState();
}

class MenuNavigationState extends State<MenuNavigation> {


  @override
  void initState() {
    super.initState();
    setState(() =>  GlobalScaffold.instance.selectedPageView = routes.analiseRoute);
    GlobalScaffold.colorSelectedPageView(routes.analiseRoute);
  }

  @override
  void dispose() {
    super.dispose();
  }

  onSelectedPage() {
    switch (GlobalScaffold.instance.selectedPageView) {
      case routes.analiseRoute:
        return const AnalisesView();
      case routes.alertasRoute:
        return const AlertasView();
      case routes.recibosRoute:
        return const RecibosView();
      case routes.empresasRoute:
        return const EmpresasView();
      case routes.documentosRoute:
        return const DocumentsView();
      case routes.usuarioRoute:
        return const UsuariosView();
      case routes.notificacoesRoute:
        return const NotificationsView();
      case routes.configuracoesRoute:
        return const Configuracoesview();
      default:
        return const Text('Error');
    }
  }


  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: GlobalScaffold.instance.scaffoldKeyMenuDrawer,
      body: onSelectedPage(),
      onDrawerChanged: (change) {
        setState(() {

        });
      },
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
              height: 200,
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(minHeight: 200, maxHeight: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[
                  Padding(padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),child: Text(
                    global_user_logged.globalUserLogged!.name,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
                  ),),
                  const Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),child: Divider(color:Colors.black54),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color:  Colors.black,
                          size: 22,
                        ),
                        onPressed: () {

                        },
                      ),
                      const SizedBox(width: 15.0),
                      Flexible(
                        child: Text(
                          'Lançamentos - Sici',
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.recibosRoute)),
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),child: Divider(color:Colors.black54),),
                ],
              ),
            ),
            SizedBox(
              height: maxHeight-260,
              child: SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    Padding( padding: const EdgeInsets.only(top: 10.0),child:InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.analiseRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.analiseRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.analiseRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.analiseRoute)
                              Icon(Icons.search_outlined,color:GlobalScaffold.colorTextIconSelectedPageView(routes.analiseRoute), size: 20.0)
                            else
                              Icon(Icons.search_rounded,color: GlobalScaffold.colorTextIconSelectedPageView(routes.analiseRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            Flexible(
                              child: Text(
                                'análise',
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.analiseRoute)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child:InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.alertasRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.alertasRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.alertasRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.alertasRoute)
                              Icon(Icons.warning_outlined,color:GlobalScaffold.colorTextIconSelectedPageView(routes.alertasRoute), size: 20.0)
                            else
                              Icon(Icons.warning_amber_rounded,color: GlobalScaffold.colorTextIconSelectedPageView(routes.alertasRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            Flexible(
                              child: Text(
                                'alertas',
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.alertasRoute)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child:InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.recibosRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.recibosRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.recibosRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.recibosRoute)
                              Icon(Icons.description_rounded,color:GlobalScaffold.colorTextIconSelectedPageView(routes.recibosRoute), size: 20.0)
                            else
                              Icon(Icons.description_outlined,color: GlobalScaffold.colorTextIconSelectedPageView(routes.recibosRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            Flexible(
                              child: Text(
                                'recibos',
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.recibosRoute)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child:InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.documentosRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.documentosRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.documentosRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.documentosRoute)
                              Icon(Icons.inventory_2_rounded,color:GlobalScaffold.colorTextIconSelectedPageView(routes.documentosRoute), size: 20.0)
                            else
                              Icon(Icons.inventory_2_outlined,color: GlobalScaffold.colorTextIconSelectedPageView(routes.documentosRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            ExpansionTile(
                                leading: Icon(Icons.expand_more_outlined),
                                title: Text(
                                  'documentos',
                                  overflow: TextOverflow.visible,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.documentosRoute)),
                                ),
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.analiseRoute);
                                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                                        GlobalScaffold.colorSelectedPageView(routes.analiseRoute);
                                      }, // Handle your callback
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'contratos',
                                                overflow: TextOverflow.visible,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:Color(0xff6C757D)),
                                              ),
                                            ),
                                            const SizedBox(width: 15.0),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.exit_to_app,
                                                color:Color(0xff6C757D),
                                                size: 22,
                                              ),
                                              onPressed: () {
                                                if(global_user_logged.globalUserLogged != null)
                                                {
                                                  OnExitApp(context,global_user_logged.globalUserLogged!.cpf);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.analiseRoute);
                                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                                        GlobalScaffold.colorSelectedPageView(routes.analiseRoute);
                                      }, // Handle your callback
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'certidões',
                                                overflow: TextOverflow.visible,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:Color(0xff6C757D)),
                                              ),
                                            ),
                                            const SizedBox(width: 15.0),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.exit_to_app,
                                                color:Color(0xff6C757D),
                                                size: 22,
                                              ),
                                              onPressed: () {
                                                if(global_user_logged.globalUserLogged != null)
                                                {
                                                  OnExitApp(context,global_user_logged.globalUserLogged!.cpf);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.analiseRoute);
                                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                                        GlobalScaffold.colorSelectedPageView(routes.analiseRoute);
                                      }, // Handle your callback
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'recibos ',
                                                overflow: TextOverflow.visible,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:Color(0xff6C757D)),
                                              ),
                                            ),
                                            const SizedBox(width: 15.0),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.exit_to_app,
                                                color:Color(0xff6C757D),
                                                size: 22,
                                              ),
                                              onPressed: () {
                                                if(global_user_logged.globalUserLogged != null)
                                                {
                                                  OnExitApp(context,global_user_logged.globalUserLogged!.cpf);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ] ),

                          ],
                        ),
                      ),
                    ),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child: InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.empresasRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.empresasRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.empresasRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.empresasRoute)
                              Icon(Icons.business_rounded,color:GlobalScaffold.colorTextIconSelectedPageView(routes.empresasRoute), size: 20.0)
                            else
                              Icon(Icons.business_outlined,color: GlobalScaffold.colorTextIconSelectedPageView(routes.empresasRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            Flexible(
                              child: Text(
                                'empresas',
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.empresasRoute)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child: InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.usuarioRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.usuarioRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.usuarioRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.usuarioRoute)
                              Icon(Icons.person_rounded,color:GlobalScaffold.colorTextIconSelectedPageView(routes.usuarioRoute), size: 20.0)
                            else
                              Icon(Icons.person_outlined,color: GlobalScaffold.colorTextIconSelectedPageView(routes.usuarioRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            Flexible(
                              child: Text(
                                'usuários',
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.usuarioRoute)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child: InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.notificacoesRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.notificacoesRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.notificacoesRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.notificacoesRoute)
                              Icon(Icons.message_rounded,color:GlobalScaffold.colorTextIconSelectedPageView(routes.notificacoesRoute), size: 20.0)
                            else
                              Icon(Icons.message_outlined,color: GlobalScaffold.colorTextIconSelectedPageView(routes.notificacoesRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            Flexible(
                              child: Text(
                                'notificações',
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.notificacoesRoute)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child: InkWell(
                      onTap: () {
                        setState(() =>  GlobalScaffold.instance.selectedPageView = routes.configuracoesRoute);
                        GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                        GlobalScaffold.colorSelectedPageView(routes.configuracoesRoute);
                      }, // Handle your callback
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: GlobalScaffold.colorSelectedPageView(routes.configuracoesRoute),
                            borderRadius:  const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            if (GlobalScaffold.instance.selectedPageView == routes.configuracoesRoute)
                              Icon(Icons.settings_rounded,color:GlobalScaffold.colorTextIconSelectedPageView(routes.configuracoesRoute), size: 20.0)
                            else
                              Icon(Icons.settings_outlined,color: GlobalScaffold.colorTextIconSelectedPageView(routes.configuracoesRoute), size: 22.0),
                            const SizedBox(width: 15.0),
                            Flexible(
                              child: Text(
                                'configurações',
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                softWrap: false,
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:GlobalScaffold.colorTextIconSelectedPageView(routes.configuracoesRoute)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),),
                  ],
                ),
              ),
            ),
            Padding( padding: const EdgeInsets.only(top: 10.0),child: SizedBox(
              height: 50,
              child: InkWell(
                onTap: () {
                  setState(() =>  GlobalScaffold.instance.selectedPageView = routes.analiseRoute);
                  GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openEndDrawer();
                  GlobalScaffold.colorSelectedPageView(routes.analiseRoute);
                }, // Handle your callback
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Logout',
                          overflow: TextOverflow.visible,
                          maxLines: 1,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17, color:Color(0xff6C757D)),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      IconButton(
                        icon: const Icon(
                          Icons.exit_to_app,
                          color:Color(0xff6C757D),
                          size: 22,
                        ),
                        onPressed: () {
                          if(global_user_logged.globalUserLogged != null)
                          {
                            OnExitApp(context,global_user_logged.globalUserLogged!.cpf);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child:Container(
          alignment: Alignment.bottomLeft,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/fundo_tela_configuracoes_bottom.png'), fit: BoxFit.cover)),
          height: 50,
          padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 5.0),
          constraints: const BoxConstraints(
            minWidth: 50,
            maxWidth: 100,
          ),
          child:  IconButton(
            icon: const Icon(Icons.menu, size:25, color: Color(0xFFFFFFFF)),
            tooltip: 'Menu',
            onPressed: () {
              GlobalScaffold.instance.scaffoldKeyMenuDrawer.currentState!.openDrawer();
            },
          ),
        ),
      ),
    );
  }
}
