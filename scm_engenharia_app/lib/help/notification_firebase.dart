import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

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

class NotificationHandler {
  FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  static final NotificationHandler _singleton =
  new NotificationHandler._internal();

  factory NotificationHandler() {
    return _singleton;
  }

  NotificationHandler._internal();



  initializeFcmNotification() async {
    try {
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          Object JsonEncode = json.encode(message);

          print('on message $JsonEncode');
        },
        onBackgroundMessage: Platform.isIOS ? null : FcmFirebase.myBackgroundMessageHandler,
        onResume: (Map<String, dynamic> message) async {
          Object JsonEncode = json.encode(message);
          print('on resume $JsonEncode');
        },
        onLaunch: (Map<String, dynamic> message) async {
          Object JsonEncode = json.encode(message);
          print('on launch $JsonEncode');
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