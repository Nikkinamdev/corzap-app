import 'package:get/get.dart';

class StepperController extends GetxController {
  RxInt activeStep = 0.obs;

  void reachStep(int index) {
    activeStep.value = index;
  }

  void nextStep() {
    if (activeStep.value < 3) {
      activeStep.value++;
    }
  }

  void resetSteps() {
    activeStep.value = 1;
  }
}

class DriverFormController extends GetxController {
  RxBool documentnav = false.obs;
  RxInt activeStep = 0.obs;
  RxInt selecIndex = 1.obs;

  // NEW: Minimal add – vehicle preference track (no logic change)
  RxBool hasVehicle = false.obs;

  void reachStep(int index) {
    activeStep.value = index;
  }

  void nextStep() {
    if (activeStep.value < 3) {
      activeStep.value++;
    }
  }

  void resetSteps() {
    activeStep.value = 0;
    hasVehicle.value = false; // NEW: Reset
  }

  // NEW: Minimal method – call from onTap
  void setVehiclePreference(bool pref) {
    hasVehicle.value = pref;
  }
}
