import 'package:flutter/material.dart';
import '../../views/documents_views/certidoes_view.dart';
import '../../views/documents_views/contratos_view.dart';
import '../../views/documents_views/recibos_view.dart';
import '../../views/financial_views/recibos_view.dart';
import '../../views/inicio_view.dart';
import '../../views/others_view/analises_view.dart';
import '../../views/settings_views/alterar_senha_view.dart';
import '../../views/settings_views/configuracoes_view.dart';
import '../../views/settings_views/perfil_view.dart';
import '../../views/settings_views/sobre_view.dart';
import '../../views/settings_views/variaveis_de_ambiente_view.dart';
import '../../views/splash_screen_view.dart';
import '/help/navigation_service/route_paths.dart' as routes;
import '../../views/error_information_view.dart';
import '../../views/menu_navigation.dart';
import '../../views/settings_view.dart';

import '../../views/user_views/criar_nova_conta_view.dart';
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
    case routes.menuNavigationRoute:
      {
        return MaterialPageRoute(builder: (context) =>  MenuNavigation());
      }
    case routes.dashboardRoute:
      {
        return MaterialPageRoute(builder: (context) =>  MenuNavigation());
      }
    case routes.splashScreenRoute:
      return MaterialPageRoute(builder: (context) => const SplashScreenView());
    case routes.inicioRoute:
      return MaterialPageRoute(builder: (context) => const InicioView());
    case routes.loginRoute:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case routes.createNewAccountRoute:
      return MaterialPageRoute(builder: (context) => const CriarNovaContaView());
    case routes.forgotYourPasswordRoute:
      return MaterialPageRoute(builder: (context) => const ForgotYourPasswordView());
    case routes.analisesRoute:
      return MaterialPageRoute(builder: (context) => const AnalisesView());
    case routes.recibosRoute:
      return MaterialPageRoute(builder: (context) => const RecibosView());
  //Documentos
    case routes.certidoesRoute:
      return MaterialPageRoute(builder: (context) => const CertidoesView());
    case routes.contratosRoute:
      return MaterialPageRoute(builder: (context) => const ContratosView());
    case routes.recibosDocumentosRoute:
      return MaterialPageRoute(builder: (context) => const RecibosDocumentosView());
  //Configurações
    case routes.configuracoesRoute:
      return MaterialPageRoute(builder: (context) => const Configuracoesview());
    case routes.alterarSenhaRoute:
      return MaterialPageRoute(builder: (context) => const AlterarSenhaView());
    case routes.perfilRoute:
      return MaterialPageRoute(builder: (context) => const PerfilView());
    case routes.variaveisDeAmbienteRoute:
      return MaterialPageRoute(builder: (context) => const VariaveisDeAmbienteView());
    case routes.sobreRoute:
      return MaterialPageRoute(builder: (context) => const SobreView());
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
      routes.changePasswordRoute : (context) => const AlterarSenhaView(),
      routes.forgotYourPasswordRoute : (context) => const ForgotYourPasswordView(),
      routes.loginRoute : (context) => const LoginView(),
      routes.perfilRoute : (context) => const ProfileView(),

    };
    return pages;
  }
}