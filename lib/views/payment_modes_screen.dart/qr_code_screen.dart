import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class QrCodeScreen extends StatelessWidget {
  QrCodeScreen({super.key});
  // Controllers controllers = Get.find<Controllers>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: w * .2),
            Image.asset(
              'assets/icons/Logo.png',
              height: w * 0.3,
              width: w * 0.5,
            ),
            Image.asset(
              'assets/icons/qr1.png',
              height: w * 0.8,
              width: w * 1.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: w * .02),
              child: AppFonts.textPoppins(
                context,
                "Scan your QR Code",
                w * 0.048,
                FontWeight.w600,
                AppColors.black,
                TextAlign.left,
                TextOverflow.visible,
              ),
            ),
            SizedBox(height: w * .01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .04),
              child: AppFonts.textPoppins(
                context,
                "Show your QR code to the user. They can scan and pay instantly.”",
                w * 0.04,
                FontWeight.w400,
                AppColors.mediumGray,
                TextAlign.center,
                TextOverflow.visible,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
