import 'package:flutter/material.dart';

class AppThema {
  static final themeNotifierState = ValueNotifier<ThemeModel>(ThemeModel(ThemeMode.light));

  static ThemeData lightTheme = ThemeData(
      canvasColor: const Color(0xffFFFFFF),
      scaffoldBackgroundColor: const Color(0xffFFFFFF),
      backgroundColor: const Color(0xffFFFFFF),
      primaryColor:const Color(0xff093d6c),
      primaryColorDark: const Color(0xff000000),
      primaryColorLight: const Color(0xffFFFFFF),
      splashColor: const Color(0xff093d6c),
      iconTheme: const IconThemeData(color: Color(0xFF545454)),
      textTheme:  const TextTheme(
       bodyText1: TextStyle(
         fontFamily: 'Poppins-Light',
         fontSize: 13.0,
       ),
      ),
      listTileTheme: const ListTileThemeData(
        selectedColor:Color(0xffef7d00),
          contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding:  EdgeInsets.fromLTRB(10, 10, 10, 4),
        filled: true,
        fillColor: Color(0xFFf5f5f5),
        hintStyle: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w200,
            color:  Colors.black54),
        labelStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w200,
            color:  Colors.black54),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF65100),),
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xFFF65100),
        shadowColor: Color(0xFFf5821f),
        iconTheme: IconThemeData(
          color: Color(0xffFFFFFF),
        ),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.w100,
            color: Color(0xffFFFFFF),
            fontFamily: 'Poppins-Medium'),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xffFFFFFF),
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: Colors.white,
        unselectedIconTheme: IconThemeData(size: 25, color: Color(0xff6C757D)),
        selectedIconTheme: IconThemeData(size: 28, color: Color(0xFFF65100)),
        selectedItemColor: Color(0xFFF65100),
        unselectedItemColor: Color(0xff6C757D),
        selectedLabelStyle: TextStyle(
          fontFamily: 'avenir-lt-std-roman',
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          color: Color(0xFFF65100),
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'avenir-lt-std-roman',
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
          color: Color(0xff6C757D),
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        unselectedIconTheme: IconThemeData(size: 25, color: Color(0xff6C757D)),
        selectedIconTheme: IconThemeData(size: 28, color: Color(0xff093d6c)),
        selectedLabelTextStyle: TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          color: Color(0xff093d6c),
        ),
        unselectedLabelTextStyle: TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontWeight: FontWeight.w600,
          fontSize: 12.0,
          color: Color(0xff6C757D),
        ),
      ),
      dataTableTheme: DataTableThemeData(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Color(0xff303e7ec1), width: 1.0)),
        dividerThickness: 1,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Color(0xff303e7ec1)),
        horizontalMargin: 30,
        dataRowHeight: 50,
        columnSpacing: 20.0,
        headingTextStyle: const TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Color(0xff093d6c),
        ),
        dataTextStyle: const TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
          color: Color(0xff848484),
        ),
      ),
      tabBarTheme: const TabBarTheme(
        unselectedLabelStyle: TextStyle(
            fontSize: 15.0,
            color: Color(0xff093d6c),
            fontFamily: "Montserrat-Medium"),
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontFamily: 'Montserrat-Medium'),
        labelPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        labelColor: Color(0xff093d6c),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: const Color(0xFFffffff),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
            color:  Color(0xffFFFFFF),
            fontSize: 15,
          ),
          backgroundColor: const Color(0xFF3F7EC1),
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(5.0),
          ),
        ),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF2fdf84)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(250, 47),
          maximumSize: const Size(250, 47),
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 25.0,
            fontFamily: 'Poppins-Regular',
            color: Color(0xFFffffff),
          ),
          side: const BorderSide(
            color: Color(0xFF3F7EC1), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 1.0, //width of the border
          ),
          backgroundColor: Color(0xFF3F7EC1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 47),
          maximumSize: const Size(300, 47),
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins-Regular',
            color: Color(0xffFFFFFF),
            fontSize: 25.0,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData( backgroundColor: Color(0xff3F7EC1)),
      scrollbarTheme: ScrollbarThemeData(
          thickness: MaterialStateProperty.all(10),
          thumbColor: MaterialStateProperty.all(Colors.blue),
          radius: const Radius.circular(10),
          minThumbLength: 100),
      cardTheme: const CardTheme(color: Color(0xffFFFFFF),elevation: 2),
      buttonTheme:ButtonThemeData(buttonColor: Color(0xff093d6c),disabledColor: Colors.deepPurple,focusColor: Colors.amber,hoverColor:Colors.green, splashColor:Colors.brown),
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xffFFFFFF),scrimColor: Colors.transparent,elevation: 2,width: 310,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),)
  );


}

class StylesThemas {

  static BoxDecoration boxDecorationAppBar =
  AppThema.themeNotifierState.value.mode == ThemeMode.light
      ? const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0xff15335A),
        Color(0xff437DC0),
      ],
    ),
  )
      : const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color(0xff333333),
        Color(0xff333333),
      ],
    ),
  );

  static TextStyle textStyleMenu(double fontSize) {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light
        ? TextStyle(
            fontFamily: 'Myriad-Pro-Light',
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: const Color(0xff404040),
          )
        : TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Myriad-Pro-Light',
            color: const Color(0xffFFFFFF),
            fontSize: fontSize,
          );
  }
}

class ThemeModel with ChangeNotifier {
  final ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeModel(this._mode);
}
