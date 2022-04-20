import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/main.dart';
import 'package:scm_engenharia_app/models/model_notificacao.dart';
import 'package:scm_engenharia_app/pages/notificacao_page.dart';
import 'package:scm_engenharia_app/splash_screen.dart';

class FcmFirebase {
  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print('on onBackgroundMessage $data');
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print('on onBackgroundMessage $notification');
    }
  }
}
/*
class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  static late final NotificationHandler _singleton =
  new NotificationHandler._internal();

  factory NotificationHandler() {
    return _singleton;
  }

  NotificationHandler._internal();

  initializeFcmNotification() async {
    try {
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          try {
            Object JsonEncode = json.encode(message);
            ModelNotificacao _Resp = ModelNotificacao.fromJson(jsonDecode(Components.removeAllHtmlTags(JsonEncode.toString())));
            navigatorKey.currentState?.push(
              CupertinoPageRoute(
                  fullscreenDialog: false,
                  builder: (BuildContext context) => NotificacaoPage(idNotificacao:_Resp.data!.idNotificacao!)),
            ).then((value) {
              navigatorKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                  SplashScreen()), (Route<dynamic> route) => false);
            });
            print('on message $message');
          } catch (error) {
            print(error);
          }
        },
        onBackgroundMessage: Platform.isIOS ? null : FcmFirebase.myBackgroundMessageHandler,
        onResume: (Map<String, dynamic> message) async {
          try {
            Object JsonEncode = json.encode(message);
            ModelNotificacao _Resp = ModelNotificacao.fromJson(jsonDecode(Components.removeAllHtmlTags(JsonEncode.toString())));
            navigatorKey.currentState?.push(
              CupertinoPageRoute(
                  fullscreenDialog: false,
                  builder: (BuildContext context) => NotificacaoPage(idNotificacao:_Resp.data!.idNotificacao!)),
            ).then((value) {
              navigatorKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                  SplashScreen()), (Route<dynamic> route) => false);
            });
            print('on message $message');
          } catch (error) {
            print(error);
          }
        },
        onLaunch: (Map<String, dynamic> message) async {
          try {
            Object JsonEncode = json.encode(message);
            ModelNotificacao _Resp = ModelNotificacao.fromJson(jsonDecode(Components.removeAllHtmlTags(JsonEncode.toString())));
            navigatorKey.currentState?.push(
              CupertinoPageRoute(
                  fullscreenDialog: false,
                  builder: (BuildContext context) => NotificacaoPage(idNotificacao:_Resp.data!.idNotificacao!)),
            ).then((value) {
              navigatorKey.currentState?.pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                  SplashScreen()), (Route<dynamic> route) => false);
            });
            print('on message $message');
          } catch (error) {
            print(error);
          }
        },
      );
      if (Platform.isIOS) {
        _fcm.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
        _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
          print("Settings registered: $settings");
        });
      }
      _fcm.getToken().then((token) {
        print(token);
      });
    } catch (error) {
      print(error);
    }
  }

  //inscrever-se no tópico
  subscribeToTopic(String Topic) async {
    _fcm.subscribeToTopic(Topic);
  }

  //cancelar a assinatura do tópico
  unsubscribeFromTopic(String Topic) async {
    _fcm.unsubscribeFromTopic(Topic);
  }

}

 */