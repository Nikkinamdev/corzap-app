import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:flutter/material.dart';

class CashPaymentScreen extends StatelessWidget {
  const CashPaymentScreen({super.key});

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
              'assets/images/cash1.png',
              height: w * 0.8,
              width: w * 1.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: w * .02),
              child: AppFonts.textPoppins(
                context,
                "Collect Cash Payment",
                w * 0.065,
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
                "Collect the shown fare in cash from the user. Make sure the amount is correct.",
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
