import 'package:connectivity_plus/connectivity_plus.dart';

import '../views/help_views/global_scaffold.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
mixin class ParameterResultViewEvent {


  TypeView statusTypeView = TypeView.viewLoading;
  String erroInformation = 'Ops! Algo de errado aconteceu? Não se preocupe, vou te ajudar a resolver!';

}

mixin class ParameterResultFunctions {


  onError(String error)  {
    GlobalScaffold.instance.navigatorKey.currentState?.pushNamed(
      routes.errorInformationRoute,
      arguments: {
        'error': error
      },
    ).then((value) {
      GlobalScaffold.instance.navigatorKey.currentState?.popUntil((route) => route.isFirst);
      GlobalScaffold.instance.onToastInternetConnection();
    });
  }

  Future<bool> onIncConnectivity() async {
    if (await (Connectivity().checkConnectivity().asStream()).contains(ConnectivityResult.none))
    {
      await  GlobalScaffold.instance.navigatorKey.currentState?.pushNamed(
        routes.errorInformationRoute,
      ).then((value) async {
        if (await (Connectivity().checkConnectivity().asStream()).contains(ConnectivityResult.none))  {
          return false;
        }
        else
        {
          return true;
        }
      });
      return false;
    }
    else
    {
      return true;
    }
  }
}