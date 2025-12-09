import 'dart:async';
import 'package:corezap_driver/apis/auth.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  Auth authController = Get.find<Auth>();
  var secondsRemaining = 59.obs; // countdown value
  Timer? _timer;

  void startTimer() {
    authController.sendOtpApi();
    secondsRemaining.value = 59;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode() {
    // Yaha resend API call ya logic lagana
    authController.sendOtpApi();

    print("Resend OTP clicked!");
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
