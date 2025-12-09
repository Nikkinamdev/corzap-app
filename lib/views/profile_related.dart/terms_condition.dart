import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../apis/help_apis.dart';

class TermsCondition extends StatelessWidget {
  TermsCondition({super.key});

  HelpApisController termscondition = Get.find<HelpApisController>();

  @override
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
                CustomNavigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: w * .07,
                color: ColorsList.iconColor,
              ),
            ),
            SizedBox(width: w * .035),
            CustomText(
              text: "Terms & Conditions",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      // body: CustomImages.images(
      //   "assets/images/termsCondition.png",
      //   double.infinity,
      //   double.infinity,
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * .04),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: w * .04,
              height: 1.5,
            ),
            children: [
              const TextSpan(
                text:
                    "Welcome to [Your App Name]. By using our app and services, you agree to follow these Terms & Conditions. Please read them carefully before booking or accepting a ride.\n\n",
              ),

              // 1. General
              const TextSpan(
                text: "1. General\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text:
                    "• These Terms govern your use of [Your App Name] (the “App” or “Service”).\n",
              ),
              const TextSpan(
                text:
                    "• We may update these Terms from time to time. Continued use of the App means you accept the updated Terms.\n\n",
              ),

              // 2. User Eligibility
              const TextSpan(
                text: "2. User Eligibility\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text: "• You must be 18 years or older to use the app.\n",
              ),
              const TextSpan(
                text:
                    "• You must provide accurate personal details and maintain your account information.\n\n",
              ),

              // 3. Safety
              const TextSpan(
                text: "3. Safety\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text:
                    "• For your safety, share your ride details with family or friends.\n",
              ),
              const TextSpan(
                text:
                    "• The company is not responsible for any accidents, delays, or incidents caused by third parties.\n\n",
              ),

              // 4. User Responsibilities
              const TextSpan(
                text: "4. User Responsibilities\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text: "• Provide correct pickup and drop-off locations.\n",
              ),
              const TextSpan(
                text:
                    "• Treat drivers, passengers, and vehicles with respect.\n",
              ),
              const TextSpan(
                text:
                    "• No illegal or dangerous items are allowed in the vehicle.\n\n",
              ),

              // 5. Cancellation & Refunds
              const TextSpan(
                text: "5. Cancellation & Refunds\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text:
                    "• Passengers may cancel a ride before the driver reaches a certain distance from pickup (as per the app’s policy).\n",
              ),
              const TextSpan(
                text:
                    "• Cancellation fees apply if canceled after this period.\n",
              ),
              const TextSpan(
                text:
                    "• Refunds, if applicable, will be processed within [X] working days.\n",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
