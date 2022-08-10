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
      splashColor: const Color(0xff3F7EC1),
      iconTheme: const IconThemeData(color: Color(0xFF545454)),
      textTheme:  const TextTheme(
        //labelMedium,
         headline1:TextStyle(color:Color(0xff096c40), fontSize: 72.0, fontWeight: FontWeight.bold),
         headline2:TextStyle(color: Color(0xff6c4009), fontSize: 72.0, fontWeight: FontWeight.bold),
         headline3:TextStyle(color: Color(0xffA3095E), fontSize: 72.0, fontWeight: FontWeight.bold),
         headline4:TextStyle(color: Color(0xff193C70), fontSize: 72.0, fontWeight: FontWeight.bold),
         headline5:TextStyle(color: Color(0xffB28DD1), fontSize: 72.0, fontWeight: FontWeight.bold),
         headline6:TextStyle(color: Color(0xff6b8e23), fontSize: 72.0, fontWeight: FontWeight.bold),
         subtitle1:TextStyle(color: Color(0xff653b10), fontSize: 72.0, fontWeight: FontWeight.bold),
         subtitle2:TextStyle(color:  Color(0xff0c5856), fontSize: 72.0, fontWeight: FontWeight.bold),
         bodyText1:TextStyle(color: Color(0xffe4b0aa), fontSize: 72.0, fontWeight: FontWeight.bold),
         bodyText2:TextStyle(color: Color(0xff284521),fontSize: 72.0, fontWeight: FontWeight.bold),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color(0xFFb8b8b8), width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color(0xFFb8b8b8), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color(0xff093d6c), width: 1.0),
        ),
        contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 16.0),
        border: OutlineInputBorder(),
        helperStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
            color:  Color(0xff093d6c),
            fontFamily: 'avenir-next-rounded-pro-regular'),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
            color:  Color(0xFFb8b8b8),
            fontFamily: 'avenir-next-rounded-pro-regular'),
        labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17.0,
            color: Color(0xFFb8b8b8),
            fontFamily: 'open-sans-regular'),
        floatingLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            color: Color(0xff50093d6c),
            fontFamily: 'open-sans-regular'),
        fillColor: Colors.white,
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
            fontWeight: FontWeight.w500,
            color: Color(0xffFFFFFF),
            fontFamily: 'venir-next-rounded-pro-medium-lt'),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xffFFFFFF),
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: Colors.white,
        unselectedIconTheme: IconThemeData(size: 25, color: Color(0xff6C757D)),
        selectedIconTheme: IconThemeData(size: 28, color: Color(0xff093d6c)),
        selectedItemColor: Color(0xff093d6c),
        unselectedItemColor: Color(0xff6C757D),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          color: Color(0xff093d6c),
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Montserrat-Regular',
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
          padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
          minimumSize: const Size(250, 47),
          maximumSize: const Size(250, 47),
          primary: const Color(0xFFffffff),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'avenir-lt-std-roman',
            color:  Color(0xffFFFFFF),
            fontSize: 15,
          ),
          backgroundColor: const Color(0xff30bc8c),
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(5.0),
          ),
        ),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff093d6c)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(250, 47),
          maximumSize: const Size(250, 47),
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 25.0,
            fontFamily: 'Myriad-Arabic-Regular-0',
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
          primary: const Color(0xFF7A388D),
          onPrimary: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Myriad-Arabic-Regular-0',
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

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xff191919),
      backgroundColor: const Color(0xff191919),
      primaryColor:const Color(0xff093d6c),
      primaryColorDark: const Color(0xff191919),
      primaryColorLight: const Color(0xffFFFFFF),
      splashColor: const Color(0xff3F7EC1),
      iconTheme: const IconThemeData(color: Color(0xFF545454)),
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.amber, fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: Colors.deepOrange, fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(
          fontFamily: 'Myriad-Pro-Light',
          fontWeight: FontWeight.bold,
          fontSize: 19.0,
          color: Color(0xff737373),
        ),//TextField
        bodyText1: TextStyle(color: Colors.deepOrangeAccent, fontSize: 14.0, fontFamily: 'Hind'),
        subtitle1:TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Myriad-P2',
            color: Color(0xFF000000)),//TextField
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color(0xFFb8b8b8), width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color(0xFFb8b8b8), width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Color(0xff093d6c), width: 1.0),
        ),
        contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 16.0),
        border: OutlineInputBorder(),
        helperStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
            color:  Color(0xff093d6c),
            fontFamily: 'Myriad-Hebrew-It-0'),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
            color:  Color(0xFFb8b8b8),
            fontFamily: 'Myriad-Hebrew-It-0'),
        labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 17.0,
            color: Color(0xFFb8b8b8),
            fontFamily: 'Myriad-Hebrew-Regular-0'),
        floatingLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            color: Color(0xff50093d6c),
            fontFamily: 'Myriad-Hebrew-Regular-0'),
        fillColor: Color(0xff80ff9b7b),
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xff000000),
        shadowColor: Color(0xff3F7EC1),
        iconTheme: IconThemeData(
          color: Color(0xffFFFFFF),
        ),
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.w500,
            color: Color(0xffFFFFFF),
            fontFamily: 'Myriad-Pro-SemiExt-It'),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xffFFFFFF),
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: Colors.white,
        unselectedIconTheme: IconThemeData(size: 25, color: Color(0xff6C757D)),
        selectedIconTheme: IconThemeData(size: 28, color: Color(0xff093d6c)),
        selectedItemColor: Color(0xff093d6c),
        unselectedItemColor: Color(0xff6C757D),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontWeight: FontWeight.bold,
          fontSize: 13.0,
          color: Color(0xff093d6c),
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Montserrat-Regular',
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
        headingTextStyle: TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Color(0xff093d6c),
        ),
        dataTextStyle: TextStyle(
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
          padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
          minimumSize: const Size(250, 47),
          maximumSize: const Size(250, 47),
          primary: const Color(0xFFffffff),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'avenir-lt-std-roman',
            color:  Color(0xffFFFFFF),
            fontSize: 15,
          ),
          backgroundColor: const Color(0xFF2fdf84),
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(5.0),
          ),
        ),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff093d6c)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(250, 47),
          maximumSize: const Size(250, 47),
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 25.0,
            fontFamily: 'Myriad-Arabic-Regular-0',
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
          primary: const Color(0xFF7A388D),
          onPrimary: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: 'Myriad-Arabic-Regular-0',
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
      drawerTheme: const DrawerThemeData( backgroundColor: Colors.black,scrimColor: Colors.transparent,elevation: 2,width: 310,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),)
  );
}

class StylesThemas {

  static Color selectedColorPageView() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light
        ? const Color(0xff093d6c)
        : const Color(0xff193e7ec1);
  }

  static Color selectedIconPageView() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light
        ? Color(0xff093d6c)
        : Colors.white;
  }

  //#region TextButton


  //#endregion

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
