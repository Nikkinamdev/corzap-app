import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:flutter/material.dart';

class Details {
  //? about rider============================
  Widget riderDetails(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: w * .02),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // CricleImage().circleImage(
            //   context,
            //   "assets/images/profileImage.png",
            //   circleSize: w * .06,
            // ),
            SizedBox(width: w * .03),
            SizedBox(
              width: w * .35,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Amaan Shaikh",
                    textColor: ColorsList.titleTextColor,
                    textFontSize: w * .04,
                    textFontWeight: FontWeight.w400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.amber,
                        size: w * .04,
                      ),
                      CustomText(
                        text: "4.5",
                        textColor: ColorsList.subtitleTextColor,
                        textFontSize: w * .03,
                        textFontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: w * .05),
            SizedBox(
              width: w * .28,
              //color: Colors.red,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * .005,
                  vertical: w * .005,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // CustomImages.images(
                        //   "assets/icons/fulldateIcon.png",
                        //   w * .045,
                        //   w * .045,
                        // ),
                        SizedBox(width: w * .02),
                        CustomText(
                          text: "12/09/2025",
                          textColor: ColorsList.subtitleTextColor,
                          textFontSize: w * .03,
                          textFontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // CustomImages.images(
                        //   "assets/icons/roundTrip.png",
                        //   w * .04,
                        //   w * .04,
                        // ),
                        SizedBox(width: w * .02),
                        CustomText(
                          text: "Round Trip",
                          textColor: ColorsList.subtitleTextColor,
                          textFontSize: w * .035,
                          textFontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //? details about locations and also cost.....
  Widget rideLocations(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //? pickUp location history
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImages.images("assets/icons/greenDot.png", w * .04, w * .04),
            SizedBox(width: w * .04),
            Expanded(
              child: CustomText(
                text: "C95F+J2M, Manikonda Jagir, Hyderabad, Telangana 500089",
                textColor: ColorsList.titleTextColor,
                textFontSize: w * .03,
                textFontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: w * .03),
        //? drop location history
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImages.images("assets/icons/redDot.png", w * .04, w * .04),
            SizedBox(width: w * .04),
            Expanded(
              child: CustomText(
                text: "C95F+J2M, Manikonda Jagir, Hyderabad, Telangana 500089",
                textColor: ColorsList.titleTextColor,
                textFontSize: w * .03,
                textFontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  //? ride history=> cost---distance ---time
  Widget rideCostDetails(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // List cardDetailsIconList = [
    //   "assets/icons/clockIcon.png",
    //   "assets/icons/totalCost.png",
    //   "assets/icons/routing.png",
    // ];
    // List detailsList = ["05:03 Pm", "12/09/2025", "₹85"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomImages.images(
          "assets/icons/clockIcon.png",
          //  "assets/icons/totalCost.png",
          w * .045,
          w * .045,
        ),
        SizedBox(width: w * .02),
        CustomText(
          text: "05:03 Pm",
          textColor: ColorsList.titleTextColor,
          textFontSize: w * .035,
          textFontWeight: FontWeight.w400,
        ),

        SizedBox(width: w * .02),
        CircleAvatar(radius: 2, backgroundColor: ColorsList.subtitleTextColor),
        CustomText(
          text: " 12/09/2025",
          textColor: ColorsList.titleTextColor,
          textFontSize: w * .035,
          textFontWeight: FontWeight.w400,
        ),
        Spacer(),
        // CustomImages.images(
        //   "assets/icons/clockIcon.png",
        //   //  "assets/icons/totalCost.png",
        //   w * .045,
        //   w * .045,
        // ),
        SizedBox(width: w * .02),
        CustomText(
          text: "₹250",
          textColor: AppColors.green,
          textFontSize: w * .035,
          textFontWeight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget invoice(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    List changesName = ["Ride Charge", "Booking Fees ", "Discount"];
    List chargesAmount = ["15.36", "42.00", "-29.00"];
    return Container(
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
        children: [
          SizedBox(height: w * .04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * .04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Payment Detail",
                  textColor: ColorsList.titleTextColor,
                  textFontSize: w * .04,
                  textFontWeight: FontWeight.w500,
                ),
                SizedBox(),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * .04,
              vertical: w * .01,
            ),
            child: Column(
              children: List.generate(3, (index) {
                String amount = chargesAmount[index];
                bool isNegative = amount.startsWith("-");

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: w * .005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: changesName[index],
                        textColor: ColorsList.titleTextColor,
                        textFontSize: w * .036,
                        textFontWeight: FontWeight.w400,
                      ),
                      Row(
                        children: [
                          if (isNegative)
                            CustomText(
                              text: "-",
                              textColor: ColorsList.titleTextColor,
                              textFontSize: w * .036,
                              textFontWeight: FontWeight.w400,
                            ),
                          Icon(
                            Icons.currency_rupee,
                            size: w * .036,
                            color: ColorsList.titleTextColor,
                          ),
                          CustomText(
                            text: isNegative ? amount.substring(1) : amount,
                            textColor: ColorsList.titleTextColor,
                            textFontSize: w * .036,
                            textFontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * .04,
              vertical: w * .01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Total fare ",
                  textColor: ColorsList.titleTextColor,
                  textFontSize: w * .04,
                  textFontWeight: FontWeight.w500,
                ),
                // CustomText(
                //   text: "74",
                //   textColor: ColorsList.titleTextColor,
                //   textFontSize: w * .04,
                //   textFontWeight: FontWeight.w500,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.currency_rupee,
                      size: w * .04,
                      color: ColorsList.titleTextColor,
                    ),
                    CustomText(
                      text: "74.00",
                      textColor: ColorsList.titleTextColor,
                      textFontSize: w * .04,
                      textFontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: w * .02),
        ],
      ),
    );
  }
}
