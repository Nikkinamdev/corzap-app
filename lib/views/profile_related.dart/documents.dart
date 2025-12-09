import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/controller/vehicle_form_controller.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/profile_related.dart/documents_related/driver_registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  DriverFormController driverFormController = Get.find<DriverFormController>();
  List detailsAbout = ["Vehicle Details", "Personal Details", "Profile Photo"];
  List detailsSubTitle = [
    "Add your vehicle information for verification.",
    "Your personal info helps us verify your account.",
    "Upload a clear photo of yourself for identification.",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    driverFormController.documentnav.value = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    driverFormController.documentnav.value = false;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        titleSpacing: w * .03,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                driverFormController.resetSteps();
                driverFormController.documentnav.value = false;
                driverFormController.selecIndex.value = 1;
                CustomNavigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: w * .07,
                color: ColorsList.iconColor,
              ),
            ),
            SizedBox(width: w * .02),
            CustomText(
              text: "Documents",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: w * .03),
              child: AppFonts.textPoppins(
                context,
                "Select Vehicle Preference",
                w * 0.04,
                FontWeight.w500,
                AppColors.black,
                TextAlign.left,
                TextOverflow.visible,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        driverFormController.resetSteps();
                        driverFormController.selecIndex.value = 1;
                      },
                      child: Obx(
                        () => Container(
                          width: w * .46,
                          height: w * .28,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/vehicle1.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(w * .003),

                              child: driverFormController.selecIndex.value == 1
                                  ? Icon(
                                      Icons.check_circle,
                                      color: AppColors.green,
                                      size: w * .05,
                                    )
                                  : CircleAvatar(
                                      radius: w * .02,
                                      backgroundColor: AppColors.mediumGray,
                                      child: CircleAvatar(
                                        radius: w * .018,
                                        backgroundColor: AppColors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: w * .02),
                    AppFonts.textPoppins(
                      context,
                      "I have a vehicle",
                      w * 0.033,
                      FontWeight.w600,
                      AppColors.black,
                      TextAlign.center,
                      TextOverflow.visible,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: () {
                          driverFormController.activeStep.value = 2;
                          driverFormController.selecIndex.value = 2;
                        },
                        child: Container(
                          width: w * .46,
                          height: w * .28,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/needVehicle.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(w * .003),
                              child: driverFormController.selecIndex.value == 2
                                  ? Icon(
                                      Icons.check_circle,
                                      color: AppColors.green,
                                      size: w * .05,
                                    )
                                  : CircleAvatar(
                                      radius: w * .02,
                                      backgroundColor: AppColors.mediumGray,
                                      child: CircleAvatar(
                                        radius: w * .018,
                                        backgroundColor: AppColors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: w * .02),
                    AppFonts.textPoppins(
                      context,
                      "I need a vehicle",
                      w * 0.033,
                      FontWeight.w600,
                      AppColors.black,
                      TextAlign.center,
                      TextOverflow.visible,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: w * .02),
            Padding(
              padding: EdgeInsets.symmetric(vertical: w * .02),
              child: AppFonts.textPoppins(
                context,
                "Please complete all below process, to setup your account and start earning.",
                w * 0.033,
                FontWeight.w500,
                AppColors.black,
                TextAlign.left,
                TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Obx(
              () => Column(
                children: List.generate(
                  driverFormController.activeStep.value == 2 ? 2 : 3,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: w * .03),
                      child: InkWell(
                        onTap: () {
                          int targetStep;
                          if (driverFormController.activeStep.value == 0) {
                            targetStep = index + 1;
                          } else {
                            targetStep = index + 2;
                          }
                          driverFormController.activeStep.value = targetStep;
                          CustomNavigator.push(
                            context,
                            DriverRegistration(),
                            transition: TransitionType.slideLeft,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryRed.withOpacity(0.1),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryRed.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 3,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(w * 0.03),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: w * .03,
                              vertical: w * .03,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //show vehicle details complete or not
                                // CircleAvatar(
                                //   radius: w * .025,
                                //   backgroundColor: AppColors.black,
                                //   child: CircleAvatar(
                                //     radius: w * .02,
                                //     backgroundColor: AppColors.white,
                                //   ),
                                // ),
                                Icon(
                                  Icons.cancel,
                                  color: AppColors.primaryRed,
                                  size: w * .05,
                                ),

                                SizedBox(width: w * .02),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppFonts.textPoppins(
                                      context,
                                      driverFormController.activeStep.value == 0
                                          ? detailsAbout[index]
                                          : (index + 1 < detailsAbout.length
                                                ? detailsAbout[index + 1]
                                                : detailsAbout.last),
                                      w * 0.036,
                                      FontWeight.w500,
                                      AppColors.black,
                                      TextAlign.left,
                                      TextOverflow.ellipsis,
                                    ),
                                    AppFonts.textPoppins(
                                      context,
                                      driverFormController.activeStep.value == 0
                                          ? detailsSubTitle[index]
                                          : (index + 1 < detailsSubTitle.length
                                                ? detailsSubTitle[index + 1]
                                                : detailsSubTitle.last),
                                      w * 0.024,
                                      FontWeight.w500,
                                      AppColors.mediumGray,
                                      TextAlign.left,
                                      TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.black,
                                    size: w * .035,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
