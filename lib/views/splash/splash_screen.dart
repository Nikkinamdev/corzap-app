import 'package:corezap_driver/controller/location_controller.dart';
import 'package:corezap_driver/session/session_manager.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../apis/auth.dart';
import '../../apis/driver_detail_apis.dart';
import '../bottomNavigation/bottomNavMain_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Auth auth = Get.find<Auth>();
  //LocationController locationController = Get.put(LocationController()..);̥
  // DashBoardApis driverprofileController = Get.put(DashBoardApis());

  @override
  void initState() {
    super.initState();
    _loadData(); // <-- async function (not awaited)
  }

  Future<void> _loadData() async {
    // Load driver profile
    // await driverprofileController.DriverProfile(
    //   SessionManager.getDriverId().toString(),
    // );
    // await driverprofileController.toggleDriverStatus(
    // id:   SessionManager.getDriverId().toString(),
    // );
    // Delay not needed unless you want animation
    await Future.delayed(Duration(seconds: 3));

    // Check login state
    await auth.checkLoginStatus();

    if (!mounted) return;

    if (auth.isLoggedIn.value) {
      CustomNavigator.pushReplacement(context, BottomnavmainScreen());
    } else {
      CustomNavigator.pushReplacement(context, OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      height: h,
      width: w,
      color: AppColors.white,
      child: Center(
        child: Image.asset(
          'assets/icons/Logo.png',
          height: w * 0.5,
          width: w * 0.5,
        ),
      ),
    );
  }
}
