import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin localNoti =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings android =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: android);

    await localNoti.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
          print("Notification tapped with payload: $payload");
          // TODO: Navigate to screen based on payload
        });
  }

  Future<void> showLocal(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_channel', // channelId
      'High Importance Notifications', // channelName
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await localNoti.show(
      0, // notification id
      title,
      body,
      platformDetails,
    );
  }
}
