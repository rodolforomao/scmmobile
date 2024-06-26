import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../thema/app_thema.dart';


class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();
  final navigatorKey = GlobalKey<NavigatorState>();
  final messangerKey = GlobalKey<ScaffoldMessengerState>();
  final scaffoldKeyMenuDrawer = GlobalKey<ScaffoldState>();
  final globalKey = GlobalKey<ScaffoldState>();

  late String selectedPageView = routes.dashboardRoute;

  static Color colorSelectedPageView(String value) {
    if(GlobalScaffold.instance.selectedPageView == value)
    {
      return Color(0xffeaeaea);
    }
    else
    {
      return Colors.transparent;
    }
  }

  static Color colorTextIconSelectedPageView(String value) {
    if(GlobalScaffold.instance.selectedPageView == value)
    {
      return Color(0xffd56921);
    }
    else
    {
      return Color(0xff6C757D);
    }
  }

  static  Map<String, dynamic> map = {};
  int selectedPageBottomNavigationIndex = 0;

  static Position? position;

  onToastRedirectUriApp(String mensagem ,Uri url) {
    onHideCurrentSnackBar();
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(FocusNode());
    messangerKey.currentState!.showSnackBar( SnackBar(
        width: 700,
        duration: const Duration(minutes: 1),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: const Color(0xffccf8e4),
        action: SnackBarAction(
          label: 'VER',
          textColor:const Color(0xff2ecd8f),
          onPressed: () {
            onRedirectUriApp(url);
          },
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          constraints: const BoxConstraints(
            minWidth: 50,
            maxWidth: 600,
          ),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5 , top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.warning_amber,
                color: Color(0xff2ecd8f),
                size: 30,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  mensagem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 13, color: const Color(0xff2ecd8f),),
                ),
              ),
            ],
          ),
        )
    ));
  }

  onToastError(String mensagem) {
    onHideCurrentSnackBar();
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(FocusNode());
    messangerKey.currentState!.showSnackBar( SnackBar(
        width: 800,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          constraints: const BoxConstraints(
            minWidth: 70,
            maxWidth: 600,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffffe2df),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xfff56558),
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15 , top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xfff56558),
                size: 30,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  mensagem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 13, color: const Color(0xfff56558),fontWeight: FontWeight.w100,),
                ),
              ),
            ],
          ),
        )
    ));
  }

  onToastSuccess(String mensagem) {
    onHideCurrentSnackBar();
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(FocusNode());
    messangerKey.currentState!.showSnackBar( SnackBar(
        width: 700,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          constraints: const BoxConstraints(
            minWidth: 70,
            maxWidth: 600,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffccf8e4),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xff2ecd8f),
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15 , top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.task_alt,
                color: Color(0xff2ecd8f),
                size: 30,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  mensagem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 13, color: const Color(0xff2ecd8f),),
                ),
              ),
            ],
          ),
        )
    ));
  }

  onToastInformation(String mensagem) {
    onHideCurrentSnackBar();
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(FocusNode());
    messangerKey.currentState!.showSnackBar( SnackBar(
        width: 800,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          constraints: const BoxConstraints(
            minWidth: 70,
            maxWidth: 600,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffffe2df),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xfff56558),
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15 , top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xfff56558),
                size: 30,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  mensagem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 13, color: const Color(0xfff56558),),
                ),
              ),
            ],
          ),
        )
    ));
  }

  onToastInternetConnection() {
    onHideCurrentSnackBar();
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(FocusNode());
    messangerKey.currentState!.showSnackBar( SnackBar(
        width: 700,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          constraints: const BoxConstraints(
            minWidth: 70,
            maxWidth: 600,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffffe2df),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xfff56558),
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10 , top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.wifi_off, color: Color(0xfff56558),size: 40,),
              const SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  'Parece que você está sem internet!\nPor favor, verifique a sua conexão e tente novamente.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 13, color: const Color(0xfff56558),),
                ),
              ),
            ],
          ),
        )
    ));
  }

  onHideCurrentSnackBar() {
    messangerKey.currentState!.removeCurrentSnackBar();
  }

  onToastPerformingOperation(String mensagem) {
    onHideCurrentSnackBar();
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(FocusNode());
    messangerKey.currentState!.showSnackBar( SnackBar(
        width: 700,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: Container(
          constraints: const BoxConstraints(
            minWidth: 70,
            maxWidth: 600,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(0xffef7d00),
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10 , top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  valueColor:  AlwaysStoppedAnimation<Color>(Color(0xffef7d00)),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  mensagem,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 13, color: const Color(0xff858585),),
                ),
              ),
            ],
          ),
        )
    ));
  }

  onRedirectUri(Uri url) async {
    try {
      if (!await launchUrl(url, mode: LaunchMode.inAppWebView, webOnlyWindowName: '_self' ,webViewConfiguration:const WebViewConfiguration(enableJavaScript: true , enableDomStorage: true ,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Methods': '*',
        'Access-Control-Allow-Headers': '*',
      })).whenComplete(() {


      })) throw 'Não foi possível iniciar $url';
    } catch (error) {
      GlobalScaffold.instance.onToastError(error.toString());
    }
  }

  onRedirectUriBlank(Uri url) async {
    try {
      if (!await launchUrl(url, mode: LaunchMode.inAppWebView, webOnlyWindowName: '_blank' ,webViewConfiguration:const WebViewConfiguration(enableJavaScript: true , enableDomStorage: true ,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Methods': '*',
        'Access-Control-Allow-Headers': '*',
      })).whenComplete(() {


      })) throw 'Não foi possível iniciar $url';
    } catch (error) {
      GlobalScaffold.instance.onToastError(error.toString());
    }
  }

  onRedirectUriApp(Uri url) async {
    try {
      if (!await launchUrl(url ,mode: LaunchMode.inAppWebView).whenComplete(() {


      })) throw 'Não foi possível iniciar $url';
    } catch (error) {
      GlobalScaffold.instance.onToastError(error.toString());
    }
  }
}

//--------------------------------------------------------------------------------------------------------


class OnAlert {

  static void onAlertInternet(BuildContext context) {
    if(ModalRoute.of(context)?.isCurrent != true)
    {
      Navigator.pop(context);
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 70,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: Text(
                        'Parece que você está sem internet !\nPor favor, verifique a sua conexão e tente novamente.,',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        softWrap: false,
                        style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 17)
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child:Center(child:  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  const Color(0xfff8ab3a),
                        side: const BorderSide(
                          color: Color(0xfff8ab3a), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                      child:   Text('             OK           ', style: StylesThemas.textStyleTextButton(),),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    ),),
                  ),
                ],
              ),
            ));
      },
    );
  }

  static void onAlertError(BuildContext context,message) {
    if(ModalRoute.of(context)?.isCurrent != true)
    {
      Navigator.pop(context);
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 70,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Informação',
                          style: StylesThemas.textStyleTextTitle().copyWith(fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: const Color(0xff023c6a))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child: Text(
                            message!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            softWrap: false,
                            style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 17 ,fontWeight: FontWeight.w200)
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child:Center(child:  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  const Color(0xfff56558),
                        side: const BorderSide(
                          color: Color(0xfff56558), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                      child:   Text('             OK           ' , style: StylesThemas.textStyleTextButton(),),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    ),),
                  ),
                ],
              ),
            ));
      },
    );
  }

  static void  onAlertConfirmDelete(BuildContext context,String subtitle,VoidCallback onPressedExit,VoidCallback onPressedConfirm) {
    if(ModalRoute.of(context)?.isCurrent != true)
    {
      Navigator.pop(context);
    }
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Atenção!', style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20),),
          content: Text(subtitle.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            softWrap: false,
            style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15),),
          actions: <Widget>[
            const SizedBox(height: 15.0),
            Container(
              height: 55,
              padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
              constraints: const BoxConstraints(
                minWidth: 50,
                maxWidth: 500,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 1 /*or any integer value above 0 (optional)*/,
                    child: TextButton.icon(onPressed: () {
                      Navigator.pop(context);
                    },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(180, 45),
                          maximumSize: const Size(180, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.close_outlined,size: 25,
                          color: Colors.white,),
                        label:  Text('Cancelar', style: StylesThemas.textStyleTextButton()
                        )),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    flex: 1 /*or any integer value above 0 (optional)*/,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(180, 45),
                        maximumSize: const Size(180, 45),
                        backgroundColor: const Color(0xff5cb85c),
                      ),
                      icon: const Icon(
                        Icons.add_outlined, size: 25,
                        color: Colors.white,),
                      //`Icon` to display
                      label:  Text('Confirmar', style: StylesThemas.textStyleTextButton()
                      ),
                      //`Text` to display
                      onPressed: onPressedConfirm,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  static void onAlertSuccess(BuildContext context,message,VoidCallback onPressed) {
    if(ModalRoute.of(context)?.isCurrent != true)
    {
      Navigator.pop(context);
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 70,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Informação',
                          style: StylesThemas.textStyleTextTitle().copyWith(fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: const Color(0xff023c6a))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child: Text(
                            message!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            softWrap: false,
                            style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15)
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child:Center(child:  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  const Color(0xff2ecd8f),
                        side: const BorderSide(
                          color: Color(0xff2ecd8f), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                      //`Text` to display
                      onPressed: onPressed,
                      child:   Text('             OK           ' , style: StylesThemas.textStyleTextButton(),),
                    ),),
                  ),
                ],
              ),
            ));
      },
    );
  }

  static void onAlertInformation(BuildContext context,String message) {
    if(ModalRoute.of(context)?.isCurrent != true)
    {
      Navigator.pop(context);
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 70,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Informação',
                          style: StylesThemas.textStyleTextTitle().copyWith(
                              fontSize: 20.0,
                              color: const Color(0xff023c6a))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child: Text(
                            message,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            softWrap: false,
                            style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 17)
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child:Center(child:  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  const Color(0xfff8ab3a),
                        side: const BorderSide(
                          color: Color(0xfff8ab3a), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                      child:   Text('             OK           ', style: StylesThemas.textStyleTextButton(), ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    ),),
                  ),
                ],
              ),
            ));
      },
    );
  }


}


class OnAlertInformation {
  final String message;
  OnAlertInformation(this.message) {
    showDialog(
      context: GlobalScaffold.instance.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 70,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Text(
                        'Informação',
                        style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20, color: const Color(0xff737373),fontWeight: FontWeight.w200,),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          softWrap: false,
                          style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15, color: const Color(0xff737373),fontWeight: FontWeight.w100,),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child:Center(child:  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  const Color(0xfff8ab3a),
                        side: const BorderSide(
                          color: Color(0xfff8ab3a), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                      child:  const Text('OK',style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                        color: Colors.white,
                      ), ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    ),),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class OnAlertSuccess  {
  final String? message;
  OnAlertSuccess(this.message) {
    showDialog(
      context: GlobalScaffold.instance.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 70,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Informação',
                        style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20, color: const Color(0xff737373),fontWeight: FontWeight.w200,),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        child: Text(
                          message!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          softWrap: false,
                          style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15, color: const Color(0xff737373),fontWeight: FontWeight.w100,),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child:Center(child:  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  const Color(0xff2ecd8f),
                        side: const BorderSide(
                          color: Color(0xff2ecd8f), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                      child:  const Text('OK' ,style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    ),),
                  ),
                ],
              ),
            ));
      },
    );
  }
}



class OnAlertInternet {
  OnAlertInternet() {
    showDialog(
      context: GlobalScaffold.instance.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 70,
                maxWidth: 600,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15.0),
                   Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: Text(
                      'Parece que você está sem internet !\nPor favor, verifique a sua conexão e tente novamente.,',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 13, color: const Color(0xff737373),fontWeight: FontWeight.w100,),
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                    child:Center(child:  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  const Color(0xfff8ab3a),
                        side: const BorderSide(
                          color: Color(0xfff8ab3a), //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 1.0, //width of the border
                        ),
                      ),
                      child:  const Text('OK', style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                        color: Colors.white,
                      ), ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    ),),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

BuildContext? dialogContext;

class OnRealizandoOperacao {
  final String txtInformation;
  BuildContext? context;
  OnRealizandoOperacao(this.txtInformation,this.context) {
    if (txtInformation.isEmpty) {
      if (dialogContext != null)
      {
        if(ModalRoute.of(context!)?.isCurrent != true)
        {
          Navigator.pop(dialogContext!);
          dialogContext = null;
        }
      }
      else {
        dialogContext = null;
      }
    } else {
      showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          Future.delayed(const Duration(minutes: 2), () {
            dialogContext = null;
            Navigator.of(context).pop(true);
            GlobalScaffold.instance.onToastError('O tempo limite da operação foi atingido (Time Out)');
          });
          return Dialog(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 70,
                  maxWidth: 700,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                margin: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                child: Theme(
                  data: Theme.of(context).copyWith( colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xfff5821f))),
                  child: const  CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                        child: Text(
                          txtInformation,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 15,),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      );
    }
  }
}

enum TypeView {
  viewLoading,
  viewRenderInformation,
  viewErrorInformation,
  viewThereIsNoInternet,
}

