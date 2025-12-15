

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  // --------------------------
  // 🔥 ANDROID CONFIG ONLY
  // --------------------------
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyADg53rfzJ5zB2ODsguBmLrsn6TxowNmJ4",
    appId: "1:385536471524:android:bea73acb259d5345c2d7f1",
    messagingSenderId: "385536471524",
    projectId: "corezap-2c4a9",
    storageBucket: "corezap-2c4a9.firebasestorage.app",
  );
}
