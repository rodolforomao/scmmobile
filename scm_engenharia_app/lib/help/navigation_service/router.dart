import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../views/sici_views/list_sici_sent_view.dart';
import '../../views/sici_views/data_in_services_view.dart';
import '../../views/sici_views/select_municipality_view.dart';
import '../../views/sici_views/sici_fust_form_view.dart';
import '../../views/splash_screen_view.dart';
import '/help/navigation_service/route_paths.dart' as routes;
import '../../views/error_information_view.dart';
import '../../views/menu_navigation.dart';
import '../../views/notification_views/notification_view.dart';
import '../../views/notification_views/notifications_view.dart';
import '../../views/settings_view.dart';
import '../../views/settings_views/environment_variable_view.dart';
import '../../views/user_views/change_password_view.dart';
import '../../views/user_views/create_new_account_view.dart';
import '../../views/user_views/forgot_your_password_view.dart';
import '../../views/user_views/login_view.dart';
import '../../views/user_views/profile_view.dart';


Route<dynamic> generateRoute(RouteSettings settings) {

  String? routesName = settings.name;
  switch (routesName) {
  //#region  outros
    case '/':
      {
        return MaterialPageRoute(builder: (context) => const SplashScreenView());
      }
    case routes.splashScreenRoute:
      return MaterialPageRoute(builder: (context) => const SplashScreenView());
    case routes.errorInformationRoute:
      {
        final arg =  settings.arguments as Map;
        return MaterialPageRoute(builder: (context) => ErrorInformationView(informacao: arg['error'],originPage: arg['view'],));
      }
    case routes.menuNavigationRoute:
      return MaterialPageRoute(builder: (context) => MenuNavigation());
    case routes.settingsRoute:
      return CupertinoPageRoute(
        maintainState: false,
        fullscreenDialog: true,
        builder: (BuildContext context) =>
            const SettingsView(),
      );

  //#endregion

  //#region  Visualizações sici

    case routes.listSiciSentRoute:
      {
        return MaterialPageRoute(builder: (context) => ListSiciSentView());
      }
    case routes.physicalDistributionQuantitativeServiceRoute:
      {
        return MaterialPageRoute(builder: (context) => DataInServicesView(sDadosEmServicos: null,));
      }
    case routes.siciFustFormRoute:
      {
        return MaterialPageRoute(builder: (context) => SiciFustFormView(siciFileModel: null,));
      }
  //#endregion

  //#region  notificação

    case routes.notificationRoute:
      {
        return MaterialPageRoute(builder: (context) => NotificationView(idNotificacao: '',));
      }
    case routes.notificationsRoute:
      {
        return MaterialPageRoute(builder: (context) => const NotificationsView());
      }
  //#endregion

  //#region  Visualizações de configurações

    case routes.environmentVariableRoute:
      {
        return MaterialPageRoute(builder: (context) => const EnvironmentVariableView());
      }
    case routes.selectCityRoute:
      {
        return MaterialPageRoute(builder: (context) =>  SelectMunicipalityView(sMunicipios: [],sUf:null));
      }
  //#endregion

  //#region  Visualizações do usuário

    case routes.changePasswordRoute:
      {
        return MaterialPageRoute(builder: (context) => ChangePasswordView());
      }
    case routes.createNewAccountRoute:
      {
        return MaterialPageRoute(builder: (context) =>  CreateNewAccountView());
      }
    case routes.forgotYourPasswordRoute:
      {
        return MaterialPageRoute(builder: (context) =>  ForgotYourPasswordView());
      }
    case routes.loginRoute:
      {
        return MaterialPageRoute(builder: (context) =>  LoginView());
      }
    case routes.perfilRoute:
      {
        return MaterialPageRoute(builder: (context) =>  ProfileView());
      }
  //#endregion


  //Erro
    default:
      {
        print(settings);
        print(settings.name);
        print(settings.arguments);
        //Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Sem caminho para ${settings.name}' ),
            ),
          ),
        );
      }

  }
}


class RoutesPage {
  static Map<String, WidgetBuilder> onRoutesPage() {
    Map<String, WidgetBuilder>? pages = {
      routes.errorInformationRoute : (context) => ErrorInformationView(informacao:'Ops! Algo de errado aconteceu? Não se preocupe, vou te ajudar a resolver!',originPage:''),
      routes.menuNavigationRoute : (context) => MenuNavigation(),
      routes.settingsRoute : (context) => const SettingsView(),
      routes.splashScreenRoute : (context) => const SplashScreenView(),

      // Visualizações sici ----------------------------------------------------------------------------------------------------
      routes.listSiciSentRoute : (context) => const ListSiciSentView(),
      routes.physicalDistributionQuantitativeServiceRoute : (context) => DataInServicesView(sDadosEmServicos: null,),
      routes.siciFustFormRoute : (context) => SiciFustFormView(siciFileModel: null,),

      //Visualizações de notificação -------------------------------------------------------------------------------------------
      routes.notificationRoute : (context) => NotificationView(idNotificacao: '',),
      routes.notificationsRoute : (context) => NotificationsView(),

      //Visualizações de configurações------------------------------------------------------------------------------------------
      routes.environmentVariableRoute : (context) => EnvironmentVariableView(),
      routes.selectCityRoute : (context) => SelectMunicipalityView(sMunicipios: [],sUf:null),

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