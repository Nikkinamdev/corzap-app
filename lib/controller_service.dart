import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

class MapController extends GetxController {
  GoogleMapController? mapController;

  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  RxSet<Polyline> polylines = <Polyline>{}.obs;

  // 🔴 STATIC DROP LOCATION (Bhopal Junction)
  final LatLng dropLatLng = const LatLng(23.2599, 77.4126);

  StreamSubscription<Position>? positionStream;

  @override
  void onInit() {
    super.onInit();
    _initLocation();
  }

  Future<void> _initLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    startLiveLocation();
  }

  void startLiveLocation() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      currentLatLng.value =
          LatLng(position.latitude, position.longitude);

      fetchPolyline();
    });
  }

  /// 🔹 GOOGLE DIRECTION API
  Future<void> fetchPolyline() async {
    if (currentLatLng.value == null) return;

    final url =
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${currentLatLng.value!.latitude},${currentLatLng.value!.longitude}'
        '&destination=${dropLatLng.latitude},${dropLatLng.longitude}'
        '&mode=driving'
        '&key=AIzaSyCtM1jo8qzhEn2XZ8SVCoboULcondCjZio';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['routes'].isEmpty) return;

    String encoded =
    data['routes'][0]['overview_polyline']['points'];

    List<LatLng> points = decodePolyline(encoded);

    polylines.clear();
    polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: points,
        color: const Color(0xff1976D2),
        width: 5,
      ),
    );

    updateCamera(points);
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return poly;
  }

  void updateCamera(List<LatLng> points) {
    if (mapController == null) return;

    LatLngBounds bounds = LatLngBounds(
      southwest: points.reduce((a, b) =>
          LatLng(
            a.latitude < b.latitude ? a.latitude : b.latitude,
            a.longitude < b.longitude ? a.longitude : b.longitude,
          )),
      northeast: points.reduce((a, b) =>
          LatLng(
            a.latitude > b.latitude ? a.latitude : b.latitude,
            a.longitude > b.longitude ? a.longitude : b.longitude,
          )),
    );

    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }

  @override
  void onClose() {
    positionStream?.cancel();
    super.onClose();
  }
}
