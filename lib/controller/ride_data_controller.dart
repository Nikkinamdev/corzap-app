import 'package:get/get.dart';

class RideDataController extends GetxController {
  // Raw ride data map
  RxMap<String, dynamic> rideData = <String, dynamic>{}.obs;

  // Method to store ride data from socket
  void setRideData(Map<String, dynamic> data) {
    rideData.value = data;
    print("rrrrrrrrrrideeeeeeeeeee$rideData");
  }

  // Clear when needed
  void clearRideData() {
    rideData.clear();
  }
}
