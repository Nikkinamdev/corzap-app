import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWebController extends GetxController {
  RxBool loading = false.obs;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location service disabled';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permission denied forever';
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> openDropToCurrentWebMap({
    required double dropLat,
    required double dropLng,
  }) async {
    try {
      loading.value = true;

      final position = await _getCurrentLocation();

      final url =
          'https://www.google.com/maps/dir/?api=1'
          '&origin=${position.latitude},${position.longitude}'
          '&destination=$dropLat,$dropLng'
          '&travelmode=driving';

      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }
}
