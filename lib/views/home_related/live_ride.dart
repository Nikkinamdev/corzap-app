import 'package:corezap_driver/apis/ride_apis.dart';
import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/controller/ride_data_controller.dart';
import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/bottom_Sheets/custom_bottom_sheets.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_appbar.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/home_related/circular_timer.dart';
import 'package:corezap_driver/views/scheduled_pickups/accepted_screen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../../apis/driver_detail_apis.dart';

class LiveRide extends StatefulWidget {
  const LiveRide({super.key});

  @override
  State<LiveRide> createState() => _LiveRideState();
}

class _LiveRideState extends State<LiveRide> {
  final rideCtrl = Get.find<RideDataController>();
  String currentDate = DateFormat('d, MMMM, yyyy').format(DateTime.now());

  StepperController stepperController = Get.find<StepperController>();
  Controllers cancelRideController = Get.find<Controllers>();
  RideApisController rideAccept = Get.put(RideApisController());
  DashBoardApis vehicleid = Get.find<DashBoardApis>();
  // pickup drop time
  // List detailsAbout = ["Pick up", "Drop", "Time"];
  // List details = ["11Km", "4 km", "10 min"];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cancelRideController.cancelRideReasonIndex.value = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    var data = rideCtrl.rideData;

    List detailsAbout = ["Pick up", "Drop", "Time"];
    List details = [
      "${data['driverDistance']} Km",
      "${data['distance']} Km",
      "${data['estimatedTime'] ?? '10 min'}",
    ];
    //  return Obx(() {
    //     var data = rideCtrl.rideData;

    //     if (data.isEmpty) {
    //       return Text("No Ride Received Yet");
    //     }

    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text("Ride ID: ${data['rideId']}"),
    // Text("Rider ID: ${data['riderId']}"),
    // Text("Ride Type: ${data['rideType']}"),
    // Text("Driver Distance: ${data['driverDistance']} km"),
    // Text("Timestamp: ${data['timestamp']}"),

    // const SizedBox(height: 10),
    // Text("Start Location Address: ${data['startLocation']?['address']}"),
    // Text("Start Lat: ${data['startLocation']?['coordinates']?[0]}"),
    // Text("Start Lng: ${data['startLocation']?['coordinates']?[1]}"),

    // const SizedBox(height: 10),
    // Text("End Location Address: ${data['endLocation']?['address']}"),
    // Text("End Lat: ${data['endLocation']?['coordinates']?[0]}"),
    // Text("End Lng: ${data['endLocation']?['coordinates']?[1]}"),

    // const SizedBox(height: 10),
    // Text("Pickup Lat: ${data['pickup']?['latitude']}"),
    // Text("Pickup Lng: ${data['pickup']?['longitude']}"),

    // const SizedBox(height: 10),
    // Text("Destination Lat: ${data['destination']?['latitude']}"),
    // Text("Destination Lng: ${data['destination']?['longitude']}"),

    // const SizedBox(height: 10),
    // Text("Total Fare: ₹${data['totalFare']}"),
    // Text("Distance: ${data['distance']} km"),
    //       ],
    //     );
    //   });
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .04),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: w * .05),
                Container(
                      width: w,
                      height: w * 0.40,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(w * 0.03),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: w * 0.04),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  color: AppColors.green,
                                  size: w * .063,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppFonts.textPoppins(
                                  context,
                                  // "100.0",
                                  "${data['totalFare']}",
                                  w * 0.08,
                                  FontWeight.bold,
                                  AppColors.green,
                                  TextAlign.center,
                                  TextOverflow.visible,
                                ),
                              ],
                            ),

                            AppFonts.textPoppins(
                              context,
                              //  "30, August, 2025",
                              currentDate,
                              w * 0.03,
                              FontWeight.w500,
                              AppColors.black,
                              TextAlign.center,
                              TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate()
                    .fade(duration: 820.ms, curve: Curves.easeInOut)
                    .scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1, 1),
                    ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: w * .04),
                  child:
                      Container(
                            width: w,
                            height: w * 0.28,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(w * 0.03),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: w * .04,
                                vertical: w * .04,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(3, (index) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: w * .25,
                                        color: AppColors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AppFonts.textPoppins(
                                              context,
                                              detailsAbout[index],
                                              w * 0.035,
                                              FontWeight.w600,
                                              AppColors.mediumGray,
                                              TextAlign.center,
                                              TextOverflow.visible,
                                            ),

                                            AppFonts.textPoppins(
                                              context,
                                              details[index],
                                              w * 0.035,
                                              FontWeight.bold,
                                              AppColors.black,
                                              TextAlign.center,
                                              TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                      ),

                                      index < 2
                                          ? VerticalDivider(
                                              color: AppColors.mediumGray,
                                              thickness: 1,
                                              // width: w * .1,
                                            )
                                          : SizedBox(),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          )
                          .animate()
                          .fade(duration: 820.ms, curve: Curves.easeInOut)
                          .scale(
                            begin: const Offset(0.95, 0.95),
                            end: const Offset(1, 1),
                          ),
                ),
                AppFonts.textPoppins(
                  context,
                  "Location",
                  w * 0.035,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.visible,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: w * .03),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CustomImages.images(
                            "assets/icons/greenDot.png",
                            w * .05,
                            w * .05,
                          ),
                          SizedBox(
                            height: w * .1,
                            child: DottedLine(
                              direction: Axis.vertical,
                              lineLength: double.infinity,
                              dashLength: 4,
                              dashColor: AppColors.green,
                            ),
                          ),
                          CustomImages.images(
                            "assets/icons/redDot.png",
                            w * .05,
                            w * .05,
                          ),
                        ],
                      ),
                      SizedBox(width: w * .01),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppFonts.textPoppins(
                            context,
                            "Pickup",
                            w * 0.035,
                            FontWeight.w500,
                            AppColors.mediumGray,
                            TextAlign.left,
                            TextOverflow.visible,
                          ),
                          SizedBox(
                            width: w * .85,
                            // color: Colors.amber,
                            child: AppFonts.textPoppins(
                              context,
                              "${data['startLocation']?['address']}",
                              w * 0.039,
                              FontWeight.w500,
                              AppColors.black,
                              TextAlign.left,
                              TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: w * .048),
                          AppFonts.textPoppins(
                            context,
                            "Drop",
                            w * 0.035,
                            FontWeight.w500,
                            AppColors.mediumGray,
                            TextAlign.left,
                            TextOverflow.visible,
                          ),
                          SizedBox(
                            width: w * .85,
                            //  color: Colors.amber,
                            child: AppFonts.textPoppins(
                              context,
                              "${data['endLocation']?['address']}",
                              w * 0.039,
                              FontWeight.w500,
                              AppColors.black,
                              TextAlign.left,
                              TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //? timer for except ride
                Center(child: CircularTimer(size: w * .5)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: w * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButtons.outlined(
                        width: w * .43,
                        context: context,
                        text: "Cancel",
                        onClicked: () {
                          CustomBottomSheets().cancelRide(context);

                          // CustomNavigator.push(
                          //   context,
                          //   LiveRide(),
                          //   transition: TransitionType.fade,
                          // );
                        },
                        isFullWidth: false,
                        backgroundColor: AppColors.lightGray,
                        textColor: AppColors.mediumGray,
                        borderColor: Colors.transparent,
                        fontSize: w * .045,
                        height: w * .140,
                        radius: 30,
                      ),
                      AppButtons.outlined(
                        width: w * .43,
                        context: context,
                        text: "Accept",
                        onClicked: () async {
                          stepperController.resetSteps();
                          // stepperController.activeStep.value = 1;
                          await rideAccept.AcceptRide(
                            vehicleId: vehicleid.vehicleId.value,
                            orderStatus: "Accepted", orderId: rideCtrl.rideId.value,
                          );
                          if (rideAccept.RideAcceptStatus.value == true) {
                            CustomNavigator.push(
                              context,

                              ArrivingClient(),
                              transition: TransitionType.slideLeft,
                            );
                          } else {
                            CustomNavigator.push(
                              context,

                              ArrivingClient(),
                              transition: TransitionType.slideLeft,
                            );
print("rodeeeeee${rideAccept.RideAcceptMessage.value}");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(backgroundColor: AppColors.primaryRed,
                                content: CustomText(
                                  text: rideAccept.RideAcceptMessage.value,textColor: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                        isFullWidth: false,
                        backgroundColor: ColorsList.mainButtonColor,
                        textColor: ColorsList.mainButtonTextColor,
                        fontSize: w * .045,
                        height: w * .140,
                        radius: 30.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
