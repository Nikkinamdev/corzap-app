import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DriverController extends GetxController {
  IO.Socket? socket;
  Rx<LatLng> driverLocation = LatLng(23.2599, 77.4126).obs; // initial
  Rx<Marker?> driverMarker = Rx<Marker?>(null);

  Timer? _timer;

  /// Initialize Socket
  void initSocket() {
    socket = IO.io(
      'SOCKET_URL', // Replace with your server
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .build(),
    );

    socket!.onConnect((_) => print('Socket connected'));
    socket!.onDisconnect((_) => print('Socket disconnected'));

    // Listen location updates from backend (optional)
    socket!.on('locationUpdated', (data) {
      double lat = data['lat'];
      double lng = data['lng'];
      updateDriverMarker(LatLng(lat, lng));
    });
  }

  /// Update marker reactively
  void updateDriverMarker(LatLng pos) {
    driverLocation.value = pos;
    driverMarker.value = Marker(
      markerId: const MarkerId('driver'),
      position: pos,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
  }

  /// Start sending location every 20 sec
  void startLocationService() {
    _timer = Timer.periodic(const Duration(seconds: 20), (_) async {
      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng latLng = LatLng(pos.latitude, pos.longitude);

      updateDriverMarker(latLng);

      // Emit location to socket
      socket?.emit('locationUpdated', {
        'driverId': '123',
        'lat': pos.latitude,
        'lng': pos.longitude,
      });

      print('Location sent: ${pos.latitude}, ${pos.longitude}');
    });
  }

  void stopLocationService() {
    _timer?.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    initSocket();
    startLocationService();
  }

  @override
  void onClose() {
    stopLocationService();
    socket?.disconnect();
    super.onClose();
  }
}
