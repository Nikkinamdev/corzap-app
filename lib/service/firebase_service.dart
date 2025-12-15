import 'package:corezap_driver/session/session_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

class FirebaseService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final NotificationService noti = NotificationService();

  Future<void> initFirebase() async {
    await noti.init();

    // Request permission (iOS)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.title}");
      noti.showLocal(
        message.notification?.title ?? "New Message",
        message.notification?.body ?? "",
      );
    });

    // Handle when app is opened from notification (terminated or background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification clicked!");
      // TODO: Navigate to specific screen if needed
    });

    // Background messages (terminated state)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Get FCM Token
    String? token = await _fcm.getToken();
    print("FCM TOKEN: $token");

    if (token != null) {
      await SessionManager.saveFcmToken(token.toString());
      print("FCM TOKEN saved in session: ${SessionManager.getFcmToken().toString()}");
    }
  }
}

// Background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message received: ${message.notification?.title}");
  // You can also call NotificationService.showLocal if needed
}
