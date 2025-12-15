import 'dart:async';

import 'package:corezap_driver/apis/driver_detail_apis.dart';
import 'package:corezap_driver/controller/ride_data_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../session/session_manager.dart';

// class SocketController extends GetxController {
//   late IO.Socket socket;

//   RxMap<String, Marker> driverMarkers = <String, Marker>{}.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     connectSocket();
//   }

//   void connectSocket() {
//     print("tokennnnnnnnnnnn${SessionManager.getToken()}");
//     socket = IO.io(
//       "https://corezap.smarttechbros.com/",
//       IO.OptionBuilder()
//           .setTransports(['websocket', 'polling'])
//           .setAuth({"token": SessionManager.getToken()})
//           .enableForceNew()
//           .enableReconnection()
//           .build(),
//     );

//     socket.onConnect((_) {
//       print("🟢 SOCKET CONNECTED");
//     });

//     socket.onDisconnect((_) {
//       print("⚠ SOCKET DISCONNECTED");
//     });

//     socket.onConnectError((err) {
//       print("❌ CONNECT ERROR: $err");
//     });
//     // ⬇️ ADD EVENT LISTENER FOR NEW RIDE

// }
//   // Receive nearby drivers from server
// }
// new--
// class SocketController extends GetxController {
//   DashBoardApis deshBoarrdApiController = Get.find<DashBoardApis>();
//   late IO.Socket socket;
//   RxDouble currentLatitude = 0.0.obs;
//   RxDouble currentLongitude = 0.0.obs;
//   RxMap<String, Marker> driverMarkers = <String, Marker>{}.obs;

//   // store new ride event
//   Rxn<Map<String, dynamic>> newRideData = Rxn<Map<String, dynamic>>();

//   @override
//   void onInit() {
//     super.onInit();
//     connectSocket();
//   }

//   void connectSocket() {
//     print("tokennnnnnnnnnnn${SessionManager.getToken()}");
//     socket = IO.io(
//       "https://corezap.smarttechbros.com/",
//       IO.OptionBuilder()
//           .setTransports(['websocket', 'polling'])
//           .setAuth({"token": SessionManager.getToken()})
//           .enableForceNew()
//           .enableReconnection()
//           .build(),
//     );
//     socket.onConnect((_) {
//       print("🟢 SOCKET CONNECTED");
//       print("current latitude :${currentLatitude.value}");
//       print("current longitute :$currentLongitude");

//       // ✅ Emit user:online as soon as socket connects
//       Map<String, dynamic> onlineData = {
//         "latitude": currentLatitude.value, // 17.385044,
//         "longitude": currentLongitude.value, //  78.486671,
//         "vehicleType": deshBoarrdApiController.vehicleId.value,
//         "vehicleImage": null, // Optional
//       };

//       socket.emit('user:online', onlineData);
//       print(" user:online event emitted: $onlineData");
//     });

//     socket.onDisconnect((_) {
//       print("⚠ SOCKET DISCONNECTED");
//     });

//     socket.onConnectError((err) {
//       print("❌ CONNECT ERROR: $err");
//     });

//     // 🔥 Listen for new ride event and store it
//     socket.on('ride:newRide', (data) {
//       print("🚖 NEW RIDE RECEIVED: $data");

//       newRideData.value = Map<String, dynamic>.from(data);
//     });
//   }
// }
// grok new--
// class SocketController extends GetxController {
//   late IO.Socket socket;
//   final DashBoardApis dashBoardApis = Get.find<DashBoardApis>();

//   RxDouble currentLatitude = 0.0.obs;
//   RxDouble currentLongitude = 0.0.obs;
//   RxBool isDriverOnline = false.obs;

//   Rxn<Map<String, dynamic>> newRideData = Rxn<Map<String, dynamic>>();

//   Timer? _locationTimer;

//   @override
//   void onInit() {
//     super.onInit();
//     connectSocket();
//   }

//   void connectSocket() {
//     socket = IO.io(
//       "https://corezap.smarttechbros.com",
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .setAuth({"token": SessionManager.getToken()})
//           .enableAutoConnect()
//           .enableReconnection()
//           .build(),
//     );

//     socket.onConnect((_) {
//       print("SOCKET CONNECTED");
//       // Don't send location yet — wait until driver goes online
//     });
//     socket.on('ride:newRide', (data) {
//       print("NEW RIDE: $data");
//       newRideData.value = Map<String, dynamic>.from(data);
//     });

//     socket.onDisconnect((_) {
//       print("SOCKET DISCONNECTED");
//       isDriverOnline.value = false;
//       _stopSendingLocation();
//     });
//   }

//   // Called from LocationController every time location changes
//   void updateDriverLocation(double lat, double lng) {
//     currentLatitude.value = lat;
//     currentLongitude.value = lng;
//     print("latitudeeeeee${currentLatitude.value}");
//     print("latlongggg${currentLongitude.value}");
//     // Only send if driver is online
//     if (isDriverOnline.value && socket.connected) {
//       _sendLocationToServer(lat, lng);
//     }
//   }

//   // Call this when driver toggles "Online"
//   // void goOnline() {
//   //   if (!socket.connected) return;

//   //   isDriverOnline.value = true;

//   //   Map<String, dynamic> data = {
//   //     "latitude": currentLatitude.value,
//   //     "longitude": currentLongitude.value,
//   //     "vehicleType": dashBoardApis.vehicleId.value,
//   //   };

//   //   socket.emit('user:online', data);
//   //   print("Driver went ONLINE + location sent $data");

//   //   // Start sending location every 10 seconds
//   //   _startSendingLocation();
//   // }
//   //new
//   void goOnline() {
//     if (!socket.connected) {
//       print("❌ Socket not connected. Cannot set online.");
//       return;
//     }

//     // PREVENT DOUBLE CALL
//     if (isDriverOnline.value == true) {
//       print("⚠️ Driver already online. Ignoring duplicate goOnline() call.");
//       return;
//     }

//     isDriverOnline.value = true;

//     Map<String, dynamic> data = {
//       "latitude": currentLatitude.value,
//       "longitude": currentLongitude.value,
//       "vehicleType": dashBoardApis.vehicleId.value,
//     };

//     socket.emit('user:online', data);
//     print("🟢 Driver went ONLINE + location sent $data");

//     _startSendingLocation();
//   }

//   // void goOffline() {
//   //   isDriverOnline.value = false;
//   //   socket.emit('user:offline', {});
//   //   print("Driver went OFFLINE");
//   //   _stopSendingLocation();
//   // }
//   // new
//   void goOffline() {
//     if (!isDriverOnline.value) {
//       print("⚠️ Driver already offline.");
//       return;
//     }

//     isDriverOnline.value = false;
//     socket.emit('user:offline', {});
//     print("🔴 Driver went OFFLINE");
//     _stopSendingLocation();
//   }

//   void _startSendingLocation() {
//     _locationTimer?.cancel();
//     _locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
//       if (isDriverOnline.value && socket.connected) {
//         _sendLocationToServer(currentLatitude.value, currentLongitude.value);
//       }
//     });
//   }

//   void _stopSendingLocation() {
//     _locationTimer?.cancel();
//   }

//   void _sendLocationToServer(double lat, double lng) {
//     print("server latitudeee${lat}");
//     socket.emit('driver:location', {"latitude": lat, "longitude": lng});
//     print("Location sent: $lat, $lng");
//   }

//   @override
//   void onClose() {
//     _locationTimer?.cancel();
//     socket.dispose();
//     super.onClose();
//   }
// }
// nnnnnnnnnnnnnnnnnnnn
class SocketController extends GetxController {
  late IO.Socket socket;
  final DashBoardApis dashBoardApis = Get.find<DashBoardApis>();

  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;
  RxBool isDriverOnline = false.obs;

  Rxn<Map<String, dynamic>> newRideData = Rxn<Map<String, dynamic>>();
  Timer? _locationTimer;

  @override
  void onInit() {
    super.onInit();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io(
      "http://api.corezap.framekarts.com:1505",
      IO.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .setAuth({"token": SessionManager.getToken()})
          .enableReconnection()
          .setReconnectionAttempts(9999)
          .setReconnectionDelay(3000)
          .build(),
    );

    // socket.onConnect((_) {
    //   print("🟢 SOCKET CONNECTED");
    // });

    socket.onConnect((_) {
      print("🟢 SOCKET CONNECTED");

      // Agar driver already ONLINE status tha backend / local state me
      if (isDriverOnline.value) {
        goOnline();
      }
    });

    // DEBUG → Find which event server sends for ONLINE response
    socket.onAny((event, data) {
      print("📩 SERVER EVENT → $event  DATA → $data");
    });

    //When server sends New Ride
    // socket.on('ride:newRide', (data) {
    //   print("🚗 NEW RIDE: $data");
    //   newRideData.value = Map<String, dynamic>.from(data);
    //   print(newRideData.value);
    // });
    socket.on("ride:newRide", (data) {
      print("ride:newRide socket on $data");
      final rideCtrl = Get.find<RideDataController>();
      rideCtrl.setRideData(Map<String, dynamic>.from(data));
    });

    socket.on('user:online', (data) {
      print("📩 SERVER ONLINE RESPONSE → $data");
    });

    socket.onDisconnect((_) {
      print("🔴 SOCKET DISCONNECTED");
      isDriverOnline.value = false;
      _stopSendingLocation();
    });
  }

  void updateDriverLocation(double lat, double lng) async {
    print("update location");
    currentLatitude.value = lat;
    currentLongitude.value = lng;
print("enevvvvvvvlong${currentLongitude.value }");
    print("evvvvvvvvlat${currentLatitude.value }");
    if (isDriverOnline.value && socket.connected) {
      _sendLocationToServer(lat, lng);
    }
  }

  // -------------------- ONLINE -----------------------
  // SocketController.dart mein goOnline() ko aise change karo:

  void goOnline() {
    if (!socket.connected) {
      print("Socket not connected");
      return;
    }

    if (isDriverOnline.value) {
      print("Already online");
      return;
    }

    // YE LINE HATA DO YA COMMENT KAR DO
    // if (currentLatitude.value == 0.0 && currentLongitude.value == 0.0) return;

    isDriverOnline.value = true;

    Map<String, dynamic> data = {
      "latitude": currentLatitude.value == 0.0
          ? 0.0
          : currentLatitude.value,
      "longitude": currentLongitude.value == 0.0
          ? 0.0
          : currentLongitude.value,
      "vehicleType": dashBoardApis.vehicleId.value,
    };

    socket.emit('user:online', data);
    print("Driver went ONLINE (even if location 0.0");

    _startSendingLocation(); // Yeh har 10 sec mein latest location bhejega
  }

  // -------------------- OFFLINE -----------------------
  void goOffline() {
    if (!isDriverOnline.value) {
      print("⚠ Driver already offline.");
      return;
    }

    isDriverOnline.value = false;

    socket.emit('user:offline', {});
    print("🔴 OFFLINE event sent");

    _stopSendingLocation();
  }

  void _startSendingLocation() {
    _locationTimer?.cancel();

    _locationTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (isDriverOnline.value && socket.connected) {
        _sendLocationToServer(currentLatitude.value, currentLongitude.value);
      }
    });
  }

  void _stopSendingLocation() {
    _locationTimer?.cancel();
  }

  void _sendLocationToServer(double lat, double lng) {
    print("yyyyyyyyyyy");
    socket.emit('driver:location:update', {"latitude": lat, "longitude": lng});

    print("📍 LOCATION SENT → $lat , $lng");
  }

  @override
  void onClose() {
    _locationTimer?.cancel();
    socket.dispose();
    super.onClose();
  }
}
