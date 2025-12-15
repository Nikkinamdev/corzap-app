import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PolylineController extends GetxController {
  GoogleMapController? mapController;

  // MARKERS & POLYLINES
  var markers = <Marker>{}.obs;
  var polylines = <Polyline>{}.obs;

  // Bhopal Junction
  final LatLng dropLatLng = const LatLng(23.2599, 77.4126);

  var currentLatLng = LatLng(0,0).obs; // fallback before location

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await location.requestService();
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (serviceEnabled && permissionGranted == PermissionStatus.granted) {
      LocationData loc = await location.getLocation();
      currentLatLng.value = LatLng(loc.latitude!, loc.longitude!);

      // Add markers
      addMarkers();

      // Draw polyline
      drawPolyline(currentLatLng.value, dropLatLng);

      // Move camera
      mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              currentLatLng.value.latitude < dropLatLng.latitude
                  ? currentLatLng.value.latitude
                  : dropLatLng.latitude,
              currentLatLng.value.longitude < dropLatLng.longitude
                  ? currentLatLng.value.longitude
                  : dropLatLng.longitude,
            ),
            northeast: LatLng(
              currentLatLng.value.latitude > dropLatLng.latitude
                  ? currentLatLng.value.latitude
                  : dropLatLng.latitude,
              currentLatLng.value.longitude > dropLatLng.longitude
                  ? currentLatLng.value.longitude
                  : dropLatLng.longitude,
            ),
          ),
          100,
        ),
      );
    }
  }

  void addMarkers() {
    markers.addAll({
      Marker(
        markerId: const MarkerId("pickup"),
        position: currentLatLng.value,
        infoWindow: const InfoWindow(title: "Pickup"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
      Marker(
        markerId: const MarkerId("drop"),
        position: dropLatLng,
        infoWindow: const InfoWindow(title: "Bhopal Junction"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    });
  }

  Future<void> drawPolyline(LatLng start, LatLng end) async {
    const String apiKey = "AIzaSyCtM1jo8qzhEn2XZ8SVCoboULcondCjZio";
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return;

    final data = jsonDecode(response.body);
    if (data["routes"] == null || data["routes"].isEmpty) return;

    final String encoded = data["routes"][0]["overview_polyline"]["points"];
    final List<LatLng> coords = decodePolyline(encoded);

    polylines.add(
      Polyline(
        polylineId: const PolylineId("route"),
        points: coords,
        width: 4,
        color: Colors.blueAccent,
      ),
    );
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
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return poly;
  }
}
