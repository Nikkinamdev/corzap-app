import 'package:corezap_driver/apis/driver_detail_apis.dart';
import 'package:corezap_driver/controller/document_upload_controller.dart';
import 'package:corezap_driver/controller/login.controller.dart';
import 'package:corezap_driver/controller/ride_data_controller.dart';
import 'package:corezap_driver/session/session_manager.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/views/onboarding/onboarding_screen.dart';
import 'package:corezap_driver/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'apis/auth.dart';
import 'controller/socket_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(DocumentUploadController()); // 🔥 fix
  Get.put(LoginController());
  Get.put(DashBoardApis());


  // WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.initSession();
  final isLoggedIn = await SessionManager.isLoggedIn();
  Get.put(SocketController());
  // Get.put(RideDataController());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  Get.put(Auth());

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corezap Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
      ),
      home: const SplashScreen(),
    );
  }
}
