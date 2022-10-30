import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuNavigation extends StatefulWidget {

  @override
  _MenuNavigationState createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  int selectedView = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onSelectedPage() {
    switch (selectedView) {
      case 0:
        return new Text("Error");
      case 1:
        return new Text("Error");
      case 2:

      case 3:
      return new Text("Error");
      case 4:
        return new Text("Error");
      default:
        return new Text("Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: onSelectedPage(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            primaryColor: const Color(0xffa55eea),
            textTheme: Theme.of(context).textTheme.copyWith(caption: const TextStyle(color: Color(0xff6C757D),))
        ),
        child: BottomNavigationBar(
          elevation: 9.0,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedView,
          items: const [
             BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted, size: 26),
              label: "Sici/Fust",
            ),
             BottomNavigationBarItem(
              icon:  Icon(Icons.wysiwyg, size: 24),
              label:"Documentos",
            ),
             BottomNavigationBarItem(
              icon:  Icon(Icons.settings, size: 0),
              label: '',
            ),
             BottomNavigationBarItem(
              icon:  Icon(Icons.notifications_active_outlined, size: 24),
              label: "Notificações ",
            ),
             BottomNavigationBarItem(
              icon:  Icon(Icons.settings, size: 24),
              label: 'Configuração',
            ),
          ],
          onTap: (int index) {
            setState(() => selectedView = index);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 10,
            backgroundColor: const Color(0xffa55eea),
            child: const Icon(Icons.add, size: 25),
            onPressed: () {

            },
          ),
        ),
      ),
    );
  }
}
