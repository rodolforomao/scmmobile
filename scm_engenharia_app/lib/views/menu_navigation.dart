import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/views/settings_view.dart';
import 'package:scm_engenharia_app/views/sici_views/list_sici_sent_view.dart';
import 'notification_views/notifications_view.dart';
import 'sici_views/sici_fust_form_view.dart';

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
        return new ListSiciSentView();
      case 1:
        //return new DocumentosPage();
      case 2:

      case 3:
        return new NotificationsView();
      case 4:
        return new SettingsView();
      default:
        return new Text("Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              label: new Text("Sici/Fust",
                  style: TextStyle(
                    fontFamily: 'avenir-lt-std-roman',
                    color: _SelecionarPaginaWidgetIndex == 0 ? Color(0xffa55eea) :  Color(0xff6C757D),
                    fontSize: 14.0,
                  )).toString(),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.wysiwyg, size: 24),
              label: new Text("Documentos",
                  style: TextStyle(
                    fontFamily: 'avenir-lt-std-roman',
                    color: _SelecionarPaginaWidgetIndex == 1 ? Color(0xffa55eea) :  Color(0xff6C757D),
                    fontSize: 14.0,
                  )).toString(),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.settings, size: 0),
              label: new Text("",
                  style: TextStyle(
                    fontFamily: 'avenir-lt-std-roman',
                    color: _SelecionarPaginaWidgetIndex == 1 ? Color(0xffa55eea) :  Color(0xff6C757D),
                    fontSize: 14.0,
                  )).toString(),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.notifications_active_outlined, size: 24),
              label: new Text("Notificações ",
                  style: TextStyle(
                    fontFamily: 'avenir-lt-std-roman',
                    color: _SelecionarPaginaWidgetIndex == 3 ? Color(0xffa55eea) :  Color(0xff6C757D),
                    fontSize: 14.0,
                  )).toString(),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.settings, size: 24),
              label: new Text("Configuração",
                  style: TextStyle(
                    fontFamily: 'avenir-lt-std-roman',
                    color: _SelecionarPaginaWidgetIndex == 4 ? Color(0xffa55eea) :  Color(0xff6C757D),
                    fontSize: 14.0,
                  )).toString(),
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
                    builder: (context) => SiciFustFormView(siciFileModel: null,),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
