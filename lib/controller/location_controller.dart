// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc; // <-- FIXED IMPORT

// class LocationController extends GetxController {
//   Rx<LatLng?> currentPosition = Rx<LatLng?>(null);
//   RxSet<Marker> markers = <Marker>{}.obs;

//   RxString currentAddress = "".obs;

//   Rx<LatLng?> dropPosition = Rx<LatLng?>(null);
//   RxString dropAddress = "".obs;

//   Rx<LatLng?> selectedPosition = Rx<LatLng?>(null);

//   var accuracy = 0.0.obs;
//   // var currentAddress = "".obs;

//   GoogleMapController? mapController;
//   //  final SocketController socketController = Get.find<SocketController>();
//   @override
//   void onInit() {
//     super.onInit();
//     getCurrentLocation();
//   }

//   // 🔥 MAIN LOCATION METHOD
//   Future<void> getCurrentLocation() async {
//     try {
//       currentAddress.value = "Fetching location...";

//       // ⿡ Check if location service ON
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         final loc.Location location = loc.Location();
//         bool enabled = await location.requestService(); // <-- FIXED
//         if (!enabled) {
//           currentAddress.value = "";
//           print("addressssssssssss${currentAddress.value}");
//           Get.snackbar("Error", "Please enable location services");
//           return;
//         }
//       }

//       // ⿢ Check permission
//       LocationPermission permission = await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.deniedForever) {
//         Get.snackbar(
//           "Permission Denied",
//           "Enable location permission from settings",
//         );
//         Geolocator.openAppSettings();
//         return;
//       }

//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         Get.snackbar("Permission", "Location permission not granted");
//         return;
//       }

//       // ⿣ Get current location
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       currentPosition.value = LatLng(position.latitude, position.longitude);

//       // Save accuracy (you can show accuracy circle)
//       accuracy.value = position.accuracy;

//       // ⿤ Move map camera if controller exists
//       if (mapController != null) {
//         mapController!.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(target: currentPosition.value!, zoom: 16),
//           ),
//         );
//       }
//       //  socketController.sendRiderLocation(position.latitude, position.longitude);
//       // ⿥ Convert to address
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;

//         currentAddress.value = [
//           if (p.street?.isNotEmpty ?? false) p.street,
//           if (p.subLocality?.isNotEmpty ?? false) p.subLocality,
//           if (p.locality?.isNotEmpty ?? false) p.locality,
//         ].join(", ");
//       } else {
//         currentAddress.value = "Current Location";
//       }
//     } catch (e) {
//       currentAddress.value = "";
//       Get.snackbar("Error", "Error getting location: $e");
//     }
//   }
//   Future<void> fetchLocation() async {
//     try {
//       isLoading.value = true;

//       bool allowed = await handleLocationPermission();
//       if (!allowed) {
//         isLoading.value = false;
//         return;
//       }

//       // Fetch current coordinates
//       Position pos = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // Convert to English address
//       String address = await getAddressInEnglish(
//         pos.latitude,
//         pos.longitude,
//       );

//       currentAddress.value = address;

//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
// }
// }
// }
//new---
// import 'package:corezap_driver/controller/socket_controller.dart';
// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationController extends GetxController {
//   SocketController socketController = Get.find<SocketController>();
//   RxString currentAddress = "".obs;
//   RxBool isLoading = false.obs;

//   // 🔹 STEP 1: PERMISSION HANDLER
//   Future<bool> handleLocationPermission() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Get.snackbar("Location Error", "Please enable GPS");
//       return false;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Get.snackbar("Permission Denied", "Location permission is required");
//         return false;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       Get.snackbar(
//         "Permission Blocked",
//         "Please enable location permission from settings",
//       );
//       await Geolocator.openAppSettings();
//       return false;
//     }

//     return true;
//   }

//   // 🔹 STEP 2: GET FULL ADDRESS IN ENGLISH
//   Future<String> getAddressInEnglish(double lat, double lng) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       lat,
//       lng,
//       localeIdentifier: "en", // 🔥 Force English address
//     );

//     Placemark place = placemarks[0];

//     return "${place.street}, "
//         "${place.subLocality}, "
//         "${place.locality}, "
//         "${place.administrativeArea}, "
//         "${place.postalCode}, "
//         "${place.country}";
//   }

//   // 🔹 STEP 3: FETCH LOCATION + CONVERT TO ENGLISH ADDRESS
//   Future<void> fetchLocation() async {
//     try {
//       isLoading.value = true;

//       bool allowed = await handleLocationPermission();
//       if (!allowed) {
//         isLoading.value = false;
//         return;
//       }

//       // Fetch current coordinates
//       Position pos = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       // Convert to English address
//       String address = await getAddressInEnglish(pos.latitude, pos.longitude);
//       print("pos.latitude : ${pos.latitude}");
//       print("pos.longitude : ${pos.longitude}");

//       socketController.currentLatitude.value = pos.latitude;
//       print("Updated lat : ${socketController.currentLatitude.value}");

//       socketController.currentLongitude.value = pos.longitude;
//       currentAddress.value = address;
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
// groknew---
import 'package:corezap_driver/apis/driver_detail_apis.dart';
import 'package:corezap_driver/controller/socket_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:location/location.dart' as loc; // ADD THIS

// class LocationController extends GetxController {
//   final SocketController socketController = Get.find<SocketController>();
//   final DashBoardApis dashBoardApis = Get.find<DashBoardApis>();

//   RxDouble latitude = 0.0.obs;
//   RxDouble longitude = 0.0.obs;
//   RxString currentAddress = "".obs;
//   RxBool isLoading = false.obs;

//   StreamSubscription<Position>? _positionStream;

//   @override
//   void onInit() {
//     super.onInit();
//     startLocationStream(); // Start listening as soon as controller loads
//   }

//   void startLocationStream() async {
//     bool hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;

//     const LocationSettings locationSettings = LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10, // Update only every 10 meters (saves battery)
//     );

//     _positionStream =
//         Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//           (Position position) {
//             latitude.value = position.latitude;
//             longitude.value = position.longitude;

//             // Update socket controller
//             socketController.updateDriverLocation(
//               position.latitude,
//               position.longitude,
//             );
//             print("position.latitude : ${position.latitude}");
//             // Optional: Reverse geocode if needed
//             _updateAddress(position.latitude, position.longitude);
//           },
//         );
//   }

//   // Future<bool> _handleLocationPermission() async {
//   //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     // Get.snackbar("Location Off", "Please enable GPS");
//   //     print("Location Off Please enable GPS");
//   //     return false;
//   //   }

//   //   LocationPermission permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) return false;
//   //   }

//   //   if (permission == LocationPermission.deniedForever) {
//   //     //  Get.snackbar("Permission Denied", "Enable location in settings");
//   //     print("Permission Denied Enable location in settings");
//   //     await Geolocator.openAppSettings();
//   //     return false;
//   //   }
//   //   return true;
//   // }

//   void _updateAddress(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         currentAddress.value = "${place.street}, ${place.locality}";
//       }
//     } catch (_) {}
//   }

//   // new

//   Future<bool> _handleLocationPermission() async {
//     // 🔹 CHECK GPS ON/OFF
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       loc.Location location = loc.Location(); // <-- Location package

//       bool enabled = await location.requestService();
//       // 🔥 THIS SHOWS ANDROID POPUP
//       // "Turn On Location • Allow / Cancel"

//       if (!enabled) {
//         print("User refused to enable GPS");
//         return false;
//       }
//     }

//     // 🔹 CHECK PERMISSION
//     LocationPermission permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return false;
//     }

//     if (permission == LocationPermission.deniedForever) {
//       print("Permission permanently denied");
//       await Geolocator.openAppSettings();
//       return false;
//     }

//     return true;
//   }

//   @override
//   void onClose() {
//     _positionStream?.cancel();
//     super.onClose();
//   }
// }
//nnnnnnnnnnnnnnnnnnnnnnnnn
class LocationController extends GetxController {
  final SocketController socketController = Get.find<SocketController>();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString currentAddress = "".obs;

  StreamSubscription<Position>? _stream;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> startLocationStream() async {
    bool allowed = await _handlePermission();
    if (!allowed) return;

    print("📡 Location stream started");

    _stream =
        Geolocator.getPositionStream(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: 10,
              ),
            ) // LocationController.dart
            .listen((pos) {
              latitude.value = pos.latitude;
              longitude.value = pos.longitude;

              socketController.updateDriverLocation(
                pos.latitude,
                pos.longitude,
              );

              // Pehli baar location aayi aur driver online hai → ek baar aur online event bhejo
              if (socketController.isDriverOnline.value) {
                socketController
                    .goOnline(); // Safe hai, duplicate check hai andar
              }
            });
  }

  void stopLocationStream() {
    print("🛑 Location stream stopped");
    _stream?.cancel();
  }

  Future<bool> _handlePermission() async {
    // STEP 1 → Check if device GPS is ON
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // 🔥 AUTO OPEN SYSTEM POPUP
      await Geolocator.openLocationSettings();
      return false;
    }

    // STEP 2 → Check app permissions
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Force open app settings
      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }
}
