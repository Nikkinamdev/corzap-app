import 'dart:convert';

import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/location_input_textfield.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/scheduled_pickups/chat_screen.dart';
import 'package:corezap_driver/views/scheduled_pickups/enter_code_screen.dart';
import 'package:corezap_driver/views/scheduled_pickups/receive_payment_modes.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../controller/location_controller.dart';

class ArrivingClient extends StatefulWidget {
  const ArrivingClient({super.key});

  @override
  State<ArrivingClient> createState() => _ArrivingClientState();
}

class _ArrivingClientState extends State<ArrivingClient> {
  StepperController stepperController = Get.find<StepperController>();
  String imagePath = "";
  int activeStep = 0;
  late GoogleMapController mapController;
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(23.096411232576948, 77.57272877763408), // Example: Bhopal
    zoom: 14,
  );
  @override
  // StepperController stepperController = Get.find<StepperController>();
  // late GoogleMapController mapController;
  final LatLng bhopalPickup = const LatLng(23.259933, 77.412613);

  // Use Set to avoid duplicates and improve performance
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // Example place ID - replace with actual from your booking
    showDropLocationOnMap("ChIJL_P_CXMEDTkRw0ZdG-0GVvw");
  }

  // MARKER + POLYLINE DRAWING
  Future<void> showDropLocationOnMap(String placeId) async {
    const String apiKey =
        "AIzaSyCtM1jo8qzhEn2XZ8SVCoboULcondCjZio"; // ⚠️ Never expose in production!

    try {
      // 1. Get Drop Location from Place ID
      final placeUrl =
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey";
      final placeResponse = await http.get(Uri.parse(placeUrl));

      if (placeResponse.statusCode != 200) return;

      final placeData = jsonDecode(placeResponse.body);
      if (placeData['status'] != 'OK') return;

      final location = placeData["result"]["geometry"]["location"];
      final LatLng dropLatLng = LatLng(location["lat"], location["lng"]);

      // 2. Add Drop Marker
      _markers.add(
        Marker(
          markerId: const MarkerId("dropLocation"),
          position: dropLatLng,
          infoWindow: const InfoWindow(title: "Drop Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );

      // 3. Draw Route from Pickup → Drop
      await drawPolyline(bhopalPickup, dropLatLng);

      // 4. Update map
      setState(() {});

      // 5. Animate camera to show full route
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              bhopalPickup.latitude < dropLatLng.latitude
                  ? bhopalPickup.latitude
                  : dropLatLng.latitude,
              bhopalPickup.longitude < dropLatLng.longitude
                  ? bhopalPickup.longitude
                  : dropLatLng.longitude,
            ),
            northeast: LatLng(
              bhopalPickup.latitude > dropLatLng.latitude
                  ? bhopalPickup.latitude
                  : dropLatLng.latitude,
              bhopalPickup.longitude > dropLatLng.longitude
                  ? bhopalPickup.longitude
                  : dropLatLng.longitude,
            ),
          ),
          100, // padding
        ),
      );
    } catch (e) {
      print("Error showing drop location: $e");
    }
  }

  // DRAW POLYLINE USING DIRECTIONS API
  Future<void> drawPolyline(LatLng origin, LatLng destination) async {
    const String apiKey = "AIzaSyCtM1jo8qzhEn2XZ8SVCoboULcondCjZio";

    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=${origin.latitude},${origin.longitude}"
        "&destination=${destination.latitude},${destination.longitude}"
        "&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        print("Directions API error: ${response.statusCode}");
        return;
      }

      final data = json.decode(response.body);

      if (data['status'] != 'OK' || data['routes'].isEmpty) {
        print("No route found: ${data['status']}");
        return;
      }

      final String encodedPolyline =
          data['routes'][0]['overview_polyline']['points'];
      final List<LatLng> polylinePoints = decodeEncodedPolyline(
        encodedPolyline,
      );

      _polylines.clear(); // Clear old routes
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("driver_route"),
          color: const Color(0xFF0066FF),
          // Beautiful blue
          width: 4,
          jointType: JointType.round,
          // Smooth corners
          startCap: Cap.roundCap,
          // Rounded start
          endCap: Cap.roundCap,
          // Rounded end
          points: polylinePoints,
        ),
      );

      setState(() {}); // Trigger rebuild
    } catch (e) {
      print("Polyline drawing error: $e");
    }
  }

  // POLYLINE DECODER (Already good, just made safer)
  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * .03),
            child: Column(
              children: [
                //custom app bar==================
                SizedBox(height: w * .02),
                LocationInputTextfield(
                  address: TextEditingController(text: "Bhopal"),
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
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(23.259933, 77.412613),
                    zoom: 14,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  polylines: _polylines,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),

                Obx(() {
                  final step = stepperController.activeStep.value;
                  if (step == 1 || step == 2 || step == 3) {
                    return Positioned(
                      bottom: w * .02,
                      left: (w - (w * 0.6)) / 2,
                      child: Container(
                        width: w * .6,
                        height: w * .1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: ColorsList.iconGreyColor,
                        ),
                        child: Center(
                          child: CustomText(
                            text: step == 1
                                ? "5 min to reach client"
                                : step == 2
                                ? "You reach the client"
                                : "End in 9 min",
                            textColor: ColorsList.mainButtonTextColor,
                            textFontSize: w * .032,
                            textFontWeight: FontWeight.w400,
                            textalign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.white,
              child: Column(
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
                            SizedBox(height: w * .02),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorsList.mainButtonLightColor,
                                borderRadius: BorderRadius.circular(w * .02),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * .03,
                                  vertical: w * .03,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: "Trip takes ", // 1,2,3,4
                                          textColor: ColorsList.titleTextColor,
                                          textFontSize: w * .035,
                                          textFontWeight: FontWeight.w400,
                                        ),
                                        CustomText(
                                          text: "15 minute", // 1,2,3,4
                                          textColor:
                                              ColorsList.subtitleTextColor,
                                          textFontSize: w * .038,
                                          textFontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    CustomText(
                                      text: "₹50", // 1,2,3,4
                                      textColor: ColorsList.titleTextColor,
                                      textFontSize: w * .04,
                                      textFontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //       EasyStepper(
                  //   activeStep: driverFormController.activeStep.value,
                  //   lineStyle: LineStyle(
                  //     lineType: LineType.normal,
                  //     unreachedLineType: LineType.normal,
                  //     defaultLineColor: AppColors.lightGray,
                  //     finishedLineColor: AppColors.primaryRed,
                  //     lineLength: w * .18,
                  //     lineThickness: 2,
                  //   ),
                  //   internalPadding: 0,
                  //   stepRadius: w * 0.04,
                  //   showStepBorder: false,
                  //   steps: [
                  //     //                  Preference
                  //     // Vehicle Details
                  //     // Personal Details
                  //     // Profile Photo
                  //     buildStep(
                  //       0,
                  //       'Preference',
                  //       w,
                  //       driverFormController.activeStep.value,
                  //     ),
                  //     buildStep(
                  //       1,
                  //       'Vehicle Details',
                  //       w,
                  //       driverFormController.activeStep.value,
                  //     ),
                  //     buildStep(
                  //       2,
                  //       'Personal Details',
                  //       w,
                  //       driverFormController.activeStep.value,
                  //     ),
                  //     buildStep(
                  //       3,
                  //       'Profile Photo',
                  //       w,
                  //       driverFormController.activeStep.value,
                  //     ),
                  //   ],
                  //   onStepReached: (index) => driverFormController.reachStep(index),
                  // ),
                  Obx(
                    () => EasyStepper(
                      activeStep: stepperController.activeStep.value,
                      lineStyle: LineStyle(
                        lineType: LineType.normal,
                        unreachedLineType: LineType.normal,
                        defaultLineColor: AppColors.lightGray,
                        finishedLineColor: AppColors.primaryRed,
                        lineLength: w * .18,
                        lineThickness: 2,
                      ),
                      internalPadding: 0,
                      stepRadius: w * 0.04,
                      showStepBorder: false,
                      steps: [
                        buildStep(
                          0,
                          'Accepted',
                          w,
                          stepperController.activeStep.value,
                        ),
                        buildStep(
                          1,
                          'Arriving',
                          w,
                          stepperController.activeStep.value,
                        ),
                        buildStep(
                          2,
                          'Starting',
                          w,
                          stepperController.activeStep.value,
                        ),
                        buildStep(
                          3,
                          'End Trip',
                          w,
                          stepperController.activeStep.value,
                        ),
                      ],
                      onStepReached: (index) =>
                          stepperController.reachStep(index),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * .03),
                      child: AppButtons.outlined(
                        context: context,
                        text: stepperController.activeStep.value == 1
                            ? "Arrive Client"
                            : stepperController.activeStep.value == 2
                            ? "Start Trip"
                            : stepperController.activeStep.value == 3
                            ? "Completed trip"
                            : "Completed trip",
                        onClicked: () {
                          if (stepperController.activeStep.value == 1) {
                            CustomNavigator.push(
                              context,
                              EnterCodeScreen(),
                              transition: TransitionType.fade,
                            );
                          } else if (stepperController.activeStep.value == 2) {
                            stepperController.nextStep();
                          } else if (stepperController.activeStep.value == 3) {
                            stepperController.nextStep();
                            CustomNavigator.push(
                              context,
                              ReceivePaymentModes(),
                              transition: TransitionType.fade,
                            );
                          }
                        },
                        isFullWidth: true,
                        backgroundColor: stepperController.activeStep.value == 3
                            ? AppColors.white
                            : ColorsList.mainButtonColor,
                        borderColor: AppColors.primaryRed,
                        textColor: stepperController.activeStep.value == 3
                            ? AppColors.primaryRed
                            : ColorsList.mainButtonTextColor,
                        fontSize: w * .045,
                        height: w * .140,
                        radius: 12.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * .03),
                    child: AppButtons.solid(
                      context: context,
                      text: "Deny",
                      onClicked: () {
                        // CustomNavigator.push(
                        //   context,
                        //   LiveRide(),
                        //   transition: TransitionType.fade,
                        // );
                      },
                      isFullWidth: true,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.mediumGray,
                      fontSize: w * .045,
                      height: w * .140,
                      radius: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  EasyStep buildStep(int stepIndex, String title, double w, int activeStep) {
    bool isActive = activeStep >= stepIndex;

    return EasyStep(
      customStep: isActive
          ? CircleAvatar(
              radius: w * 0.05,
              backgroundColor: AppColors.primaryRed,
              child: Icon(Icons.check, size: w * 0.05, color: AppColors.white),
            )
          : CircleAvatar(
              radius: w * 0.05,
              backgroundColor: AppColors.lightGray,
              child: CircleAvatar(
                radius: w * 0.025,
                backgroundColor: AppColors.white,
              ),
            ),
      customTitle: AppFonts.textPoppins(
        context,
        title,
        w * 0.03,
        FontWeight.w400,
        AppColors.mediumGray,
        TextAlign.center,
        TextOverflow.ellipsis,
      ),
    );
  }
}
