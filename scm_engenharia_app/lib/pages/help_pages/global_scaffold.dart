import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();
  final navigatorKey = new GlobalKey<NavigatorState>();
  final messangerKey = new GlobalKey<ScaffoldMessengerState>();
  final scaffoldKeyMenuDrawer = new GlobalKey<ScaffoldState>();

  int selectedPageBottomNavigationIndex = 0;
  String selectedPageView = '';
  static String ErroInformacao = 'Ops! Algo de errado aconteceu? Não se preocupe, vou te ajudar a resolver!';


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

}


//--------------------------------------------------------------------------------------------------------

class onAlertaInformacaoErro {
  final String Mensagem;
  final BuildContext context;

  onAlertaInformacaoErro(this.Mensagem, this.context) {
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
                      Mensagem,
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
                      color: Color(0xffe84c3d),
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

class onAlertaInformacaoSucesso {
  final String? mensagem;
  final BuildContext context;

  onAlertaInformacaoSucesso(this.mensagem, this.context) {
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
                      mensagem.toString(),
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

class onRealizandoOperacao {
  final String txtInformacao;
  final bool isRealizandoOperacao;
  BuildContext? context;

  onRealizandoOperacao(this.txtInformacao, this.isRealizandoOperacao, this.context) {
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



