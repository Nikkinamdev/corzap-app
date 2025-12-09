import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/form_field.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';

class AddUpi extends StatefulWidget {
  const AddUpi({super.key});

  @override
  State<AddUpi> createState() => _AddUpiState();
}

class _AddUpiState extends State<AddUpi> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsList.scaffoldColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
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
              text: "Add UPI",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .03, vertical: w * .04),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppFonts.textPoppins(
              context,
              "UPI ID",
              w * 0.046,
              FontWeight.w600,
              AppColors.black,
              TextAlign.center,
              TextOverflow.ellipsis,
            ),
            Padding(
              padding: EdgeInsets.only(top: w * .03, bottom: w * .02),
              child: AppFormFields.custTextFormOther(
                context: context,
                hintText: "Example: abcdef@phonepe",

                controller: textEditingController,
                keyboardType: TextInputType.text,
              ),
            ),
            Container(
              width: w,
              color: Color.fromRGBO(240, 247, 255, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * .02,
                  vertical: w * .02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImages.images(
                      "assets/icons/addupiIcon1.png",
                      w * .06,
                      w * .06,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * .015),
                      child: SizedBox(
                        width: w * .8,
                        //  color: Colors.amber,
                        child: AppFonts.textPoppins(
                          context,
                          "Please enter the UPI details carefully and don’t worry, it is 100% safe!",
                          w * 0.026,
                          FontWeight.w500,
                          ColorsList.linksTextColor,
                          TextAlign.start,
                          TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            AppButtons.solid(
              context: context,
              text: "Submit",
              onClicked: () {
                // CustomNavigator.push(
                //   context,
                //   MoneyTransferScreen(),
                //   transition: TransitionType.fade,
                // );
              },
              isFullWidth: true,
              backgroundColor: AppColors.lightGray,
              textColor: AppColors.mediumGray,
              fontSize: w * .045,
              height: w * .140,
              radius: 12.0,
            ),
            SizedBox(height: w * .1),
          ],
        ),
      ),
    );
  }
}
