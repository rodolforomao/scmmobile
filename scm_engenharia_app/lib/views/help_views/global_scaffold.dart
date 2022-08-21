import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();
  final navigatorKey = GlobalKey<NavigatorState>();
  final messangerKey = GlobalKey<ScaffoldMessengerState>();
  final scaffoldKeyMenuDrawer = GlobalKey<ScaffoldState>();
  final globalKey = GlobalKey<ScaffoldState>();

  int selectedPageBottomNavigationIndex = 0;
  String selectedPageView = '';
  static String ErroInformacao = 'Ops! Algo de errado aconteceu? Não se preocupe, vou te ajudar a resolver!';
  static  Map<String, dynamic> map = {};

  onToastInformacaoErro(String mensagem) {
    onHideCurrentSnackBar();
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(new FocusNode());
    final snackBar = SnackBar(
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        mensagem,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: false,
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xffFFFFFF),
            fontFamily: 'avenir-lt-medium'),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Color(0xffe84c3d),
    );
    messangerKey.currentState!.showSnackBar(snackBar);
  }

  onToastInformacaoSucesso(String mensagem) {
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(new FocusNode());
    onHideCurrentSnackBar();
    final snackBar = SnackBar(
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        mensagem,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: false,
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xffFFFFFF),
            fontFamily: "avenir-lt-medium"),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Color(0xff4bb263),
    );
    messangerKey.currentState!.showSnackBar(snackBar);
  }

  onHideCurrentSnackBar() {
    if (messangerKey.currentState!.showSnackBar != null)
      messangerKey.currentState!.hideCurrentSnackBar();
  }

  onToastConexaoInternet() {
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(new FocusNode());
    final snackBar = SnackBar(
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        'Parece que você está sem internet 😑 !\nPor favor, verifique a sua conexão e tente novamente.',
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
        softWrap: false,
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xffFFFFFF),
            fontFamily: "avenir-lt-medium"),
      ),
      duration: Duration(seconds: 7),
      backgroundColor: Color(0xffe84c3d),
    );
    messangerKey.currentState!.showSnackBar(snackBar);
  }

  onToastRealizandoOperacao(String mensagem) {
    FocusScope.of(navigatorKey.currentState!.context).requestFocus(new FocusNode());
    final snackBar = SnackBar(
      duration: Duration(days: 365),
      onVisible: () {},
      elevation: 6.0,
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      content: SizedBox(
        height: 30.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                mensagem,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'avenir-lt-std-medium',
                    fontSize: 13.0,
                    color: Color(0xffFFFFFF)),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff5c9e3b)),
              ),
              height: 30.0,
              width: 30.0,
            ),
            SizedBox(
              width: 5.0,
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.black54,
          width: 2,
        ),
      ),
    );
    messangerKey.currentState!.showSnackBar(snackBar);
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
      GlobalScaffold.instance.onToastInformacaoErro(error.toString());
    }
  }
}


//--------------------------------------------------------------------------------------------------------


class OnAlertaInformacaoErro {
  final String Mensagem;
  final BuildContext context;

  OnAlertaInformacaoErro(this.Mensagem, this.context) {
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
                      const Text(
                        'Informação',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xff023c6a)),
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
                          Mensagem,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 17.0,
                            color: Color(0xff737373),
                          ),
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
                        textStyle: const TextStyle(color: Colors.white),
                        backgroundColor: const Color(0xFFC01818),
                        side: const BorderSide(
                          color: Color(0xFFC01818), //Color of the border
                        ),
                      ),
                      child:  const Text('             OK           ', style: TextStyle(color: Colors.white), ),
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

class OnAlertaInformacaoSucesso {
  final String? Mensagem;
  final BuildContext context;

  OnAlertaInformacaoSucesso(this.Mensagem, this.context) {
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
                      const Text(
                        'Informação',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xff023c6a),
                            fontFamily: "Myriad-Pro-Light"),
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
                          Mensagem!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          softWrap: false,
                          style: const TextStyle(
                            fontFamily: 'Myriad-Pro-Light',
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                            color: Color(0xff737373),
                          ),
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
                      child:  const Text('             OK           '),
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
  final String? message;
  final BuildContext context;

  OnAlertInformation(this.message, this.context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Informação",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff212529),
                        fontFamily: "avenir-lt-std-roman"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child:  Text(
                      message.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff212529),
                          fontFamily: "avenir-lt-std-roman"),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xff30bc8c),
                      //`Icon` to display
                      child: Text(
                        '           OK           ',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xffFFFFFF),
                            fontFamily: "avenir-lt-std-roman"),
                      ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

BuildContext? dialogContext;

class OnRealizandoOperacao {
  final String txtInformacao;
  final bool isRealizandoOperacao;
  BuildContext? context;

  OnRealizandoOperacao(this.txtInformacao, this.isRealizandoOperacao, this.context) {
    if (isRealizandoOperacao == false && txtInformacao == '') {
      if (dialogContext != null)
      {
        if(ModalRoute.of(context!)?.isCurrent != true)
        {
          Navigator.pop(dialogContext!);
          dialogContext = null;
        }
      }
      else
        dialogContext = null;
    } else {
      showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, top: 20.0, bottom: 20.0, right: 10.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: Color(0xff018a8a),
                    ),
                    child: new CircularProgressIndicator(),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 10.0, top: 20.0, bottom: 20.0, right: 5.0),
                    child: Text(
                      txtInformacao,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff212529),
                          fontFamily: "open-sans-regular"),
                    ),
                  ),
                ),
              ],
            ),
          );
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

