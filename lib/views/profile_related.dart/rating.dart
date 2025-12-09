import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  String imagePath = "";
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsList.scaffoldColor,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        titleSpacing: w * .035,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                CustomNavigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: w * .07,
                color: AppColors.black,
              ),
            ),
            SizedBox(width: w * .02),
            CustomText(
              text: "Rating",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
            Spacer(),
            // Buttons(
            //   buttonWidth: w * .15,
            //   buttonHeight: w * .07,
            //   borderRadius: w * .05,
            //   buttonColor: Colors.grey.shade200,

            //   // borderColor: ColorsList.mainBlurLightColor,
            //   onTap: () {
            //     //? navigation bottom sheet
            //     CustomNavigation.push(context, ReviewRating());
            //   },
            //   buttonText: Padding(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: w * .005,
            //       vertical: w * .01,
            //     ),
            //     child: CustomText(
            //       text: "Skip", // 1,2,3,4
            //       textColor: ColorsList.titleTextColor,
            //       textFontSize: w * .03,
            //       textFontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .03, vertical: w * .03),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),

                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 0.5,
                    color: Colors.grey.shade200,
                  ),
                ],
                color: ColorsList.scaffoldColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * .02,
                  vertical: w * .02,
                ),
                child: Column(
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        CircleAvatar(
                          radius: w * .07,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage:
                              imagePath != null && imagePath.isNotEmpty
                              ? AssetImage(imagePath) //  NetworkImage(imageUrl)
                              : null,
                          child: (imagePath == null || imagePath.isEmpty)
                              ? Icon(
                                  Icons.person,
                                  size: w * .08,
                                  color: Colors.grey.shade700,
                                )
                              : null,
                        ),
                        SizedBox(width: w * .02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Amaan Shaikh", // 1,2,3,4
                              textColor: ColorsList.titleTextColor,
                              textFontSize: w * .046,
                              textFontWeight: FontWeight.w400,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorsList.dividerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * .01,
                                  vertical: w * .002,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "5.0", // 1,2,3,4
                                      textColor: ColorsList.titleTextColor,
                                      textFontSize: w * .025,
                                      textFontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(width: w * .005),
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                      size: w * .03,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: w * .01),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: w * .03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: w * .125,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: w * .03),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(8, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: w * .02),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsList.scaffoldOffWhiteColor,
                          borderRadius: BorderRadius.circular(w * .02),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * .03,
                            vertical: w * .02,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: w * .05,
                                    backgroundColor: Colors.grey.shade300,
                                    backgroundImage:
                                        imagePath != null &&
                                            imagePath.isNotEmpty
                                        ? AssetImage(
                                            imagePath,
                                          ) //  NetworkImage(imageUrl)
                                        : null,
                                    child:
                                        (imagePath == null || imagePath.isEmpty)
                                        ? Icon(
                                            Icons.person,
                                            size: w * .065,
                                            color: Colors.grey.shade700,
                                          )
                                        : null,
                                  ),
                                  SizedBox(width: w * .02),
                                  SizedBox(
                                    width: w * .47,
                                    //  color: Colors.amber,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: "Jai Shaikh ", // 1,2,3,4
                                          textColor: ColorsList.titleTextColor,
                                          textFontSize: w * .042,
                                          textFontWeight: FontWeight.w400,
                                        ),
                                        CustomText(
                                          text:
                                              "Driver was very polite and helpful",
                                          textColor:
                                              ColorsList.subtitleTextColor,
                                          textFontSize: w * .029,
                                          textFontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: w * .01),
                                  SizedBox(
                                    width: w * .28,
                                    // color: Colors.red,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(5, (index) {
                                            return Icon(
                                              Icons.star_rate_rounded,
                                              color: Colors.amber,
                                              size: w * .052,
                                            );
                                          }),
                                        ),
                                        CustomText(
                                          text: "Excellent ", // 1,2,3,4
                                          textColor:
                                              ColorsList.greenButtonColor,
                                          textFontSize: w * .029,
                                          textFontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
