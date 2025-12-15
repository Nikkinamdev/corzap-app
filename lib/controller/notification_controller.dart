import 'package:get/get.dart';

import '../service/api_service.dart';
import '../service/firebase_service.dart';
import '../service/notification_service.dart';


class NotificationController extends GetxController {
  final ApiService api = ApiService();
  final NotificationService noti = NotificationService();

  @override
  void onInit() {
    super.onInit();
    initialize();
    autoFetch();
  }

  Future<void> initialize() async {
    await noti.init();
    await FirebaseService().initFirebase();
  }

  Future<void> fetchAndNotify() async {
    final data = await api.getMessageFromApi();

    if (data != null) {
      String title = data["title"] ?? "New Notification";
      String body = data["body"] ?? "You have a new message";

      noti.showLocal(title, body);
    }
  }

  void autoFetch() {
    ever(1.obs, (_) async {
      await Future.delayed(Duration(seconds: 30));
      fetchAndNotify();
    });
  }
}
