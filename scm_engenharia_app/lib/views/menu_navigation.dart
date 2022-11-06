import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../thema/app_thema.dart';
import 'help_views/global_scaffold.dart';


class MenuNavigation extends StatefulWidget {

  @override
  MenuNavigationState createState() => MenuNavigationState();
}

class MenuNavigationState extends State<MenuNavigation> {
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
              padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
              color: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff203e7ec1) : const Color(0xff3F7EC1),
              height: 200,
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(minHeight: 200, maxHeight: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[

                ],
              ),
            ),
            SizedBox(
              height: maxHeight-200,
              child: SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child:Container(
          alignment: Alignment.bottomLeft,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/fundo_tela_configuracoes.png'), fit: BoxFit.cover)),
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
