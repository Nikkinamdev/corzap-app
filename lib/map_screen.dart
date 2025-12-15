import 'package:corezap_driver/views/pp.dart';
import 'package:corezap_driver/views/ssss.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with WidgetsBindingObserver {
  final uiCtrl = Get.find<UILocationController>();
  final modeCtrl = Get.find<LocationModeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    uiCtrl.start();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      modeCtrl.toUI();
      uiCtrl.start();
    } else if (state == AppLifecycleState.paused) {
      uiCtrl.stop();
      modeCtrl.toBackground();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    uiCtrl.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Driver Map')),
      body: Obx(() {
        if (uiCtrl.lat.value == 0) {
          return const Center(child: CircularProgressIndicator());
        }

        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(uiCtrl.lat.value, uiCtrl.lng.value),
            zoom: 16,
          ),
          markers: {
            Marker(
              markerId: const MarkerId('me'),
              position: LatLng(uiCtrl.lat.value, uiCtrl.lng.value),
            )
          },
        );
      }),
    );
  }
}
