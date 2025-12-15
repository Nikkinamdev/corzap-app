import 'package:get/get.dart';

class RideDataController extends GetxController {
  // Raw ride data
  RxMap<String, dynamic> rideData = <String, dynamic>{}.obs;

  // Separate rideId (easy access)
  RxString rideId = ''.obs;

  // Store ride data from socket
  void setRideData(Map<String, dynamic> data) {
    rideData.assignAll(data);

    if (data.containsKey('rideId')) {
      rideId.value = data['rideId'].toString();
      print("✅ Ride ID saved in memory → ${rideId.value}");
    }

    print("🚗 FULL RIDE DATA → $rideData");
  }

  // Clear ride
  void clearRideData() {
    rideData.clear();
    rideId.value = '';
    print("🧹 Ride data cleared");
  }
}
