import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../data/app_scm_engenharia_mobile_bll.dart';
import '../models/operation.dart';
import '../views/help_views/global_scaffold.dart';


class Componentes {

  static String quantidadeMaxima(String Txt, int Quantidade) {
    try {
      if (Txt.toString().isEmpty) return "";
      if (Quantidade <= Txt.trim().length) {
        return Txt.substring(0, Quantidade);
      } else {
        return Txt;
      }
    } catch (error) {
      {}
    }
    return Txt;
  }

  static String? JWTToken(String User, String password) {
    try {
      String key = "bc47f175a831996b652146d47e159349f75e6c4665570ef35606678a18054d13";
      final claimSet = new JwtClaim(otherClaims: <String, Object>{
        "user": "" + User + "",
        "pass": "" + password + "",
      });
      // Generate a JWT from the claim set
      final token = issueJwtHS256(claimSet, key);
      return token;
    } catch (error) {

    }
    return null;
  }

  static String? JWTTokenPadrao() {
    try {
      String key =
          "bc47f175a831996b652146d47e159349f75e6c4665570ef35606678a18054d13";
      final claimSet = new JwtClaim(otherClaims: <String, Object>{
        "user": "" + 'scm_app@scmengenharia.com.br' + "",
        "pass": "" + '123456' + "",
      });
      // Generate a JWT from the claim set
      final token = issueJwtHS256(claimSet, key);
      return token;
    } catch (error) {}
    return null;
  }

  static String removeAllHtmlTags(String htmlText) {
    String tagInicial = "<div ";
    int index1 = htmlText.toString().indexOf(tagInicial);
    if (index1 >= 0) {
      index1 = 0;
      String tagFinal = "</div>";
      int index2 = htmlText.toString().lastIndexOf(tagFinal) + tagFinal.length;
      var errorhtml = htmlText.toString().substring(index1, index2);
      int index3 = htmlText.toString().length;
      return htmlText.toString().substring(index2, index3).trim();
    } else {
      return htmlText;
    }
  }

  static Future<List<Object>> OnlistaEstados() async {
    List<String> listaEstados = [];
    listaEstados.add("Selecione...");
    listaEstados.add("AC");
    listaEstados.add("AL");
    listaEstados.add("AP");
    listaEstados.add("AM");
    listaEstados.add("BA");
    listaEstados.add("CE");
    listaEstados.add("DF");
    listaEstados.add("ES");
    listaEstados.add("GO");
    listaEstados.add("MA");
    listaEstados.add("MT");
    listaEstados.add("MS");
    listaEstados.add("MG");
    listaEstados.add("PA");
    listaEstados.add("PB");
    listaEstados.add("PR");
    listaEstados.add("PE");
    listaEstados.add("PI");
    listaEstados.add("RJ");
    listaEstados.add("RN");
    listaEstados.add("RS");
    listaEstados.add("RO");
    listaEstados.add("RR");
    listaEstados.add("SC");
    listaEstados.add("SP");
    listaEstados.add("SE");
    listaEstados.add("TO");
    return listaEstados;
  }

  static Future<List<Object>> OnListaGenero() async {
    List<String> listaGenero = [];
    listaGenero.add('Selecione...');
    listaGenero.add('Masculino');
    listaGenero.add("Fermino");
    listaGenero.add("Outros");
    listaGenero.add("Não quero informar");
    return listaGenero;
  }

  static logoffApp() async {
    try {
      Operation accessTokenBll = await  AppScmEngenhariaMobileBll.instance.onDeleteUser();
      if (accessTokenBll.erro) {
        throw accessTokenBll.message!;
      } else if (accessTokenBll.result == null) {
        throw accessTokenBll.message!;
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(GlobalScaffold.instance.navigatorKey.currentContext!).pushNamedAndRemoveUntil(routes.loginRoute, (Route<dynamic> route) => false);
        });
      }
    } catch (error) {
      throw (error.toString());
    }
  }

}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
