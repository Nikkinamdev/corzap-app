import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/popups/pop_ups.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class CustomBottomSheets {
  void cancelRide(BuildContext context) {
    List iconList = [
      "assets/icons/cancel1.png",
      "assets/icons/cancel2.png",
      "assets/icons/clockIcon.png",
      "assets/icons/cancel4.png",
      "assets/icons/cancel5.png",
      "assets/icons/cancel6.png",
    ];
    List cancelReasonList = [
      "Too many rides",
      "Wrong pickup location",
      "Waiting too long at pickup",
      "Bad weather / can’t travel now",
      "Traffic jam near pickup point",
      "Other",
    ];
    Controllers cancelRideController = Get.find<Controllers>();

    // Controllers cancelRideController = Get.find<Controllers>();

    double w = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Stack(
          children: [
            // Main BottomSheet Content
            Container(
              margin: EdgeInsets.only(
                top: w * 0.15,
              ), // leave space for close icon
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(w * 0.04),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: w * 0.05,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Why Do You Want To Cancel?",
                    textColor: ColorsList.titleTextColor,
                    textFontSize: w * .042,
                    textFontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: w * .02),
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: w * .01),
                          child: GestureDetector(
                            onTap: () {
                              cancelRideController.cancelRideReasonIndex.value =
                                  index;
                            },
                            child: Container(
                              height: w * .12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: ColorsList.dividerDefaultColor,
                                ),
                                color:
                                    cancelRideController
                                            .cancelRideReasonIndex
                                            .value ==
                                        index
                                    ? ColorsList.mainAppColor
                                    : ColorsList.scaffoldColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * .02,
                                  //   vertical: w * .02,
                                ),
                                child: Row(
                                  children: [
                                    CustomImages.images(
                                      iconList[index],
                                      w * .045,
                                      w * .045,
                                      color:
                                          cancelRideController
                                                  .cancelRideReasonIndex
                                                  .value ==
                                              index
                                          ? ColorsList.mainButtonTextColor
                                          : null,
                                    ),
                                    SizedBox(width: w * .015),
                                    CustomText(
                                      text: cancelReasonList[index],
                                      textColor:
                                          cancelRideController
                                                  .cancelRideReasonIndex
                                                  .value ==
                                              index
                                          ? ColorsList.mainButtonTextColor
                                          : ColorsList.titleTextColor,
                                      textFontSize: w * .04,
                                      textFontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: w * .03),
                  Obx(
                    () => AppButtons.outlined(
                      context: context,
                      text: "Cancel Ride",
                      onClicked: () {
                        PopUps().cancelRidePopup(context);
                      },
                      isFullWidth: true,
                      backgroundColor:
                          cancelRideController.cancelRideReasonIndex.value >= 0
                          ? ColorsList.mainButtonColor
                          : ColorsList.scaffoldColor,
                      textColor:
                          cancelRideController.cancelRideReasonIndex.value >= 0
                          ? ColorsList.mainButtonTextColor
                          : ColorsList.mainAppColor,
                      fontSize: w * .042,
                      height: w * .12,
                      radius: 30,
                    ),
                  ),
                  //       Obx(
                  //         () => Buttons(
                  //           buttonHeight: w * .1,
                  //           borderColor: ColorsList.mainAppColor,
                  //           buttonColor:
                  //               cancelRideController.cancelRideReasonIndex.value >= 0
                  //               ? ColorsList.mainButtonColor
                  //               : ColorsList.scaffoldColor,
                  //           borderRadius: w * .1,
                  //           // onTap: () {
                  //           //   cancelRideController.cancelRideReasonIndex.value >= 0
                  //           //       ? CustomNavigation.push(context, RideCompleted())
                  //           //       : null;
                  //           // },
                  //           buttonText: CustomText(
                  //             text: "Cancel Ride",
                  //             textColor:
                  //                 cancelRideController.cancelRideReasonIndex.value >=
                  //                     0
                  //                 ? ColorsList.mainButtonTextColor
                  //                 : ColorsList.mainAppColor,
                  //             textFontSize: w * .042,
                  //             textFontWeight: FontWeight.w400,
                  //             // maxLines: 1,
                  //             // overflow: TextOverflow.ellipsis,
                  //           ),
                  //         ),
                  //       ),
                ],
              ),
            ),
            //==============

            // Close Icon on top-right
            Positioned(
              right: 05,
              // bottom: 30,
              top: 25,
              child: GestureDetector(
                onTap: () {
                  //  clickButtonController.selectButtonIndex.value = 0;
                  CustomNavigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  padding: EdgeInsets.all(w * .015),
                  child: Icon(Icons.close, size: w * .04),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
