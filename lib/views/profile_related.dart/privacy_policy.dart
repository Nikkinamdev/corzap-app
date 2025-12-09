import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../apis/help_apis.dart';

class PrivacyPolicy extends StatelessWidget {
   PrivacyPolicy({super.key});
  HelpApisController privacyPolicy = Get.find<HelpApisController>();
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
              text: "Privacy Policy",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: w * .04,
              height: 1.5,
            ),
            children: [
               TextSpan(
                text:
                "${privacyPolicy.companyData.value?.privacyPolicy}\n\n",
              ),

              // 1. Information We Collect
              const TextSpan(
                text: "1. Information We Collect\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text:
                    "We collect the following types of information when you use our app:\n",
              ),
              const TextSpan(text: "a. Personal Information\n"),
               TextSpan(text: "• ${privacyPolicy.companyData.value!.companyName}\n"),
               TextSpan(text: "• ${privacyPolicy.companyData.value!.whatsappNumber}\n"),
               TextSpan(text: "• ${privacyPolicy.companyData.value!.supportEmail}\n"),
               TextSpan(text: "• Profile photo (optional)\n"),
               TextSpan(
                text:
                    "• Payment details (processed via secure payment gateways)\n",
              ),
              const TextSpan(text: "b. Ride Information\n"),
              const TextSpan(text: "• Pickup and drop-off locations\n"),
              const TextSpan(text: "• Date and time of rides\n"),
              const TextSpan(text: "• Ride history\n"),
              const TextSpan(text: "c. Device & Location Information\n"),
              const TextSpan(
                text: "• GPS location (only while using the app)\n",
              ),
              const TextSpan(
                text: "• Device type, operating system, and app version\n",
              ),
              const TextSpan(text: "• IP address\n"),
              const TextSpan(text: "d. Communication Data\n"),
              const TextSpan(text: "• Feedback, ratings, and reviews\n"),
              const TextSpan(
                text:
                    "• Chat or call details between you and drivers (if applicable)\n\n",
              ),

              // 2. How We Use Your Information
              const TextSpan(
                text: "2. How We Use Your Information\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(text: "We use your information to:\n"),
              const TextSpan(
                text: "• Provide ride booking and transportation services\n",
              ),
              const TextSpan(text: "• Match you with nearby drivers\n"),
              const TextSpan(
                text: "• Process payments and generate invoices\n",
              ),
              const TextSpan(
                text: "• Improve app functionality and user experience\n",
              ),
              const TextSpan(
                text:
                    "• Send trip updates, notifications, and service alerts\n",
              ),
              const TextSpan(
                text: "• Ensure safety and security of riders and drivers\n",
              ),
              const TextSpan(text: "• Comply with legal obligations\n\n"),

              // 3. Data Storage & Security
              const TextSpan(
                text: "3. Data Storage & Security\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text: "• Your data is stored securely on encrypted servers.\n",
              ),
              const TextSpan(
                text:
                    "• Access to personal information is restricted to authorized staff only.\n",
              ),
              const TextSpan(
                text:
                    "• We implement security measures to protect against unauthorized access, alteration, disclosure, or destruction.\n\n",
              ),

              // 4. Location Data
              const TextSpan(
                text: "4. Location Data\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text:
                    "Your real-time location is required to provide ride services. You can disable location access in your device settings, but this may limit app functionality.\n\n",
              ),

              // 5. Contact Us
              const TextSpan(
                text: "5. Contact Us\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const TextSpan(
                text:
                    "If you have any questions or concerns about this Privacy Policy, contact us at:\n",
              ),
               TextSpan(text: "• Email:  ${privacyPolicy.companyData.value?.supportEmail}\n"),
               TextSpan(text: "• Phone: ${privacyPolicy.companyData.value?.contactNumber}\n"),
               TextSpan(text: "• Address: ${privacyPolicy.companyData.value?.address}\n"),
            ],
          ),
        ),
      ),
    );
  }
}
