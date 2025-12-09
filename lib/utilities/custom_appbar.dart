import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  Widget? textWidget;
  CustomAppbar({super.key, this.textWidget});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return AppBar(
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
          textWidget!,
        ],
      ),
    );
  }
}
