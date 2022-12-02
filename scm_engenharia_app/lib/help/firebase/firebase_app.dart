import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';


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


class FirebaseAppGeap {

  static String endpoint = '';

  static onLogEventException(String view,String erro,String endpoint,String nroCPF) async {
   //FirebaseAnalytics analytics = FirebaseAnalytics();
  // await analytics.logEvent(
  //   name: 'view',
  //   parameters: <String, dynamic>{
  //     'string': erro,
   //    'string': endpoint,
   //    'string': endpoint,
   //  },
  // );
  }


}