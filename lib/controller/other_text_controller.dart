// lib/controller/other_text_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherTextController extends GetxController {
  /// Reactive text (for observing text changes)
  RxString otherText = ''.obs;

  /// Persistent TextEditingController
  final TextEditingController otherTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Sync Rx value and text field
    otherTextController.text = otherText.value;

    otherTextController.addListener(() {
      otherText.value = otherTextController.text;
    });
  }

  void clearText() {
    otherText.value = '';
    otherTextController.clear();
  }

  @override
  void onClose() {
    otherTextController.dispose();
    super.onClose();
  }
}
