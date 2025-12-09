import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: w * 1.400,
        width: w,
        child: Stack(
          children: [
            //image 1
            Image.asset(
              'assets/images/onboard1.png',
              width: w,
              height: w * 1.400,
              fit: BoxFit.cover,
            ),

            // text
            Positioned(
              top: w * 0.300,
              left: w - w * 0.8,
              child:
                  AppFonts.textRubik(
                        context,
                        "Your Road to Earnings Starts Here",
                        w * 0.045,
                        FontWeight.w500,
                        AppColors.mediumGray.withOpacity(0.6),
                        TextAlign.center,
                        TextOverflow.visible,
                        maxLines: 2,
                      )
                      .animate()
                      .slide(
                        begin: const Offset(-1, 0),
                        end: Offset.zero,
                        duration: 800.ms,
                        curve: Curves.easeInOut,
                      )
                      .fade(duration: 600.ms),
            ),

            // text
            Positioned(
              top: w * 0.37,
              left: w - w * 0.59,
              child:
                  AppFonts.textRubik(
                        context,
                        "Freedom, income, your way",
                        w * 0.040,
                        FontWeight.w500,
                        AppColors.black,
                        TextAlign.center,
                        TextOverflow.visible,
                        maxLines: 2,
                      )
                      .animate()
                      .slide(
                        begin: const Offset(-1, 0),
                        end: Offset.zero,
                        duration: 800.ms,
                        curve: Curves.easeInOut,
                      )
                      .fade(duration: 600.ms),
            ),

            //image 2
            Positioned(
              top: w * 0.690,
              left: w * 0.070,
              child:
                  Image.asset(
                        'assets/images/onboard2.png',
                        width: w * 0.90,
                        height: w * 0.90,
                        fit: BoxFit.contain,
                      )
                      .animate()
                      .slide(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                        duration: 800.ms,
                        curve: Curves.easeInOut,
                      )
                      .fade(duration: 600.ms),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: w * .820,
          width: w,
          color: AppColors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //column with texts
              Column(
                children: [
                  SizedBox(
                    width: w * 0.80,
                    child:
                        AppFonts.textRubik(
                              context,
                              "Every journey made safer, every mile made better.",
                              w * 0.080,
                              FontWeight.w500,
                              AppColors.black,
                              TextAlign.center,
                              TextOverflow.visible,
                              maxLines: 3,
                            )
                            .animate()
                            .fade(duration: 800.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                  ),
                  AppFonts.textRubik(
                        context,
                        "We take the wheel for your Comfort.",
                        w * 0.036,
                        FontWeight.w400,
                        AppColors.mediumGray.withOpacity(0.50),
                        TextAlign.center,
                        TextOverflow.visible,
                        maxLines: 3,
                      )
                      .animate()
                      .fade(duration: 900.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
                ],
              ),
              //button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.040),
                child:
                    AppButtons.solid(
                          context: context,
                          text: "Get Started",
                          isFullWidth: true,
                          suffixIcon: Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                            size: w * 0.060,
                          ),
                          onClicked: () {
                            CustomNavigator.push(
                              context,
                              LoginScreen(),
                              transition: TransitionType.slideLeft,
                            );
                          },
                          backgroundColor: AppColors.primaryRed,
                          textColor: AppColors.white,
                          fontSize: w * 0.045,
                          height: w * 0.140,
                          radius: 12.0,
                          isLoading: false,
                          padding: EdgeInsets.symmetric(horizontal: w * 0.030),
                        )
                        .animate()
                        .fade(duration: 1000.ms, curve: Curves.easeInOut)
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
