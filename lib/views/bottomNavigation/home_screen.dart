import 'package:corezap_driver/apis/driver_detail_apis.dart';
import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/controller/ride_data_controller.dart';
import 'package:corezap_driver/controller/socket_controller.dart';
import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/session/session_manager.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/alerts/driver_agreement.dart';
import 'package:corezap_driver/views/home_related/live_ride.dart';
import 'package:corezap_driver/views/home_related/raise_requiest.dart';
import 'package:corezap_driver/views/profile_related.dart/documents.dart';
import 'package:corezap_driver/views/scheduled_pickups/accepted_screen.dart';
import 'package:corezap_driver/views/scheduled_pickups/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../controller/location_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final rideCtrl = Get.find<RideDataController>();
  final rideController = Get.put(RideDataController());
  final SocketController socketController = Get.put(SocketController());
  Controllers controllers = Get.put(Controllers());

  StepperController stepperController = Get.put(StepperController());
  DashBoardApis driverprofileController = Get.find<DashBoardApis>();
  //DashBoardApis driverstatusController = Get.put(DashBoardApis());
  LocationController location = Get.put(LocationController());

  @override
  initState() {
    // TODO: implement initState

    super.initState();
    _loadData();
     driverprofileController.toggleDriverStatus(
      id: SessionManager.getDriverId().toString(),
    );

    ever(rideController.rideData, (data) {
      if (data.isNotEmpty) {
        print("live ride screen open");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomNavigator.push(
            context,
            LiveRide(),
            transition: TransitionType.fade,
          );
        });
      }
    });
  }


  Future<void> _loadData() async {
    String driverId = SessionManager.getDriverId().toString();

    await driverprofileController.DriverProfile(driverId);


  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(w * .300),
        child: Container(
          height: w * .290,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(w * 0.04),
              bottomRight: Radius.circular(w * 0.04),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Section - Profile
                  Obx(
                    () => Row(
                      children: [
                        CircleAvatar(
                          radius: w * 0.06,
                          backgroundImage:
                              driverprofileController
                                  .driverImage
                                  .value
                                  .isNotEmpty
                              ? NetworkImage(
                                  driverprofileController.driverImage.value,
                                )
                              : null,
                          child:
                              driverprofileController.driverImage.value.isEmpty
                              ? Icon(Icons.person, size: w * 0.08)
                              : null,
                        ),

                        SizedBox(width: w * 0.03),
                        driverprofileController.loading.value
                            ? const CircularProgressIndicator()
                            : AppFonts.textPoppins(
                                context,
                                driverprofileController.driverName.value,
                                w * 0.04,
                                FontWeight.w600,
                                AppColors.black,
                                TextAlign.left,
                                TextOverflow.visible,
                              ),
                      ],
                    ),
                  ),

                  Obx(
                        () {
                      final isOnline = driverprofileController.driverStatus.value;

                      return InkWell(
                        onTap: () async {
                          final socketCtrl = Get.find<SocketController>();
                          final locationCtrl = Get.find<LocationController>();
                          final driverCtrl = driverprofileController;

                          // Optimistically toggle driver status
                          driverCtrl.driverStatus.value = !isOnline;

                          // Update socket & location immediately for smooth UI
                          if (driverCtrl.driverStatus.value) {
                            locationCtrl.startLocationStream();
                            socketCtrl.goOnline();
                          } else {
                            locationCtrl.stopLocationStream();
                            socketCtrl.goOffline();
                          }

                          // Call StartDuty API in background
                          try {
                            await driverCtrl.toggleDriverStatus(
                              id: SessionManager.getDriverId().toString(),
                            );

                            // Sync backend status if needed
                            if (driverCtrl.backendStatus.value != driverCtrl.driverStatus.value) {
                              driverCtrl.driverStatus.value = driverCtrl.backendStatus.value;

                              if (driverCtrl.backendStatus.value) {
                                locationCtrl.startLocationStream();
                                socketCtrl.goOnline();
                              } else {
                                locationCtrl.stopLocationStream();
                                socketCtrl.goOffline();
                              }
                            }
                          } catch (e) {
                            // Revert UI if API fails
                            driverCtrl.driverStatus.value = isOnline;
                            if (isOnline) {
                              locationCtrl.startLocationStream();
                              socketCtrl.goOnline();
                            } else {
                              locationCtrl.stopLocationStream();
                              socketCtrl.goOffline();
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(w * 0.06),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          width: w * 0.26,
                          height: w * 0.10,
                          padding: EdgeInsets.symmetric(horizontal: w * 0.015),
                          decoration: BoxDecoration(
                            color: isOnline
                                ? AppColors.green.withOpacity(0.1)
                                : AppColors.primaryRed.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(w * 0.06),
                            border: Border.all(
                              color: isOnline ? AppColors.green : AppColors.primaryRed,
                              width: 1.2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: isOnline ? Alignment.centerLeft : Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                                  child: AppFonts.textPoppins(
                                    context,
                                    isOnline ? "Online" : "Offline",
                                    w * 0.032,
                                    FontWeight.w500,
                                    isOnline ? AppColors.green : AppColors.primaryRed,
                                    TextAlign.center,
                                    TextOverflow.visible,
                                  ),
                                ),
                              ),
                              AnimatedAlign(
                                duration: const Duration(milliseconds: 250),
                                alignment: isOnline ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  width: w * 0.06,
                                  height: w * 0.06,
                                  decoration: BoxDecoration(
                                    color: isOnline ? AppColors.green : AppColors.primaryRed,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )



                ],
              ),
            ),
          ),
        ),
      ),

      //body
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // driver agreement
              SizedBox(height: w * 0.04),

              //banner like container
              Container(
                    width: w,
                    // height: w * 0.30,
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
                        horizontal: w * .03,
                        vertical: w * .03,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //left side
                          Image.asset(
                            'assets/images/driverAgreement.png',
                            width: w * 0.07,
                            height: w * 0.07,
                            fit: BoxFit.contain,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.02),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppFonts.textPoppins(
                                  context,
                                  "Driver Agreement Required",
                                  w * 0.04,
                                  FontWeight.w600,
                                  Color.fromRGBO(30, 58, 138, 1),
                                  TextAlign.left,
                                  TextOverflow.ellipsis,
                                ),
                                SizedBox(height: w * 0.01),
                                SizedBox(
                                  width: w * .72,
                                  child: AppFonts.textPoppins(
                                    context,
                                    "Please upload and e-sign your driver agreement to continue accepting rides.",
                                    w * 0.026,
                                    FontWeight.w400,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  width: w * .75,
                                  height: w * .1,
                                  // color: Colors.amber,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      AppButtons.solid(
                                            context: context,
                                            text: "Continue",
                                            padding: EdgeInsets.zero,
                                            onClicked: () {
                                              print("crash check 1");
                                              CustomNavigator.push(
                                                context,
                                                DriverAgreement(),
                                                transition:
                                                    TransitionType.slideTop,
                                              );
                                              print("crash check 2");
                                            },
                                            width: w * .23,

                                            backgroundColor:
                                                ColorsList.mainButtonColor,
                                            textColor:
                                                ColorsList.mainButtonTextColor,
                                            fontSize: w * .032,
                                            height: w * .09,
                                            radius: 30,
                                          )
                                          .animate()
                                          .fade(
                                            duration: 800.ms,
                                            curve: Curves.easeInOut,
                                          )
                                          .scale(
                                            begin: const Offset(0.95, 0.95),
                                            end: const Offset(1, 1),
                                          ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //right side
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

              // document submission is pending
              Padding(
                padding: EdgeInsets.symmetric(vertical: w * .04),
                child: InkWell(
                  onTap: () {
                    CustomNavigator.push(
                      context,
                      Documents(),
                      transition: TransitionType.slideLeft,
                    );
                  },
                  child:
                      Container(
                            width: w,
                            //  height: w * 0.30,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(254, 238, 238, 1),
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
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //left side
                                      Image.asset(
                                        'assets/icons/pending1.png',
                                        width: w * 0.06,
                                        height: w * 0.06,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: w * .02),
                                      Column(
                                        children: [
                                          AppFonts.textPoppins(
                                            context,
                                            "Documents submission is pending",
                                            w * 0.038,
                                            FontWeight.w600,
                                            AppColors.black,
                                            TextAlign.left,
                                            TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      // Padding(
                                      //   padding: EdgeInsets.only(left: w * 0.02),
                                      //   child: Column(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     mainAxisAlignment: MainAxisAlignment.start,
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       AppFonts.textPoppins(
                                      //         context,
                                      //         "Documents submission is pending",
                                      //         w * 0.035,
                                      //         FontWeight.w600,
                                      //         AppColors.black,
                                      //         TextAlign.left,
                                      //         TextOverflow.ellipsis,
                                      //       ),
                                      //       SizedBox(height: w * 0.01),
                                      //       SizedBox(
                                      //         width: w * .7,
                                      //         child: AppFonts.textPoppins(
                                      //           context,
                                      //           "Document verification is incomplete. Kindly upload the pending documents to proceed.",
                                      //           w * 0.025,
                                      //           FontWeight.w500,
                                      //           AppColors.mediumGray,
                                      //           TextAlign.left,
                                      //           TextOverflow.ellipsis,
                                      //           maxLines: 2,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppColors.black,
                                        size: w * .035,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),

                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * .02),
                                      child: SizedBox(
                                        width: w * .7,
                                        child: AppFonts.textPoppins(
                                          context,
                                          "Document verification is incomplete. Kindly upload the pending documents to proceed.",
                                          w * 0.026,
                                          FontWeight.w400,
                                          AppColors.mediumGray,
                                          TextAlign.left,
                                          TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
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
                ),
              ),
              //some space

              //banner like container
              Container(
                    width: w,
                    height: w * 0.30,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //left side
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFonts.textPoppins(
                                context,
                                "Your dedication fuels your drive.",
                                w * 0.027,
                                FontWeight.w600,
                                AppColors.black,
                                TextAlign.left,
                                TextOverflow.visible,
                              ),
                              SizedBox(height: w * 0.01),
                              AppFonts.textPoppins(
                                context,
                                "Your drive fuels your success.",
                                w * 0.027,
                                FontWeight.w600,
                                AppColors.black,
                                TextAlign.left,
                                TextOverflow.visible,
                              ),
                            ],
                          ),
                        ),

                        //right side
                        Image.asset(
                          'assets/images/home1.png',
                          width: w * 0.41,
                          height: w * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fade(duration: 820.ms, curve: Curves.easeInOut)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                  ),

              //text todays's update
              SizedBox(height: w * 0.05),
              Align(
                alignment: Alignment.centerLeft,
                child:
                    AppFonts.textPoppins(
                          context,
                          "Today's Update",
                          w * 0.038,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.left,
                          TextOverflow.visible,
                        )
                        .animate()
                        .fade(duration: 820.ms, curve: Curves.easeInOut)
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1),
                        ),
              ),

              //some space
              SizedBox(height: w * 0.04),

              Wrap(
                spacing: w * 0.04,
                runSpacing: w * 0.04,
                children: [
                  //common widget 1
                  commonWidget1(
                        w,
                        Colors.green,
                        "Total Earnings",
                        "Cash",
                        "300",
                        "100",
                      )
                      .animate()
                      .fade(duration: 830.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),

                  //common widget 1
                  commonWidget1(
                        w,
                        Colors.green.withOpacity(0.4),
                        "Total Earnings",
                        "Online",
                        "300",
                        "200",
                      )
                      .animate()
                      .fade(duration: 830.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),

                  //common widget 1
                  commonWidget1(
                        w,
                        Colors.blueAccent.withOpacity(0.6),
                        "Total Rides",
                        "Completed",
                        "100",
                        "80",
                      )
                      .animate()
                      .fade(duration: 860.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),

                  //common widget 1
                  commonWidget1(
                        w,
                        Colors.red,
                        "Total Rides",
                        "Cancel",
                        "100",
                        "10",
                      )
                      .animate()
                      .fade(duration: 860.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: w * .03),
                child: AppFonts.textPoppins(
                  context,
                  "Your Scheduled Pickups",
                  w * 0.04,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.visible,
                ),
              ),
              InkWell(
                onTap: () {
                  stepperController.resetSteps();
                  // location.fetchLocation();
                  // stepperController.nextStep();
                  CustomNavigator.push(context, ArrivingClient());
                },
                child: SizedBox(
                  height: w * 0.65,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    clipBehavior: Clip.none, // 4 containers
                    //  padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: w * 0.03),
                        child: Container(
                          width: w * 0.8,
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
                              Image.asset(
                                "assets/images/map.png",
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: w * .03),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * .03,
                                  //   vertical: w * .01,
                                ),
                                child: Details().rideLocations(context),
                              ),
                              SizedBox(height: w * .03),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * .03,
                                  // vertical: w * .01,
                                ),
                                child: Details().rideCostDetails(context),
                              ),
                              SizedBox(height: w * .03),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: w * .1),
              Container(
                // height: w * 0.4,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: w * .06,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.person,
                                    size: w * .05,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 6,
                                  child: GestureDetector(
                                    onTap: () {
                                      //  Pick Image from gallery
                                    },
                                    child: CircleAvatar(
                                      radius: w * .015,
                                      backgroundColor: Colors.grey.shade300,
                                      child: CircleAvatar(
                                        radius: w * .012,
                                        backgroundColor: AppColors.white,
                                        child: CircleAvatar(
                                          radius: w * .01,
                                          backgroundColor: AppColors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: w * .02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AppFonts.textPoppins(
                                    context,
                                    "Swift Dzire",
                                    w * 0.04,
                                    FontWeight.w600,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                  ),
                                  SizedBox(width: w * .02),
                                  CircleAvatar(
                                    radius: 2,
                                    backgroundColor: AppColors.black,
                                  ),
                                  SizedBox(width: w * .02),
                                  AppFonts.textPoppins(
                                    context,
                                    "Mini",
                                    w * 0.04,
                                    FontWeight.w600,
                                    const Color.fromARGB(255, 0, 94, 255),
                                    TextAlign.left,
                                    TextOverflow.visible,
                                  ),
                                  SizedBox(width: w * .07),
                                  AppButtons.solid(
                                    padding: EdgeInsets.zero,
                                    context: context,
                                    text: "Assigned Vehicle",
                                    onClicked: () {},
                                    isFullWidth: false,
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      234,
                                      241,
                                      255,
                                    ),
                                    radius: 30,
                                    textColor: ColorsList.linksTextColor,
                                    fontSize: w * .025,
                                    height: w * .05,
                                    width: w * .28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              AppFonts.textPoppins(
                                context,
                                "HR26DQ5551",
                                w * 0.035,
                                FontWeight.w400,
                                AppColors.mediumGray,
                                TextAlign.left,
                                TextOverflow.visible,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: w * .02),
                      // raise requiest
                      RaiseRequestDropdown(
                        onSelected: (value) {
                          debugPrint("Selected Option: $value");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: w * .1),
              AppButtons.solid(
                context: context,
                text: "Live Ride",
                onClicked: () {
                  CustomNavigator.push(
                    context,
                    LiveRide(),
                    transition: TransitionType.fade,
                  );
                },
                isFullWidth: true,
                backgroundColor: ColorsList.mainButtonColor,
                textColor: ColorsList.mainButtonTextColor,
                fontSize: w * .045,
                height: w * .140,
                radius: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //? commanWidget--------
  Widget commonWidget1(
    double w,
    Color color,
    String text1,
    String text2,
    String amount1,
    String amount2,
  ) {
    return Container(
      height: w * .23,
      width: w * .43,

      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(w * 0.012),
      ),

      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          height: w * .23,
          width: w * .423,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(w * 0.012),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.03,
              vertical: w * 0.03,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //text1
                Row(
                  children: [
                    AppFonts.textPoppins(
                      context,
                      "$amount1 - ",
                      w * 0.032,
                      FontWeight.w600,
                      AppColors.black,
                      TextAlign.left,
                      TextOverflow.visible,
                    ),
                    AppFonts.textPoppins(
                      context,
                      text1,
                      w * 0.028,
                      FontWeight.w400,
                      AppColors.black,
                      TextAlign.left,
                      TextOverflow.visible,
                    ),
                  ],
                ),

                //some space
                SizedBox(height: w * 0.02),

                //text2
                Row(
                  children: [
                    AppFonts.textPoppins(
                      context,
                      "$amount2 - ",
                      w * 0.028,
                      FontWeight.w600,
                      AppColors.black,
                      TextAlign.left,
                      TextOverflow.visible,
                    ),
                    AppFonts.textPoppins(
                      context,
                      text2,
                      w * 0.028,
                      FontWeight.w400,
                      AppColors.black,
                      TextAlign.left,
                      TextOverflow.visible,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
