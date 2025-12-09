import 'package:corezap_driver/controller/other_text_controller.dart';
import 'package:corezap_driver/controller/raise_request_controller.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RaiseRequestDropdown extends StatelessWidget {
  final Function(String) onSelected; // callback
  RaiseRequestDropdown({Key? key, required this.onSelected}) : super(key: key);
  final OtherTextController otherController = Get.put(OtherTextController());

  final RaiseRequestController controller = Get.put(RaiseRequestController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        // 🔹 Header
        InkWell(
          onTap: () => controller.isExpanded.toggle(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(233, 243, 255, 1), Colors.white],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: w * .03,
              vertical: w * .02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppFonts.textPoppins(
                  context,
                  "Raise Request",
                  w * 0.038,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                Obx(
                  () => Icon(
                    controller.isExpanded.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        // 🔹 Expandable Body
        Obx(
          () => AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                ...controller.requestOptions.map((option) {
                  return Column(
                    children: [
                      Obx(
                        () => CheckboxListTile(
                          value: (option["isChecked"] as RxBool).value,
                          onChanged: (value) {
                            (option["isChecked"] as RxBool).value =
                                value ?? false;
                          },
                          title: Row(
                            children: [
                              CustomImages.images(
                                option["iconPath"],
                                w * .05,
                                w * .05,
                              ),
                              SizedBox(width: w * .02),
                              AppFonts.textPoppins(
                                context,
                                option["title"],
                                w * 0.035,
                                FontWeight.w500,
                                AppColors.black,
                                TextAlign.left,
                                TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: w * .015,
                          ),
                          activeColor: AppColors.primaryRed,
                          checkboxShape: CircleBorder(),
                          side: BorderSide(
                            color: AppColors.mediumGray,
                            width: 1,
                          ),
                        ),
                      ),

                      // 🔹 TextField only when "Other" is checked
                      if (option["title"] == "Other")
                        Obx(() {
                          bool showTextField =
                              (option["isChecked"] as RxBool).value;
                          return AnimatedCrossFade(
                            duration: const Duration(milliseconds: 200),
                            crossFadeState: showTextField
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            firstChild: const SizedBox.shrink(),
                            secondChild: AppFormFields.custTextFormOther(
                              context: context,
                              hintText: "Write your request...",
                              keyboardType: TextInputType.text,
                              controller: otherController.otherTextController,

                              onChanged: (val) =>
                                  otherController.otherText.value = val,

                              borderColor: AppColors.lightGray,
                              borderRadius: 8,
                              fontSize: w * .035,
                              hintColor: AppColors.mediumGray,
                              filled: false,
                              maxLines: 4,
                            ),
                          );
                        }),
                    ],
                  );
                }).toList(),

                // Buttons
                SizedBox(height: w * .02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * .02,
                    vertical: w * .02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButtons.solid(
                        context: context,
                        text: "Cancel",
                        backgroundColor: AppColors.lightGray,
                        textColor: AppColors.mediumGray,
                        fontSize: w * .04,
                        height: w * .12,

                        width: w * .38,

                        onClicked: () {
                          controller.resetOptions();
                          otherController.clearText();
                        },
                      ),
                      AppButtons.solid(
                        context: context,
                        text: "Submit",
                        backgroundColor: AppColors.primaryRed,
                        textColor: AppColors.white,
                        fontSize: w * .04,
                        height: w * .12,

                        width: w * .38,
                        onClicked: () {
                          final selected = controller.selectedValues.join(", ");
                          otherController.clearText();
                          onSelected(selected);
                          controller.isExpanded.value = false;
                          // controller.resetOptions();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: controller.isExpanded.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ),
      ],
    );
  }
}
