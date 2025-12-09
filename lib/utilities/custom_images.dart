import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImages {
  static Widget images(
    String imagePath,
    double width,
    double height, {
    Color? color,
  }) {
    return Image.asset(
      imagePath,
      color: color,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }

  static Widget customCard({
    required BuildContext context,
    Color? backgroundColor,
    double? borderRadius,
    Widget? widget1,
    double? containerWidth,
    double? containerHeight,
    Color? borderColor,
    double? blurRadius,
  }) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: containerWidth ?? w * .4,
      height: containerHeight ?? w * .2,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsList.scaffoldColor,
        borderRadius: BorderRadius.circular(borderRadius ?? w * .02),
        boxShadow: [
          BoxShadow(
            color: borderColor ?? Colors.black12,
            spreadRadius: 1,
            blurRadius: blurRadius ?? 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: widget1,
    );
  }
}
