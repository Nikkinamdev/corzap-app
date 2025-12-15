import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller_service.dart';
import '../web_map.dart';


class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final MapController controller = Get.put(MapController());
  final MapWebController mapWebController =
  Get.put(MapWebController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => ElevatedButton(
        onPressed: mapWebController.loading.value
            ? null
            : () {
          mapWebController.openDropToCurrentWebMap(
            dropLat: 23.2599, // Bhopal Junction
            dropLng: 77.4126,
          );
        },
        child: mapWebController.loading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Open Map"),
      )),),
      body: Obx(() {
        if (controller.currentLatLng.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: controller.currentLatLng.value!,
            zoom: 15,
          ),
          myLocationEnabled: true,
          polylines: controller.polylines,
          markers: {
            Marker(
              markerId: const MarkerId("current"),
              position: controller.currentLatLng.value!,
              infoWindow: const InfoWindow(title: "Current Location"),
            ),
            Marker(
              markerId: const MarkerId("drop"),
              position: controller.dropLatLng,
              infoWindow: const InfoWindow(title: "Drop Location"),
            ),
          },
          onMapCreated: (mapCtrl) {
            controller.mapController = mapCtrl;
          },
        );
      }),
    );
  }
}
