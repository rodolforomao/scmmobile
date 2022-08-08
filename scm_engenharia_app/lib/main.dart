import 'dart:io';
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
          routes:RoutesPage.onRoutesPage(),
          home:const SplashScreenView(),
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
          // navigatorObservers: <NavigatorObserver>[GlobalScaffold.observer],

          //navigatorObservers: <NavigatorObserver>[observer],
        );
      },
    );
  }
}

