import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';

Future<void> startBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'driver_channel',
      initialNotificationTitle: 'Driver Online',
      initialNotificationContent: 'Tracking location',
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
    ),
  );

  await service.startService();
}

@pragma('vm:entry-point')
Future<bool> onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();

    service.setForegroundNotificationInfo(
      title: 'Driver Tracking',
      content: 'Location active',
    );
  }

  await Geolocator.requestPermission();

  Timer.periodic(const Duration(seconds: 20), (_) async {
    if (!await FlutterBackgroundService().isRunning()) return;

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print('📍 BG ${pos.latitude}, ${pos.longitude}');
  });

  return true;
}
