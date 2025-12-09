import 'package:get/get.dart';

class VehicleFormController extends GetxController {
  var currentStep = 0.obs;

  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
    }
  }

  void jumpToStep(int step) {
    currentStep.value = step;
  }
}
