import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../data/app_scm_engenharia_mobile_bll.dart';
import '../models/info_app.dart';
import '../models/operation.dart';
import '../models/util_model/util_dropdown_list.dart';
import '../views/help_views/global_scaffold.dart';


class Components {

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

  static logoffApp(String cpf) async {
    try {
      Operation accessTokenBll = await  AppScmEngenhariaMobileBll.instance.onDeleteUser();
      if (accessTokenBll.erro) {
        throw accessTokenBll.message!;
      } else if (accessTokenBll.result == null) {
        throw accessTokenBll.message!;
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.android) {
            await FirebaseMessaging.instance.unsubscribeFromTopic('NroCPF-${cpf}' ?? 'ScmEngenhariaLogadoAll');
            await FirebaseMessaging.instance.unsubscribeFromTopic('ScmEngenhariaLogadoAll');
            await FirebaseMessaging.instance.subscribeToTopic('ScmEngenhariaNLogadoAll');
          }
          Navigator.of(GlobalScaffold.instance.navigatorKey.currentContext!).pushNamedAndRemoveUntil(routes.loginRoute, (Route<dynamic> route) => false);
        });
      }
    } catch (error) {
      throw (error.toString());
    }
  }

  //Meses do ano
  static Future<List<UtilDropdownList>> onMonths() async {
    List<UtilDropdownList> list = <UtilDropdownList>[];
    list.add(UtilDropdownList(id: 0, txt: 'Selecione...', txtDescricao: 'Selecione...'));
    list.add(UtilDropdownList(id: 1, txt: 'Janeiro', txtDescricao: 'Janeiro'));
    list.add(UtilDropdownList(id: 2, txt: 'Fevereiro', txtDescricao: 'Fevereiro'));
    list.add(UtilDropdownList(id: 3, txt: 'Março', txtDescricao: 'Março'));
    list.add(UtilDropdownList(id: 4, txt: 'Abril', txtDescricao: 'Abril'));
    list.add(UtilDropdownList(id: 5, txt: 'Maio', txtDescricao: 'Maio'));
    list.add(UtilDropdownList(id: 6, txt: 'Junho', txtDescricao: 'Junho'));
    list.add(UtilDropdownList(id: 7, txt: 'Julho', txtDescricao: 'Julho'));
    list.add(UtilDropdownList(id: 8, txt: 'Agosto', txtDescricao: 'Agosto'));
    list.add(UtilDropdownList(id: 9, txt: 'Setembro', txtDescricao: 'Setembro'));
    list.add(UtilDropdownList(id: 10, txt: 'Outubro', txtDescricao: 'Outubro'));
    list.add(UtilDropdownList(id: 11, txt: 'Novembro', txtDescricao: 'Novembro'));
    list.add(UtilDropdownList(id: 12, txt: 'Dezembro', txtDescricao: 'Dezembro'));
    return list;
  }

  static Future<InfoApp> onInfo() async {

    try {
      InfoApp infoApp = InfoApp();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if(GlobalScaffold.position != null)
      {
        infoApp.latitude  = GlobalScaffold.position!.latitude.toString();
        infoApp.longitude = GlobalScaffold.position!.longitude.toString();
      }
      else
      {
        infoApp.latitude = '';
        infoApp.longitude= '';
      }
      infoApp.appName = packageInfo.appName;
      infoApp.buildNumber  = packageInfo.buildNumber.isEmpty ? packageInfo.version : packageInfo.buildNumber;
      infoApp.version = packageInfo.version.replaceAll('.', '');
      infoApp.dataAcesso = DateTime.now().toString();
      if(kIsWeb)
      {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        infoApp.device = webBrowserInfo.userAgent;
        infoApp.appName = 'GEAP Prestador';
        infoApp.buildNumber  = packageInfo.buildNumber;
        infoApp.version = packageInfo.version;
      }
      else if(Platform.isAndroid)
      {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        infoApp.idProduct = androidInfo.bootloader  ?? '';
        infoApp.idDevice = androidInfo.id ?? '';
        infoApp.buildNumber = packageInfo.version;
        infoApp.version = packageInfo.buildNumber;
        infoApp.deviceVersion = '${androidInfo.brand} - ${androidInfo.model}';
        infoApp.device = 'Android';
      }
      else if(Platform.isIOS)
      {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        infoApp.idProduct = iosInfo.identifierForVendor  ?? '';
        infoApp.idDevice = iosInfo.identifierForVendor ?? '';
        infoApp.deviceVersion = iosInfo.utsname.machine ?? '';
        infoApp.device = 'IOS';
        infoApp.version = packageInfo.version ?? '';
        infoApp.buildNumber = packageInfo.buildNumber ?? '';

      }
      else if(Platform.isMacOS) {
        MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
        infoApp.idProduct = macOsInfo.systemGUID ?? '';
        infoApp.idDevice = macOsInfo.systemGUID ?? '';
        infoApp.deviceVersion = macOsInfo.model ?? '';
        infoApp.device = 'MacOs';
        infoApp.version = packageInfo.version ?? '';
        infoApp.buildNumber = packageInfo.buildNumber ?? '';
      } else if(Platform.isLinux) {
        infoApp.device =  'linux';
      } else if(Platform.isWindows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
        infoApp.idProduct = windowsInfo.productId ?? '';
        infoApp.idDevice = windowsInfo.deviceId ?? '';
        infoApp.idDevice = infoApp.idDevice!.replaceAll('{', '').replaceAll('}', '');
        infoApp.deviceVersion = windowsInfo.productName ?? '';
        infoApp.device = 'Windows';
      } else if(Platform.isFuchsia) {
        infoApp.device =  'fuchsia';
      } else {
        infoApp.device = 'outros';
      }
      return infoApp;
    } catch (error) {
      throw 'Erro de exceção : $error';
    }
  }

  static Future<Position?> onDeterminarPosicao() async {
    try {
      LocationPermission permission;
      // Teste se os serviços de localização estão habilitados.
      if (!await Geolocator.isLocationServiceEnabled()) {
        // Os serviços de localização não estão habilitados, não continue
        // acessando a posição e solicitando aos usuários do
        // App para habilitar os serviços de localização.
        throw 'Os serviços de localização estão desativados.';
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // As permissões são negadas, da próxima vez você pode tentar
          // solicitando permissões novamente (também é onde
          // shouldShowRequestPermissionRationale do Android
          // retornou verdadeiro. De acordo com as diretrizes do Android
          // seu aplicativo deve mostrar uma IU explicativa agora.
          throw 'As permissões de localização foram negadas';
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // As permissões são negadas para sempre, manuseie apropriadamente.
        throw 'As permissões de localização são negadas permanentemente, não podemos solicitar permissões.';
      }
      // Quando chegamos aqui, as permissões são concedidas e podemos
      // continue acessando a posição do dispositivo.
      return await Geolocator.getCurrentPosition();
    } catch (error) {
      return null;
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
