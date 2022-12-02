import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          apiKey: "AIzaSyB2lk4kC3U_jU2ocs3HKDFQOrVAHOCfEEA",
          authDomain: "app-scm.firebaseapp.com",
          projectId: "app-scm",
          storageBucket: "app-scm.appspot.com",
          messagingSenderId: "903936319018",
          appId: "1:903936319018:web:f596a0554cced492186d53",
          measurementId: "G-HJEEHSGB56"
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:903936319018:ios:26acf1d4d3e67df3186d53',
        apiKey: 'AIzaSyDUN99Krs9w0Tb9cZ3JqZhuqJL5fwOVhws',
        projectId: 'br.com.scmengenharia.dici',
        messagingSenderId: '903936319018',
        iosBundleId: 'br.com.scmengenharia.dici',
        iosClientId: 'com.googleusercontent.apps.903936319018-a086hdddnoasbpd2bmphp8r7c8p47ha7',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:903936319018:android:6561a6cc93335c71186d53',
        apiKey: 'AIzaSyCuh0iIHS7FQbk4ynaH6Ia4NEugFqX9uP4',
        projectId: 'app-scm',
        messagingSenderId: '903936319018',
        androidClientId: '903936319018-5mo9ndlsgcst0eb4uia3vf451tukatb6.apps.googleusercontent.com',
      );
    }
  }
}