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
        appId: '1:589397434520:ios:9fea924cbc6113584af0ed',
        apiKey: 'AIzaSyA8jxsFWpmphsew4r6Z593UECkdzEKU0nI',
        projectId: 'geap-portal-prestador',
        messagingSenderId: '589397434520',
        iosBundleId: 'br.org.geap.portal.prestador',
        iosClientId: 'com.googleusercontent.apps.589397434520-k4nsjt1hr6e691gnsq45eh96tqigrfi8',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:903936319018:android:6561a6cc93335c71186d53',
        apiKey: 'AIzaSyAFfZBri1grL4KGaxWvFc6Q1A-59f7Y4A4',
        projectId: 'app-scm',
        messagingSenderId: '903936319018',
        androidClientId: '903936319018-5mo9ndlsgcst0eb4uia3vf451tukatb6.apps.googleusercontent.com',
      );
    }
  }
}