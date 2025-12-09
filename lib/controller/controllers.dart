import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Controllers extends GetxController {
  RxBool addBankAccoundButtonController = false.obs;
  RxBool driverStatus = false.obs;
  var currentTabIndex = 0.obs;
  RxInt cancelRideReasonIndex = (-1).obs;
  RxInt arrivingSteps = 0.obs;
  var selectedCabIndex = (-1).obs;
  var selectedIndexEarning = (-1).obs;
  RxInt selectedPaymentIndex = (-1).obs;
  RxBool checkBox = false.obs;

  // RxBool walletCheck = false.obs;
  // RxBool phonePayCheck = false.obs;
  // RxBool googlePayCheck = false.obs;
  // RxBool paytmCheck = false.obs;
  // RxBool amazonpayCheck = false.obs;
  // RxBool cashCheck = false.obs;
  RxBool selectPaymentOnQr = false.obs;
  RxBool selectPaymentOnCash = false.obs;

  RxInt selectButtonIndex = 0.obs;
  RxInt selectRentalHour = 1.obs;
  RxInt cabIndex = 0.obs;
  RxBool accepRide = false.obs;

  RxInt rideExperiencesIndex = (-1).obs;

  RxBool paymentCashCheck = false.obs;
  RxBool paymentOtherCheck = false.obs;
  RxBool maxheightReach = false.obs;
  //? rating 1 to 5------------------
  var selectedStars = 0.obs;

  void updateStars(int index) {
    selectedStars.value = index + 1;
  }

  //?--------------------------
  void checkBoxUpdate(value) {
    checkBox.value = value;
  }
}

class WalletButtonController extends GetxController {
  var selectedIndex = (-1).obs;

  void selectButton(int index) {
    selectedIndex.value = index + 1;
  }

  void resetSelection() {
    selectedIndex.value = 0;
  }
}

class ButtonController extends GetxController {
  var selectedIndex = (0).obs;
}

// class ShopHomeController extends Controllers {
//   var mapController = Completer<GoogleMapController>();
//   final CameraPosition kGooglePlex = const CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
// }
