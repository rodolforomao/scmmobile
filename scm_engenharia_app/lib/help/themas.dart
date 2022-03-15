import 'package:flutter/material.dart';

class themas{

  static ThemeData lightTheme = ThemeData(
    //scaffoldBackgroundColor: Color(0xffFFFFFF),
    backgroundColor: Color(0xffFFFFFF),
    primaryColorDark: Color(0xff000000),
    primaryColorLight:  Color(0xffFFFFFF),
    primarySwatch: Colors.deepOrange,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: InputDecorationTheme(
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color:Color(0xFFb8b8b8), width: 0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide:  BorderSide(color: const Color(0xFFb8b8b8), width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide:  BorderSide(color: Color(0xffe74c1b), width: 1.0),
      ),
      contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 16.0),
      border: OutlineInputBorder(),
      hintStyle: TextStyle(fontSize: 16.0, color: const Color(0xFFb8b8b8)),
      labelStyle: TextStyle(
          fontSize: 16,
          color: Color(0xFFb8b8b8),
          fontFamily: 'open-sans-regular'),
      errorStyle: TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontFamily: 'open-sans-regular'),
      fillColor: Color(0xff80ff9b7b),
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: Color(0xffFFFFFF),
      ) ,
      elevation: 0,
      textTheme: TextTheme(
        titleMedium: TextStyle(
            fontSize: 19.0,
            color: Color(0xffFFFFFF),
            fontFamily: "avenir-lt-medium"),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    backgroundColor: Color(0xffFFFFFF),
    primaryColor: Color(0xffff4102),
    focusColor: Color(0xff16a038),
    textSelectionColor: Color(0xff16a038),
    primarySwatch: Colors.deepOrange,
    accentColor: Colors.black,
    cursorColor:  Colors.black,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );

}