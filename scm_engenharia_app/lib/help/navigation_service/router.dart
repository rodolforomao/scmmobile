import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../views/sici_views/list_sici_sent_view.dart';
import '../../views/sici_views/physical_distribution_quantitative_service_view.dart';
import '../../views/sici_views/sici_fust_form_view.dart';
import '../../views/splash_screen.dart';
import '/help/navigation_service/route_paths.dart' as routes;
import '../../views/error_information_view.dart';
import '../../views/menu_navigation.dart';
import '../../views/notification_views/notification_view.dart';
import '../../views/notification_views/notifications_view.dart';
import '../../views/settings_view.dart';
import '../../views/settings_views/environment_variable_view.dart';
import '../../views/settings_views/select_city_view.dart';
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
        return MaterialPageRoute(builder: (context) => SplashScreen());
      }
    case routes.splashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case routes.errorInformationRoute:
      {
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        String view  = map['view'].toString();
        String error = map['error'].toString();
        return MaterialPageRoute(builder: (context) => ErrorInformationView(informacao: error,originPage: view,));
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
        return MaterialPageRoute(builder: (context) => PhysicalDistributionQuantitativeServiceView(sDistribuicaoFisicosServicoQuantitativo: null,));
      }
    case routes.siciFustFormRoute:
      {
        return MaterialPageRoute(builder: (context) => SiciFustFormView(FichaSiciModel: null,));
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
        return MaterialPageRoute(builder: (context) => EnvironmentVariableView(Uf: '', sMunicipality: [],));
      }
    case routes.selectCityRoute:
      {
        return MaterialPageRoute(builder: (context) =>  SelectCityView(sMunicipality: [], Uf: '',));
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
      routes.splashScreenRoute : (context) => SplashScreen(),

      // Visualizações sici ----------------------------------------------------------------------------------------------------
      routes.listSiciSentRoute : (context) => const ListSiciSentView(),
      routes.physicalDistributionQuantitativeServiceRoute : (context) => PhysicalDistributionQuantitativeServiceView(sDistribuicaoFisicosServicoQuantitativo: null,),
      routes.siciFustFormRoute : (context) => SiciFustFormView(FichaSiciModel: null,),

      //Visualizações de notificação -------------------------------------------------------------------------------------------
      routes.notificationRoute : (context) => NotificationView(idNotificacao: '',),
      routes.notificationsRoute : (context) => NotificationsView(),

      //Visualizações de configurações------------------------------------------------------------------------------------------
      routes.environmentVariableRoute : (context) => EnvironmentVariableView(Uf: '', sMunicipality: [],),
      routes.selectCityRoute : (context) => SelectCityView(Uf: '',  sMunicipality: [],),

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