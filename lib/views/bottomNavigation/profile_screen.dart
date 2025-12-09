import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/popups/pop_ups.dart';
import 'package:corezap_driver/views/profile_related.dart/documents.dart';
import 'package:corezap_driver/views/profile_related.dart/edit_profile.dart';
import 'package:corezap_driver/views/profile_related.dart/help_related/help_screen.dart';
import 'package:corezap_driver/views/profile_related.dart/notification.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_screen.dart';
import 'package:corezap_driver/views/profile_related.dart/privacy_policy.dart';
import 'package:corezap_driver/views/profile_related.dart/rating.dart';
import 'package:corezap_driver/views/profile_related.dart/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../apis/driver_detail_apis.dart';
import '../../apis/help_apis.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DriverFormController driverFormController = Get.put(DriverFormController());
  String imagePath = "";
  List firstImagePathList = [
    "assets/icons/paymentProfileIcon.png",
    "assets/icons/ratingIcon.png",
    "assets/icons/documentsIcon.png",
    "assets/icons/notificatiosProfileIcon.png",
  ];
  List firstScreens = [PaymentScreen(), Rating(), Documents(), Notifications()];
  //? help-screens
  List secondScreens = [HelpScreen(), TermsCondition(), PrivacyPolicy()];
  List secondImagePathList = [
    "assets/icons/helpProfileIcon.png",
    "assets/icons/termsProfileIcon.png",
    "assets/icons/privactProfileIcon.png",
  ];
  List firstTitleList = ["Payment", "Rating", "Documents", "Notifications"];
  List secondTitleList = ["Help", "Terms & Conditions", "Privacy Policy"];
  DashBoardApis driverprofileController = Get.find<DashBoardApis>();
  HelpApisController privacyPolicy = Get.put(HelpApisController());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsList.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        leading: SizedBox(),
        title:
            AppFonts.textRubik(
                  context,
                  "Profile",
                  w * 0.055,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.center,
                  TextOverflow.ellipsis,
                  maxLines: 1,
                )
                .animate()
                .fade(duration: 800.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .02),
          child: Column(
            children: [
              SizedBox(height: w * .02),
              Obx(()=>
                 Card(
                  elevation: 1,
                  color: ColorsList.scaffoldColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * .04,
                          vertical: w * .02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: w * 0.07,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage:
                              driverprofileController.driverImage.value.isNotEmpty
                                  ? NetworkImage(driverprofileController.driverImage.value)
                                  : null,
                              child: driverprofileController.driverImage.value.isEmpty
                                  ? Icon(
                                Icons.person,
                                size: w * 0.08,
                                color: Colors.grey.shade700,
                              )
                                  : null,
                            ),

                            SizedBox(width: w * .04),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:   driverprofileController.driverName.value,
                                  textColor: ColorsList.titleTextColor,
                                  textFontSize: w * .065,
                                  textFontWeight: FontWeight.w500,
                                ),
                                CustomText(
                                  text: "+91 ${driverprofileController.driverPhone.value}",
                                  textColor: ColorsList.subtitleTextColor,
                                  textFontSize: w * .04,
                                  textFontWeight: FontWeight.w400,
                                ),
                                SizedBox(height: w * .01),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(color: ColorsList.textfieldBorderColorSe),
                      GestureDetector(
                        onTap: () {
                          CustomNavigator.push(
                            context,
                            EditProfile(),
                            transition: TransitionType.slideLeft,
                          );
                        },
                        child: customMenuItemsButton(
                          "assets/icons/editProfile.png",
                          "Edit",
                        ),
                      ),
                      SizedBox(height: w * .02),
                    ],
                  ),
                ),
              ),
              //?first list of profile menu buttons
              SizedBox(height: w * .02),
              Card(
                elevation: 1,
                color: ColorsList.scaffoldColor,
                child: Column(
                  children: List.generate(4, (index) {
                    return Column(
                      children: [
                        index == 0
                            ? SizedBox(height: w * .02)
                            : SizedBox.shrink(),
                        GestureDetector(
                          onTap: () {
                            CustomNavigator.push(
                              context,
                              firstScreens[index],
                              transition: TransitionType.slideLeft,
                            );
                          },
                          child: customMenuItemsButton(
                            firstImagePathList[index],
                            firstTitleList[index],

                            //? navigate screen=======================
                          ),
                        ),
                        index < 3
                            ? Divider(
                                indent: w * .13,
                                color: ColorsList.textfieldBorderColorSe,
                              )
                            : SizedBox.shrink(),
                        index == 3
                            ? SizedBox(height: w * .02)
                            : SizedBox.shrink(),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: w * .02),
              //?second list of profile menu buttons
              Card(
                elevation: 1,
                color: ColorsList.scaffoldColor,
                child: Column(
                  children: List.generate(3, (index) {
                    return Column(
                      children: [
                        index == 0
                            ? SizedBox(height: w * .02)
                            : SizedBox.shrink(),
                        GestureDetector(
                          onTap: () {
                            CustomNavigator.push(
                              context,
                              secondScreens[index],
                              transition: TransitionType.slideLeft,
                            );
                            privacy();
                          },
                          child: customMenuItemsButton(
                            secondImagePathList[index],
                            secondTitleList[index],

                          ),
                        ),
                        index < 2
                            ? Divider(
                                indent: w * .13,
                                color: ColorsList.textfieldBorderColorSe,
                              )
                            : SizedBox.shrink(),
                        index == 2
                            ? SizedBox(height: w * .02)
                            : SizedBox.shrink(),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: w * .02),
              GestureDetector(
                onTap: () {
                  PopUps().logout(context);
                },
                child: Card(
                  elevation: 1,
                  color: ColorsList.scaffoldColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * .04,
                      vertical: w * .04,
                    ),
                    child: Row(
                      children: [
                        //  Image on left
                        CustomImages.images(
                          "assets/icons/logoutIcon.png",
                          w * .06,
                          w * .06,
                        ),
                        SizedBox(width: w * 0.02),

                        //Title
                        CustomText(
                          text: "Logout",
                          textColor: ColorsList.redColor,
                          textFontSize: w * .04,
                          textFontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: w * .3),
            ],
          ),
        ),
      ),
    );
  }

  Widget customMenuItemsButton(
    String imagePath,
    String title,
    //  Widget navigateScreen,
  ) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      color: ColorsList.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .012),
        child: Row(
          children: [
            //  Image on left
            CustomImages.images(imagePath, w * .07, w * .07),
            SizedBox(width: w * 0.02),

            //Title
            CustomText(
              text: title,
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .04,
              textFontWeight: FontWeight.w400,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorsList.subtitleTextColor,
              size: w * 0.04,
            ),
          ],
        ),
      ),
    );
  }
  void privacy()async{
    await privacyPolicy.getCompanyData(


    );
  }
}
