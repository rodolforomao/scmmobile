import 'package:flutter/material.dart';

class GlobalScaffold {

  static final GlobalScaffold instance = GlobalScaffold();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  OnToastInformacaoErro(String Mensagem) {
    OnHideCurrentSnackBar();
    final snackBar = SnackBar(
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        Mensagem,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: false,
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xffFFFFFF),
            fontFamily: "avenir-lt-medium"),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Color(0xffe84c3d),
    );
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  OnToastInformacaoSucesso(String Mensagem) {
    OnHideCurrentSnackBar();
    final snackBar = SnackBar(
      elevation: 2.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        Mensagem,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        softWrap: false,
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xffFFFFFF),
            fontFamily: "avenir-lt-medium"),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Color(0xff30bc8c),
    );
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  OnHideCurrentSnackBar() {
    if (scaffoldKey.currentState!.showSnackBar != null)
      scaffoldKey.currentState!.hideCurrentSnackBar();
  }

  OnToastConexaoInternet(String Mensagem) {
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
            FittedBox(fit:BoxFit.fitWidth,
                child: Text(
                  "Tentando reconectar a internet",
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'avenir-lt-std-medium',
                      fontSize: 13.0,
                      color: Color(0xffFFFFFF)),
                )),
            SizedBox(height: 10.0),
            SizedBox(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff5c9e3b)),
              ),
              height: 30.0,
              width: 30.0,
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
    if (scaffoldKey.currentState!.showSnackBar != null)
      scaffoldKey.currentState!.hideCurrentSnackBar();
    else
      scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  OnToastRealizandoOperacao(String Mensagem) {
    OnHideCurrentSnackBar();
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
                Mensagem,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
            SizedBox(width: 5.0,),
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
    scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
