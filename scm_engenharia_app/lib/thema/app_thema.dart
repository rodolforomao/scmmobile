import 'package:flutter/material.dart';

class AppThema {
  static final themeNotifierState = ValueNotifier<ThemeModel>(ThemeModel(ThemeMode.light));

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xffFFFFFF),
      primarySwatch: Colors.red,
      canvasColor: const Color(0xffFFFFFF),
      primaryColor:const Color(0xFFF65100),
      primaryColorDark: const Color(0xff000000),
      primaryColorLight: const Color(0xffFFFFFF),
      splashColor: const Color(0xFFF65100),
      iconTheme: const IconThemeData(color: Color(0xFF545454)),

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
      dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 5
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
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins-Regular',
            color:  Color(0xffFFFFFF),
            fontSize: 15,
          ),
          backgroundColor: const Color(0xFFef7d00),
          shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(5.0),
          ),
        ),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF2fdf84)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(250, 45),
          maximumSize: const Size(250, 45),
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 25.0,
            fontFamily: 'Poppins-Regular',
            color: Color(0xFFffffff),
          ),
          side: const BorderSide(
            color: Color(0xFFef7d00), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 1.0, //width of the border
          ),
          backgroundColor: Color(0xFFef7d00),
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
          thumbColor: MaterialStateProperty.all(Colors.black12),
          radius: const Radius.circular(10),
          minThumbLength: 100),
      cardTheme:  CardTheme(color: const Color(0xffFFFFFF),surfaceTintColor:const Color(0xffFFFFFF) , shadowColor: const Color(0xffFFFFFF), elevation: 3,shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xffFFFFFF),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ), ),
      buttonTheme:ButtonThemeData(buttonColor: Color(0xff093d6c),disabledColor: Colors.deepPurple,focusColor: Colors.amber,hoverColor:Colors.green, splashColor:Colors.brown),
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xffFFFFFF),scrimColor: Colors.transparent,elevation: 2,width: 310,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),),
      popupMenuTheme: const PopupMenuThemeData(
        textStyle: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 16.0,
            color: Color(0xFF424242),
            fontFamily: "Poppins-Medium"),
      )
  );
}

class StylesThemas {

  static BoxDecoration boxDecorationAppBar =
  AppThema.themeNotifierState.value.mode == ThemeMode.light
      ?  const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/img/fundo_tela_configuracoes_top.png'),
        fit: BoxFit.fill,
      )
  )
      : const  BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/img/fundo_tela_configuracoes.png'),
        fit: BoxFit.fill,
      )
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

  static TextStyle textStyleTextTitle() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light ? const TextStyle(
      fontFamily: 'Poppins-Regular',
      fontSize: 13.0,
      fontWeight: FontWeight.w300,
      color: Color(0xff3F4143),
    )
        : const TextStyle(
      fontWeight: FontWeight.w300,
      fontFamily: 'Poppins-Regular',
      color: Color(0xffFFFFFF),
    );
  }

  static TextStyle textStyleTextSubtitle() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light
        ? const TextStyle(
      fontFamily: 'Myriad-Pro-SemiExt',
      fontWeight: FontWeight.w300,
      color: Color(0xff404040),
    )
        : const TextStyle(
      fontWeight: FontWeight.w300,
      fontFamily: 'Myriad-Pro-SemiExt',
      color: Color(0xffFFFFFF),
    );
  }

  static TextStyle textStyleTextSpanTitle() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light ? const TextStyle(
      fontFamily: 'Poppins-Regular',
      fontWeight: FontWeight.w300,
      fontSize: 17,
      color: Color(0xff3F4143),
    )
        : const TextStyle(
      fontWeight: FontWeight.w300,
      fontFamily: 'Poppins-Regular',
      color: Color(0xffFFFFFF),
    );
  }

  static TextStyle textStyleTextSpanSubtitle() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light
        ? const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15.0,
        color: Color(0xff979797),
        fontFamily: "Poppins-Regular",
    )
        : const TextStyle(
      fontWeight: FontWeight.w300,
      fontFamily: 'Myriad-Pro-SemiExt',
      color: Color(0xffFFFFFF),
    );
  }

  static TextStyle textStyleTextField() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light
        ? const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 17.0,
        color:  Color(0xff3a3a3a),
        fontFamily: 'MyriadArabic-Regular_0')
        : const TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: 'Myriad-Pro-SemiExt',
      color: Color(0xffFFFFFF),
    );
  }


  static TextStyle textStyleTextButton() {
    return AppThema.themeNotifierState.value.mode == ThemeMode.light ? const TextStyle(
      fontFamily: 'roboto-regular',
      fontWeight: FontWeight.w100,
      color: Colors.white,
      fontSize: 17,)
        : const TextStyle(
      //fontWeight: FontWeight.w200,
      fontFamily: 'roboto-regular',
      color: Color(0xffFFFFFF),
    );
  }
}

class ThemeModel with ChangeNotifier {
  final ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeModel(this._mode);
}
