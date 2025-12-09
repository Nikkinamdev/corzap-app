import 'package:corezap_driver/apis/auth.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/views/profile_related.dart/documents_related/driver_registration.dart';
import 'package:corezap_driver/views/profile_related.dart/documents_related/preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/controller/otp_controller.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/custom_otps/custom_otp_box.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/views/bottomNavigation/bottomNavMain_screen.dart';

import '../../apis/driver_detail_apis.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  Auth authController = Get.find<Auth>();
  final Controllers contentController = Get.put(Controllers());
  final OtpController otpController = Get.put(OtpController());

  @override
  void initState() {
    // TODO: implement initState
    contentController.maxheightReach.value = false;
    super.initState();
    otpController.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsList.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: w * .12),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                width: w * .08,
                height: w * .08,
                child: Image.asset("assets/images/arrowLeft.png"),
              ),
            ),
            SizedBox(height: w * .02),
            CustomText(
              text: "Verify Phone Number",
              textFontSize: w * .06,
              textColor: ColorsList.titleTextColor,
              textFontWeight: FontWeight.w600,
            ),
            CustomText(
              text:
                  "Please enter the 4 digit code sent to +91 8238658110 through SMS",
              textFontSize: w * .042,
              textColor: ColorsList.subtitleTextColor,
              textFontWeight: FontWeight.w400,
            ),
            SizedBox(height: w * .02),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * .07,
                vertical: w * .05,
              ),
              child: Column(
                children: [
                  //? otp boxes-------------------------------
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * .01),
                    child: CustomOtpBox(),
                  ),
                  SizedBox(height: w * .02),

                  Obx(() {
                    if (otpController.secondsRemaining.value > 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Haven't got the confirmation code yet?",
                            textFontSize: w * .035,
                            textColor: ColorsList.subtitleTextColor,
                            textFontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: w * .01),
                          CustomText(
                            text:
                                "00:${otpController.secondsRemaining.value.toString().padLeft(2, '0')}",
                            textFontSize: w * .035,
                            textColor: ColorsList.subtitleTextColor,
                            textFontWeight: FontWeight.w400,
                          ),
                        ],
                      );
                    } else {
                      return GestureDetector(
                        // timer restart and re-send otp
                        onTap: otpController.resendCode,
                        child: AppFonts.textPoppins(
                          context,
                          "Resend OTP",
                          w * 0.04,
                          FontWeight.w500,
                          AppColors.primaryRed,
                          TextAlign.center,
                          TextOverflow.ellipsis,
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
            Spacer(),

            SizedBox(height: w * .05),
            Obx(() {
              return AppButtons.solid(
                context: context,
                text: "Submit",
                onClicked: () async {
                  authController.loading.value = true; // show loader

                  await authController.verifyOtpApi();

                  authController.loading.value = false; // hide loader

                  if (authController.checkRagister.value == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(authController.otpMessage.value)),
                    );

                    print("idddddddddddd${authController.driverId.value}");

                    CustomNavigator.push(
                      context,
                      const BottomnavmainScreen(),
                      transition: TransitionType.fade,
                    );
                  } else if (authController.checkRagister.value == false) {
                    CustomNavigator.push(context, DriverRegistration());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(authController.otpMessage.value),
                      ),
                    );
                  }
                },
                isLoading: authController.loading.value,
                // 👈 reactive loader
                isFullWidth: true,
                backgroundColor: ColorsList.mainButtonColor,
                textColor: ColorsList.mainButtonTextColor,
                fontSize: w * .045,
                height: w * .140,
                radius: 12.0,
              );
            }),

            SizedBox(height: w * .1),
          ],
        ),
      ),
    );
  }
}
