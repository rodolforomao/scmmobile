import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/help/themas.dart';
import 'package:scm_engenharia_app/splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SCM Engenharia',
      theme: themas.lightTheme,
      darkTheme: themas.lightTheme,
      home: SplashScreen(),
    );
  }
}

