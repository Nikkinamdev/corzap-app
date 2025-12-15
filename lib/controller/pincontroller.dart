import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PinController extends GetxController {
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(4, (_) => FocusNode());

  RxString otp = "".obs;

  String getOtp() => controllers.map((e) => e.text).join();

  void updateOtp() {
    otp.value = getOtp();
    update();
  }

  void clearOtp() {
    for (var c in controllers) {
      c.clear();
    }
    otp.value = "";
    focusNodes.first.requestFocus();
    update();
  }
}
