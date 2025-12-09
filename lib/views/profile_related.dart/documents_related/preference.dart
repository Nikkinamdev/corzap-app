import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/profile_related.dart/documents_related/driver_registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Preference extends StatefulWidget {
  const Preference({super.key});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  DriverFormController driverFormController = Get.put(DriverFormController());
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
              text: "Driver Registration",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: w * .03),
                child: AppFonts.textPoppins(
                  context,
                  "Tell us your vehicle preference",
                  w * 0.045,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
              ),
              // decoration: BoxDecoration(
              //   color: AppColors.white,
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.2),
              //       spreadRadius: 2,
              //       blurRadius: 3,
              //     ),
              //   ],
              //   borderRadius: BorderRadius.circular(w * 0.03),
              // ),
              //  ? documents screen same preference----

              //?--------have vehicle-------------
              SizedBox(height: w * .02),
              InkWell(
                onTap: () {
                  CustomNavigator.push(
                    context,
                    DriverRegistration(),
                    transition: TransitionType.slideLeft,
                  );
                },
                child: Container(
                  // width: w * 0.8,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Image.asset(
                          "assets/images/vehicle1.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: w * .03),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * .03),
                        child: AppFonts.textPoppins(
                          context,
                          "I have a vehicle",
                          w * 0.05,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.center,
                          TextOverflow.visible,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * .03),
                        child: AppFonts.textPoppins(
                          context,
                          "Register your vehicle to begin driving. A quick verification will get you on the road.",
                          w * 0.038,
                          FontWeight.w500,
                          AppColors.mediumGray,
                          TextAlign.left,
                          TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: w * .03),

                      SizedBox(height: w * .03),
                    ],
                  ),
                ),
              ),
              //?------need vehicle
              SizedBox(height: w * .02),
              InkWell(
                onTap: () {
                  driverFormController.activeStep.value = 2;
                  CustomNavigator.push(
                    context,
                    DriverRegistration(),
                    transition: TransitionType.slideLeft,
                  );
                },
                child: Container(
                  // width: w * 0.8,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Image.asset(
                          "assets/images/needVehicle.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: w * .03),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * .03),
                        child: AppFonts.textPoppins(
                          context,
                          "I need a vehicle",
                          w * 0.05,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.center,
                          TextOverflow.visible,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * .03),
                        child: AppFonts.textPoppins(
                          context,
                          "Don’t have a vehicle? We’ll help you get one to start driving.",
                          w * 0.038,
                          FontWeight.w500,
                          AppColors.mediumGray,
                          TextAlign.left,
                          TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: w * .03),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
