import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/profile_related.dart/help_related/F_a_qs.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List imagesPathList = [
    "assets/icons/faq.png",
    "assets/icons/chatSupport.png",
    "assets/icons/callSupport.png",
    "assets/icons/emailSupport.png",
  ];


  List titleList = ["FAQs", "Chat with Support", "Call Support", "Email Us"];

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
            SizedBox(width: w * .02),
            CustomText(
              text: "Help",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .025),
        child: Card(
          elevation: 1,
          color: ColorsList.scaffoldColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(4, (index) {
              return Column(
                children: [
                  index == 0 ? SizedBox(height: w * .02) : SizedBox.shrink(),
                  GestureDetector(
                    onTap: () {
                      index == 0
                          ? CustomNavigator.push(
                              context,
                              FAQs(),
                              transition: TransitionType.slideLeft,
                            )
                          : null;
                    },
                    child: customMenuItemsButton(
                      imagesPathList[index],
                      titleList[index],

                      //? navigate screen=======================
                    ),
                  ),
                  index < 3
                      ? Divider(
                          indent: w * .13,
                          color: ColorsList.textfieldBorderColorSe,
                        )
                      : SizedBox.shrink(),
                  index == 3 ? SizedBox(height: w * .02) : SizedBox.shrink(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  //? method--
  Widget customMenuItemsButton(
    String imagePath,
    String title,
    //  Widget navigateScreen,
  ) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      color: ColorsList.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .02),
        child: Row(
          children: [
            //  Image on left
            CustomImages.images(imagePath, w * .07, w * .07),

            SizedBox(width: w * 0.02),

            //Title
            CustomText(
              text: title,
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .045,
              textFontWeight: FontWeight.w400,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorsList.subtitleTextColor,
              size: w * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
