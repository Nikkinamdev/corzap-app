import 'package:corezap_driver/apis/auth.dart';
import 'package:corezap_driver/controller/login.controller.dart';
import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/form_field.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/auth/enter_otp_screen.dart';
import 'package:corezap_driver/views/bottomNavigation/bottomNavMain_screen.dart';
import 'package:corezap_driver/views/profile_related.dart/documents_related/driver_registration.dart';
import 'package:corezap_driver/views/profile_related.dart/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Auth apiController = Get.put(Auth());
  DriverFormController driverFormController = Get.put(DriverFormController());
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // apiController.otpVerify.value = false;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/login1.png")
                .animate()
                .fade(duration: 800.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),

            //column
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //space 1
                    SizedBox(height: w * 0.04),
                    //text
                    AppFonts.textPoppins(
                          context,
                          "Welcome Back",
                          w * 0.06,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.left,
                          TextOverflow.visible,
                        )
                        .animate()
                        .fade(duration: 900.ms, curve: Curves.easeInOut)
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                        ),

                    //text 2
                    SizedBox(height: w * 0.02),
                    AppFonts.textPoppins(
                          context,
                          "Let’s get stared! Enter your phone number\nto login to your Corezap account.",
                          w * 0.038,
                          FontWeight.w400,
                          AppColors.darkGray.withOpacity(0.6),
                          TextAlign.left,
                          TextOverflow.visible,
                          maxLines: 2,
                        )
                        .animate()
                        .fade(duration: 1000.ms, curve: Curves.easeInOut)
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                        ),

                    //space 2
                    SizedBox(height: w * 0.04),

                    //text 3
                    AppFonts.textPoppins(
                          context,
                          "Phone Number",
                          w * 0.038,
                          FontWeight.w500,
                          AppColors.black.withOpacity(0.8),
                          TextAlign.left,
                          TextOverflow.visible,
                        )
                        .animate()
                        .fade(duration: 1100.ms, curve: Curves.easeInOut)
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                        ),

                    //space 3
                    SizedBox(height: w * 0.02),

                    //text field
                    AppFormFields.custTextFormOther(
                          context: context,
                          hintText: "Enter here",
                          controller: phoneNumberController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone number required";
                            } else if (value.length < 10) {
                              return "Phone number must be at least 10 digits";
                            } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "Only digits allowed";
                            }
                            return null; // ✅ valid input
                          },
                        )
                        .animate()
                        .fade(duration: 1200.ms, curve: Curves.easeInOut)
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                        ),
                  ],
                ),
              ),
            ),

            //row with checkbox and text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .010),
              child:
                  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //checkBox
                          Obx(
                            () => Checkbox(
                              value: loginController.isChecked.value,
                              activeColor: AppColors.primaryRed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (value) {
                                loginController.isChecked.value = value!;
                              },
                            ),
                          ),

                          //text
                          AppFonts.textPoppins(
                            context,
                            "I agree to CoreZap's",
                            w * 0.034,
                            FontWeight.w500,
                            AppColors.black.withOpacity(0.7),
                            TextAlign.left,
                            TextOverflow.visible,
                            maxLines: 1,
                          ),

                          //text
                          InkWell(
                            onTap: () {
                              CustomNavigator.push(
                                context,
                                TermsCondition(),
                                transition: TransitionType.slideTop,
                              );
                            },
                            child: AppFonts.textPoppins(
                              context,
                              " Terms & Conditions",
                              w * 0.034,
                              FontWeight.w500,
                              AppColors.primaryRed,
                              TextAlign.left,
                              TextOverflow.visible,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fade(duration: 1300.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
            ),

            //space
            SizedBox(height: w * 0.07),



            //space
            SizedBox(height: w * 0.09),

            // divider line and center "Or text"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child:
                  Stack(
                        children: [
                          Divider(
                            height: w * 0.05,
                            thickness: 1,
                            color: AppColors.black.withOpacity(0.2),
                          ),
                          //container with some height and with with or text at center and white color
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              color: AppColors.white,
                              width: w * 0.13,
                              height: w * 0.05,
                              child: Center(
                                child: AppFonts.textPoppins(
                                  context,
                                  "Or",
                                  w * 0.034,
                                  FontWeight.w500,
                                  AppColors.darkGray,
                                  TextAlign.center,
                                  TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fade(duration: 1400.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
            ),

            //space
            SizedBox(height: w * 0.09),

            //row with google and facebook
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child:
                  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //google
                          commonWidget(
                            "assets/icons/google.png",
                            "Google",
                            context,
                            () {
                              //google login function
                            },
                          ),

                          //facebook
                          commonWidget(
                            "assets/icons/facebook.png",
                            "Facebook",
                            context,
                            () {
                              //facebook login function
                            },
                          ),
                        ],
                      )
                      .animate()
                      .fade(duration: 1500.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
            ),

            //space
            SizedBox(height: w * 0.09),

            //login button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child:
                  AppButtons.solid(
                        context: context,
                        text: "Login",
                        onClicked: () async {
                          if (_formKey.currentState!.validate()) {
                            if (loginController.isChecked.value == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: CustomText(
                                    text:
                                        "Please accept the terms and condition",
                                    textColor: Colors.white,
                                  ),
                                ),
                              );
                            }else {
                              apiController.phoneNumber.value =
                                  phoneNumberController.text;
                              CustomNavigator.push(
                                context,
                                EnterOtpScreen(),
                                transition: TransitionType.fade,
                              );
                            }
                          } else{}
                        },
                        isFullWidth: true,
                        fontSize: w * 0.045,
                        height: w * 0.140,
                        radius: 12.0,
                        isLoading: false,
                      )
                      .animate()
                      .fade(duration: 1600.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
            ),

            SizedBox(height: w * .1),
          ],
        ),
      ),
    );
  }

  //common widger
  Widget commonWidget(
    String icon,
    String text,
    BuildContext context,
    //on click
    VoidCallback onClicked,
  ) {
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      onTap: onClicked,
      child: Container(
        height: w * 0.13,
        width: w * 0.45,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black.withOpacity(0.1), width: 1),
          borderRadius: BorderRadius.circular(w * 0.03),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: w * 0.05, width: w * 0.05),
            SizedBox(width: w * 0.03),
            AppFonts.textPoppins(
              context,
              text,
              w * 0.036,
              FontWeight.w600,
              AppColors.black.withOpacity(0.7),
              TextAlign.left,
              TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}
