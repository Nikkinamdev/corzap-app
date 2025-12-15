import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class UILocationController extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  StreamSubscription<Position>? _sub;

  Future<void> start() async {
    await Geolocator.requestPermission();

    _sub?.cancel();
    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((pos) {
      lat.value = pos.latitude;
      lng.value = pos.longitude;
    });
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
