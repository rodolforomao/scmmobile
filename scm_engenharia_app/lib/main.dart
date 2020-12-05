import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scm_engenharia_app/help/global_scaffold.dart';
import 'package:scm_engenharia_app/help/themas.dart';
import 'package:scm_engenharia_app/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'SCM Engenharia',
      builder: (context ,child){
        return Scaffold(
          key: GlobalScaffold.instance.scaffoldKey,
          body: child,
        );
      },
      theme: themas.lightTheme,
      darkTheme: themas.lightTheme,
      home: SplashScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const  Locale('pt', 'BR'),
      ],
    );
  }
}

