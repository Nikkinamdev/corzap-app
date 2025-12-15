import 'package:get/get.dart';

enum LocationOwner { ui, background }

class LocationModeController extends GetxController {
  Rx<LocationOwner> owner = LocationOwner.ui.obs;

  void toUI() => owner.value = LocationOwner.ui;
  void toBackground() => owner.value = LocationOwner.background;
}
