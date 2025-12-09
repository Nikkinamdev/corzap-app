import 'package:corezap_driver/session/session_manager.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/bottom_Sheets/custom_bottom_sheets.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/auth/login_screen.dart';
import 'package:corezap_driver/views/bottomNavigation/bottomNavMain_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PopUps {
  void cancelRidePopup(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: w * .03),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            // yahan scroll allow kar diya
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: w * .1),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: w * .2,
                //     vertical: w * .05,
                //   ),
                //   child: Image.asset(
                //     "assets/icons/cancelPopup1.png",
                //     width: w * .2,
                //     height: w * .2,
                //   ),
                // ),
                Image.asset(
                  "assets/images/cancelride.png",
                  width: w * .2,
                  height: w * .2,
                ),
                SizedBox(height: w * .02),
                CustomText(
                  text: "Cancel Pickup",
                  textColor: ColorsList.titleTextColor,
                  textFontSize: w * .04,
                  textFontWeight: FontWeight.w400,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * .05),
                  child: CustomText(
                    text: "Are you sure you want to cancel the pickup",
                    textColor: ColorsList.subtitleTextColor,
                    textFontSize: w * .034,
                    textFontWeight: FontWeight.w400,
                    textalign: TextAlign.center, // avoid text overflow
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: w * .06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButtons.outlined(
                        context: context,
                        text: "No",

                        onClicked: () {
                          CustomNavigator.pop(context);
                        },
                        width: w * .42,
                        radius: 30,
                        backgroundColor: AppColors.white,
                        borderColor: AppColors.primaryRed,
                        textColor: AppColors.primaryRed,
                      ),
                      SizedBox(width: w * .03),
                      AppButtons.outlined(
                        context: context,
                        text: "Yes, Cancel",

                        onClicked: () {
                          CustomNavigator.push(
                            context,
                            BottomnavmainScreen(),
                            transition: TransitionType.slideLeft,
                          );
                        },
                        width: w * .42,
                        radius: 30,
                        backgroundColor: AppColors.primaryRed,
                        textColor: AppColors.white,

                        fontSize: w * .045,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: w * .05),
              ],
            ),
          ),
        );
      },
    );
  }
  void logout(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: w * .05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(w * .04),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: w * .08),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * .2,
                  vertical: w * .05,
                ),
                child: CustomImages.images(
                  "assets/images/logout1.png",
                  w * .35,
                  w * .35,
                ),
              ),
              AppFonts.textPoppins(
                context,
                "Logout",
                w * .06,
                FontWeight.w500,
                AppColors.black,
                TextAlign.center,
                TextOverflow.visible,
              ),
              AppFonts.textPoppins(
                context,
                "Are you sure you want to logout?",
                w * .04,
                FontWeight.w400,
                AppColors.mediumGray,
                TextAlign.center,
                TextOverflow.ellipsis,
              ),

              SizedBox(height: w * .05),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * .05,
                  //  vertical: w * .05,
                ),
                child:
                AppButtons.solid(
                  context: context,
                  width: w,
                  //  isLoading: authController.loading.value,
                  text: "Logout",
                  onClicked: () {
                    SessionManager.clearSession();
                    CustomNavigator.removeUntil(context, LoginScreen());
                  },
                )
                    .animate()
                    .fade(duration: 1000.ms, curve: Curves.easeInOut)
                    .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * .05,
                  // vertical: w * .02,
                ),
                child:
                AppButtons.solid(
                  context: context,
                  width: w,
                  //  isLoading: authController.loading.value,
                  text: "Cancel",
                  onClicked: () {
                    CustomNavigator.pop(context);
                  },
                  backgroundColor: AppColors.white,
                  textColor: AppColors.black,
                )
                    .animate()
                    .fade(duration: 1000.ms, curve: Curves.easeInOut)
                    .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
              ),
              SizedBox(height: w * .05),
            ],
          ),
        );
      },
    );
  }

  // coupan add successfully
  void coupanAdd(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: w * .03),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            // yahan scroll allow kar diya
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: w * .1),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: w * .2,
                //     vertical: w * .05,
                //   ),
                //   child: Image.asset(
                //     "assets/icons/cancelPopup1.png",
                //     width: w * .2,
                //     height: w * .2,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: w * .04),
                  child: Image.asset(
                    "assets/images/coupan1.png",
                    width: w,
                    height: w * .6,
                  ),
                ),
                SizedBox(height: w * .02),
                AppFonts.textPoppins(
                  context,
                  "Coupon Applied Successfully",
                  w * 0.046,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.center,
                  TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * .07),
                  child: AppFonts.textPoppins(
                    context,
                    "Your 50% discount has been added. Pay only ₹50 for ₹100 recharge.",
                    w * 0.037,
                    FontWeight.w400,
                    AppColors.mediumGray,
                    TextAlign.center,
                    TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),

                SizedBox(height: w * .1),
              ],
            ),
          ),
        );
      },
    );
  }
}
