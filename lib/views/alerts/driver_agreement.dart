import 'package:corezap_driver/controller/document_upload_controller.dart';
import 'package:corezap_driver/controller/login.controller.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_document_uploader.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class DriverAgreement extends StatefulWidget {
  const DriverAgreement({super.key});

  @override
  State<DriverAgreement> createState() => _DriverAgreementState();
}

class _DriverAgreementState extends State<DriverAgreement> {
  // chage
  final LoginController loginController = Get.find<LoginController>();
  final DocumentUploadController docController =
      Get.find<DocumentUploadController>();
  @override
  Widget build(BuildContext context) {
    // LoginController loginController = Get.find<LoginController>();
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: w * .03,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                loginController.isCheckedAgreement.value = false;
                CustomNavigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: w * .07,
                color: ColorsList.iconColor,
              ),
            ),
            SizedBox(width: w * .02),
            CustomText(
              text: "Driver Agreement",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFonts.textPoppins(
                  context,
                  "Please review and upload the driver agreement to activate your account.",
                  w * 0.031,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                  maxLines: 2,
                )
                .animate()
                .fade(duration: 820.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
            CustomDocumentUploader(
              width: w,
              height: w * .4,
              borderRadius: 5,
              // onUploadPressed: () {
              //   // Handle file upload logic here, e.g., show file picker.
              // },
              uploadText: 'Upload',
              borderColor: AppColors.black,
              uploaderKey: 'Driver Agreement',
            ),
            AppFonts.textPoppins(
                  context,
                  "The agreement has been sent to your registered email. Kindly download it and upload here.",
                  w * 0.025,
                  FontWeight.w500,
                  AppColors.mediumGray,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                  maxLines: 2,
                )
                .animate()
                .fade(duration: 820.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
            SizedBox(height: w * .02),
            Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    //checkBox
                    Obx(
                      () => Checkbox(
                        value: loginController.isCheckedAgreement.value,
                        activeColor: AppColors.primaryRed,
                        visualDensity: VisualDensity.compact,

                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (value) {
                          loginController.isCheckedAgreement.value = value!;
                        },
                      ),
                    ),

                    //text
                    AppFonts.textPoppins(
                      context,
                      "I have read and agree to the Driver Agreement.",
                      w * 0.032,
                      FontWeight.w500,
                      AppColors.black,
                      TextAlign.left,
                      TextOverflow.ellipsis,
                      maxLines: 2,
                    ),

                    //text
                  ],
                )
                .animate()
                .fade(duration: 1300.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
            Spacer(),
            Obx(
              () =>
                  AppButtons.solid(
                        context: context,
                        text: "Submit",
                        onClicked: () {
                          //login function
                          // CustomNavigator.push(
                          //   context,
                          //   EnterOtpScreen(),
                          //   transition: TransitionType.fade,
                          // );
                        },
                        textColor: loginController.isCheckedAgreement.value
                            ? AppColors.white
                            : AppColors.mediumGray,
                        backgroundColor:
                            loginController.isCheckedAgreement.value
                            ? AppColors.primaryRed
                            : AppColors.lightGray,
                        isFullWidth: true,
                        fontSize: w * 0.045,
                        height: w * 0.140,
                        radius: 12.0,
                      )
                      .animate()
                      .fade(duration: 1600.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
            ),
            SizedBox(height: w * .1),
          ],
        ),
      ),
    );
  }
}
