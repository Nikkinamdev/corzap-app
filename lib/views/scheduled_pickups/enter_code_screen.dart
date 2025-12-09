import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_otps/custom_pin.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/location_input_textfield.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/scheduled_pickups/accepted_screen.dart';
import 'package:corezap_driver/views/scheduled_pickups/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  StepperController stepperController = Get.find<StepperController>();

  String imagePath = "";
  int activeStep = 0;
  late GoogleMapController mapController;
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(23.2599, 77.4126), // Example: Bhopal
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsList.scaffoldColor,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        titleSpacing: w * .03,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                //   CustomNavigation.pop(context);
              },
              child: CustomImages.images(
                "assets/icons/arrowLeftIcon.png",
                w * .07,
                w * .07,
              ),
            ),
            SizedBox(width: w * .02),
            //Arriving Client
            CustomText(
              text: "Arriving Client",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .055,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .03),
              child: Column(
                children: [
                  //custom app bar==================
                  SizedBox(height: w * .02),
                  LocationInputTextfield(
                    onPressed: () {},
                    preffixImage: "assets/icons/greenDot.png",
                    //  preffixhorizontalPadding: w * .02,
                    // preffixverticalPadding: w * .04,
                    hintText: "Your Current Location",
                  ),
                  SizedBox(height: w * .02),
                  LocationInputTextfield(
                    onPressed: () {},
                    preffixImage: "assets/icons/redDot.png",
                    //  preffixhorizontalPadding: w * .02,
                    // preffixverticalPadding: w * .04,
                    hintText: "Drop location",
                  ),
                  SizedBox(height: w * .02),
                ],
              ),
            ),
            SizedBox(
              height: w * .5,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _initialPosition,
                    mapType:
                        MapType.normal, // normal, satellite, hybrid, terrain
                    myLocationEnabled: true, // user location show
                    myLocationButtonEnabled: true, // location button
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                  Positioned(
                    bottom: w * .02,
                    left: w * .3,
                    right: w * .3,

                    child: Container(
                      height: w * .1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorsList.iconGreyColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: w * .03),
                        child: CustomText(
                          text: "OTP",
                          textColor: ColorsList.mainButtonTextColor,
                          textFontSize: w * .032,
                          textFontWeight: FontWeight.w400,
                          textalign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * .03,
                      vertical: w * .04,
                    ),
                    child: Container(
                      // height: w * .3,
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * .03,
                          vertical: w * .03,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                //? review rating----------------------
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: w * .055,
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage:
                                        imagePath != null &&
                                            imagePath.isNotEmpty
                                        ? AssetImage(
                                            imagePath,
                                          ) //  NetworkImage(imageUrl)
                                        : null,
                                    child:
                                        (imagePath == null || imagePath.isEmpty)
                                        ? Icon(
                                            Icons.person,
                                            size: w * .08,
                                            color: Colors.grey.shade700,
                                          )
                                        : null,
                                  ),
                                  SizedBox(width: w * .03),
                                  CustomText(
                                    text: "Amaan Shaikh ", // 1,2,3,4
                                    textColor: ColorsList.titleTextColor,
                                    textFontSize: w * .046,
                                    textFontWeight: FontWeight.w400,
                                  ),
                                  Spacer(),
                                  //======================call and chat btton================
                                  Container(
                                    // margin: EdgeInsets.all(w * .02),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorsList.mainButtonLightColor,
                                    ),

                                    padding: EdgeInsets.all(w * 0.02),
                                    child: Icon(
                                      Icons.call,
                                      color: ColorsList.mainAppColor,
                                      size: w * .04,
                                    ),
                                  ),
                                  SizedBox(width: w * .02),
                                  GestureDetector(
                                    onTap: () {
                                      CustomNavigator.push(
                                        context,
                                        ChatScreen(),
                                        transition: TransitionType.slideTop,
                                      );
                                    },
                                    child: Container(
                                      // margin: EdgeInsets.all(w * .02),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorsList.mainButtonLightColor,
                                      ),

                                      padding: EdgeInsets.all(w * 0.02),
                                      child: CustomImages.images(
                                        "assets/icons/chatIcon.png",
                                        w * .044,
                                        w * .044,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: w * .05),
                  AppFonts.textPoppins(
                    context,
                    "Enter PIN",
                    w * 0.04,
                    FontWeight.w500,
                    AppColors.black,
                    TextAlign.center,
                    TextOverflow.visible,
                  ),
                  // enter pin here
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * .24,
                      vertical: w * .1,
                    ),
                    child: CustomPin(),
                  ),
                  SizedBox(height: w * .1),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * .03),
                    child: AppButtons.solid(
                      context: context,
                      text: "Verify",
                      onClicked: () {
                        stepperController.nextStep();
                        CustomNavigator.pop(context);
                      },
                      isFullWidth: true,
                      backgroundColor: ColorsList.mainButtonColor,
                      textColor: ColorsList.mainButtonTextColor,
                      fontSize: w * .045,
                      height: w * .140,
                      radius: 12.0,
                    ),
                  ),
                  SizedBox(height: w * .1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
