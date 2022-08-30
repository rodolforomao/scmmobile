import 'dart:io';
import 'dart:math';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scm_engenharia_app/views/help_views/global_scaffold.dart';
import 'package:scm_engenharia_app/views/splash_screen_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'help/navigation_service/router.dart';
import 'thema/app_thema.dart';
import 'package:scm_engenharia_app/help/navigation_service/route_paths.dart' as routes;
import 'package:scm_engenharia_app/help/navigation_service/router.dart' as router;

final navigatorKey = GlobalKey<NavigatorState>();
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  //NotificationHandler().initializeFcmNotification();

  SharedPreferences.getInstance().then((prefs) {
    bool? darkModeOn = prefs.getBool('darkMode');
    print(darkModeOn);
    print('darkMode inc');
    AppThema.themeNotifierState.value = ThemeModel(darkModeOn == false ? ThemeMode.dark : ThemeMode.light);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeModel>(
      valueListenable:  AppThema.themeNotifierState,
      builder: (_, model, __) {
        final mode = model.mode;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: GlobalScaffold.instance.navigatorKey,
          scaffoldMessengerKey: GlobalScaffold.instance.messangerKey,
          onGenerateRoute: router.generateRoute,
          initialRoute: routes.splashScreenRoute,
          //routes:RoutesPage.onRoutesPage(),
          title: 'SCM Engenharia',
          builder: (context ,child){
            return Scaffold(
              key: GlobalScaffold.instance.globalKey,
              body: child,
            );
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('pt', 'BR')],
          theme: AppThema.lightTheme.copyWith(
            pageTransitionsTheme:  const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                  transitionType: SharedAxisTransitionType.horizontal,
                ),
                TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                  transitionType: SharedAxisTransitionType.horizontal,
                ),
              },
            ),
          ),
          darkTheme: AppThema.darkTheme,
          themeMode: mode,
          //navigatorObservers: <NavigatorObserver>[GlobalScaffold.observer],
          home:const SplashScreenView(),
        );
      },
    );
  }
}



class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Set default number of rows to be displayed per page
  var _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int nextRecords = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          rowsPerPage: _rowsPerPage,
          source: RowSource(),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {

                });
              },
            ),
          ],
          onPageChanged: (int? n) {
            /// value of n is the number of rows displayed so far
            setState(() {
              if (n != null) {
                debugPrint('onRowsPerPageChanged $_rowsPerPage ${RowSource()._rowCount - n}');

                /// Update rowsPerPage if the remaining count is less than the default rowsPerPage
                if (RowSource()._rowCount - n < _rowsPerPage)
                 {
                   _rowsPerPage = RowSource()._rowCount - n;
                   /// else, restore default rowsPerPage value
                 }
                else
                  {
                    _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
                  }
              } else
                {
                  _rowsPerPage = 0;
                }
            });
          },
          columns: [
            DataColumn(
              label: Text(
                'Foo',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Bar',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  final _rowCount = 41;

  @override
  DataRow? getRow(int index) {
    if (index < _rowCount) {
      return DataRow(cells: <DataCell>[
        DataCell(Text('Foo $index')),
        DataCell(Text('Bar $index'))
      ]);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => _rowCount;

  @override
  int get selectedRowCount => 0;
}