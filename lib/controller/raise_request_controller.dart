import 'package:get/get.dart';
import 'other_text_controller.dart';

class RaiseRequestController extends GetxController {
  // expansion state
  var isExpanded = false.obs;

  // options list
  var requestOptions = <Map<String, dynamic>>[
    {
      "title": "Maintenance",
      "iconPath": "assets/icons/maintenance.png",
      "isChecked": false.obs,
    },
    {
      "title": "Low Battery",
      "iconPath": "assets/icons/lowbattery.png",
      "isChecked": false.obs,
    },
    {
      "title": "Fuel Needed",
      "iconPath": "assets/icons/fuleneed.png",
      "isChecked": false.obs,
    },
    {
      "title": "Other",
      "iconPath": "assets/icons/others2.png",
      "isChecked": false.obs,
    },
  ].obs;

  var otherText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Reset options automatically when dropdown collapses
    ever(isExpanded, (expanded) {
      if (expanded == false) {
        resetOptions();
        // Clear the text in OtherTextController as well
        Get.find<OtherTextController>().clearText();
      }
    });
  }

  void resetOptions() {
    for (var option in requestOptions) {
      (option["isChecked"] as RxBool).value = false;
    }
    otherText.value = '';
  }

  List<String> get selectedValues {
    final selected = requestOptions
        .where((opt) => (opt["isChecked"] as RxBool).value)
        .map((opt) => opt["title"] as String)
        .toList();

    // include "Other" text if entered
    if (selected.contains("Other") && otherText.value.isNotEmpty) {
      selected.remove("Other");
      selected.add("Other: ${otherText.value}");
    }
    return selected;
  }
}
