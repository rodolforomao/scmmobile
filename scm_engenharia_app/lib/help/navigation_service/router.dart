import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../views/configuracoes/configuracoes_view.dart';
import '../../views/inicio_view.dart';
import '../../views/splash_screen_view.dart';
import '/help/navigation_service/route_paths.dart' as routes;
import '../../views/error_information_view.dart';
import '../../views/menu_navigation.dart';
import '../../views/settings_view.dart';
import '../../views/user_views/change_password_view.dart';
import '../../views/user_views/create_new_account_view.dart';
import '../../views/user_views/forgot_your_password_view.dart';
import '../../views/user_views/login_view.dart';
import '../../views/user_views/profile_view.dart';


Route<dynamic> generateRoute(RouteSettings settings) {

  String? routesName = settings.name;
  Map<String, dynamic>  map = {};
  if(settings.arguments != null)
  {
    map = settings.arguments as Map<String, dynamic>;
  }
  switch (routesName) {
    case '/':
      {
        return MaterialPageRoute(builder: (context) => const SplashScreenView());
      }
    case routes.errorInformationRoute:
      {
        return MaterialPageRoute(builder: (context) => ErrorInformationView(map: map,));
      }
    case routes.splashScreenRoute:
      return MaterialPageRoute(builder: (context) => const SplashScreenView());
    case routes.inicioRoute:
      return MaterialPageRoute(builder: (context) => const InicioView());
    case routes.loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case routes.createNewAccountRoute:
      return MaterialPageRoute(builder: (context) => const CreateNewAccountView());
    case routes.forgotYourPasswordRoute:
      return MaterialPageRoute(builder: (context) => const ForgotYourPasswordView());
  //Configurações
    case routes.configuracoesRoute:
      return MaterialPageRoute(builder: (context) => const Configuracoesview());
  //Erro
    default:
      {
        Map<String, dynamic> map = {
          'view': 'Não Identificado',
          'error': 'Sem caminho para ${settings.name}'
        };
        return MaterialPageRoute(builder: (context) => ErrorInformationView(map: map,));
      }

  }
}


class RoutesPage {
  static Map<String, WidgetBuilder> onRoutesPage() {
    Map<String, WidgetBuilder>? pages = {
      routes.errorInformationRoute : (context) => ErrorInformationView(map: {}),
      routes.menuNavigationRoute : (context) => MenuNavigation(),
      routes.settingsRoute : (context) => const SettingsView(),
      routes.splashScreenRoute : (context) => const SplashScreenView(),

      // Visualizações sici ----------------------------------------------------------------------------------------------------


      //Visualizações de notificação -------------------------------------------------------------------------------------------


      //Visualizações de configurações------------------------------------------------------------------------------------------


      //Visualizações do usuário -----------------------------------------------------------------------------------------------
      routes.changePasswordRoute : (context) => const ChangePasswordView(),
      routes.createNewAccountRoute : (context) => const CreateNewAccountView(),
      routes.forgotYourPasswordRoute : (context) => const ForgotYourPasswordView(),
      routes.loginRoute : (context) => const LoginView(),
      routes.perfilRoute : (context) => const ProfileView(),

    };
    return pages;
  }
}