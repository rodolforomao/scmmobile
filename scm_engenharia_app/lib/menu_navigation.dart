import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/help/custom_fab_button.dart';
import 'package:scm_engenharia_app/pages/configuracao_page.dart';
import 'package:scm_engenharia_app/pages/documentos_page.dart';
import 'package:scm_engenharia_app/pages/formulario_sici_fust_page.dart';
import 'package:scm_engenharia_app/pages/lista_sici_enviados_page.dart';
import 'package:scm_engenharia_app/pages/notificacoes_page.dart';
import 'help/screen_size.dart';

class MenuNavigation extends StatefulWidget {

  @override
  _MenuNavigationState createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  int _SelecionarPaginaWidgetIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  OnSelecionarPaginaWidget(int pos) {
    switch (pos) {
      case 0:
        return new ListaSiciEnviadosPage();
      case 1:
        return new DocumentosPage();
      case 2:

      case 3:
        return new NotificacoesPage();
      case 4:
        return new ConfiguracaoPage();
      default:
        return new Text("Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    if (isMediumScreenMenu(context)) {
      return Scaffold(
        body: Row(
          children: <Widget>[
            NavigationRail(
              elevation: 9.0,
              minWidth: 50,
              leading: Padding(
                padding: EdgeInsets.only(bottom: 66, top: 66),
                child: Container(
                  height: 60,
                  width: 60,
                  child: CustomFabButton(),
                ),
              ),
              selectedLabelTextStyle: TextStyle(
                fontFamily: 'Montserrat-Bold',
                color:  Color(0xff6C757D),
                fontSize: 14.0,
              ),
              backgroundColor: Colors.white,
              onDestinationSelected: (int index) {
                setState(() => _SelecionarPaginaWidgetIndex = index);
              },
              labelType: NavigationRailLabelType.selected,
              selectedIconTheme: IconThemeData(
                color: Color(0xff8854d0),
              ),
              destinations: [
                NavigationRailDestination(
                  icon: new Icon(Icons.format_list_bulleted, size: 26),
                  label: new Text('Sici/Fust',
                      style: TextStyle(
                        fontFamily: 'avenir-lt-std-roman',
                        color: _SelecionarPaginaWidgetIndex == 0 ? Color(0xffa55eea) :  Color(0xff6C757D),
                        fontSize: 14.0,
                      )),
                ),
                NavigationRailDestination(
                  icon: new Icon(Icons.wysiwyg, size: 24),
                  label: new Text("Documentos",
                      style: TextStyle(
                        fontFamily: 'avenir-lt-std-roman',
                        color: _SelecionarPaginaWidgetIndex == 1 ? Color(0xffa55eea) :  Color(0xff6C757D),
                        fontSize: 14.0,
                      )),
                ),
                NavigationRailDestination(
                  icon: new Icon(Icons.notifications_active_outlined, size: 24),
                  label: new Text("Notificações ",
                      style: TextStyle(
                        fontFamily: 'avenir-lt-std-roman',
                        color: _SelecionarPaginaWidgetIndex == 3 ? Color(0xffa55eea) :  Color(0xff6C757D),
                        fontSize: 14.0,
                      )),
                ),
                NavigationRailDestination(
                  icon: new Icon(Icons.settings, size: 24),
                  label: new Text("Configuração",
                      style: TextStyle(
                        fontFamily: 'avenir-lt-std-roman',
                        color: _SelecionarPaginaWidgetIndex == 4 ? Color(0xffa55eea) :  Color(0xff6C757D),
                        fontSize: 14.0,
                      )),
                ),
              ],
              selectedIndex: _SelecionarPaginaWidgetIndex,
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: Colors.white,
            ),
            Expanded(
              child: OnSelecionarPaginaWidget(_SelecionarPaginaWidgetIndex),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: OnSelecionarPaginaWidget(_SelecionarPaginaWidgetIndex),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              primaryColor: Color(0xffa55eea),
              textTheme: Theme.of(context).textTheme.copyWith(caption: new TextStyle(color: Color(0xff6C757D),))
          ),
          child: new BottomNavigationBar(
            elevation: 9.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _SelecionarPaginaWidgetIndex,
            items: [
              new BottomNavigationBarItem(
                icon: new Icon(Icons.format_list_bulleted, size: 26),
                title: new Text('Sici/Fust',
                    style: TextStyle(
                      fontFamily: 'avenir-lt-std-roman',
                      color: _SelecionarPaginaWidgetIndex == 0 ? Color(0xffa55eea) :  Color(0xff6C757D),
                      fontSize: 14.0,
                    )),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.wysiwyg, size: 24),
                title: new Text("Documentos",
                    style: TextStyle(
                      fontFamily: 'avenir-lt-std-roman',
                      color: _SelecionarPaginaWidgetIndex == 1 ? Color(0xffa55eea) :  Color(0xff6C757D),
                      fontSize: 14.0,
                    )),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.settings, size: 0),
                title: new Text("",
                    style: TextStyle(
                      fontFamily: 'avenir-lt-std-roman',
                      color: _SelecionarPaginaWidgetIndex == 1 ? Color(0xffa55eea) :  Color(0xff6C757D),
                      fontSize: 14.0,
                    )),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.notifications_active_outlined, size: 24),
                title: new Text("Notificações ",
                    style: TextStyle(
                      fontFamily: 'avenir-lt-std-roman',
                      color: _SelecionarPaginaWidgetIndex == 3 ? Color(0xffa55eea) :  Color(0xff6C757D),
                      fontSize: 14.0,
                    )),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.settings, size: 24),
                title: new Text("Configuração",
                    style: TextStyle(
                      fontFamily: 'avenir-lt-std-roman',
                      color: _SelecionarPaginaWidgetIndex == 4 ? Color(0xffa55eea) :  Color(0xff6C757D),
                      fontSize: 14.0,
                    )),
              ),
            ],
            onTap: (int index) {
              setState(() => _SelecionarPaginaWidgetIndex = index);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 10,
              backgroundColor: Color(0xffa55eea),
              child: new Icon(Icons.add, size: 25),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => FormularioSiciFustPage(FichaSiciModel:null),
                    ));
              },
            ),
          ),
        ),
      );
    }
  }
}
