import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';

class LocationInputTextfield extends StatefulWidget {
  final String preffixImage;
  //  final Widget suffixImage;
  final Color? backgroundColor;
  final String? hintText;
  final double? hintFontSize;
  final double? preffixhorizontalPadding;
  final double? preffixverticalPadding;
  // final double? suffixhorizontalPadding;
  // final double? suffixverticalPadding;
  final TextEditingController? address;
  final VoidCallback onPressed;
  final String? additionalImage;

  const LocationInputTextfield({
    super.key,
    this.backgroundColor,
    this.hintText,
    this.additionalImage,
    required this.onPressed,
    this.preffixhorizontalPadding,
    this.preffixverticalPadding,
    // this.suffixhorizontalPadding,
    // this.suffixverticalPadding,
    required this.preffixImage,
    this.hintFontSize,
    // required this.suffixImage,
    this.address,
  });

  @override
  State<LocationInputTextfield> createState() => _LocationInputTextfieldState();
}

class _LocationInputTextfieldState extends State<LocationInputTextfield> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onPressed,

      child: TextFormField(
        controller: widget.address,

        // style: GoogleFonts.poppins(
        //   color: ColorsList.textColor,
        //   fontSize: w * 0.04,
        //   fontWeight: FontWeight.w500,
        // ),
        // readOnly: true,
        cursorColor: ColorsList.textColor,
        cursorWidth: 2.0,
        cursorHeight: w * 0.05,
        readOnly: true,
        decoration: InputDecoration(
          hintText: widget.hintText ?? "",
          hintStyle: GoogleFonts.blinker(
            color: Colors.grey.shade400,
            fontSize: widget.hintFontSize ?? w * .04,
            fontWeight: FontWeight.w400,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w * .03),
            borderSide: BorderSide(
              color: ColorsList.textfieldBorderColorSe,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w * .03),
            borderSide: BorderSide(
              color: ColorsList.textfieldBorderColorSe,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w * .03),
            borderSide: BorderSide(
              color: ColorsList.textfieldBorderColorSe,
              width: 2,
            ),
          ),
          isCollapsed: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: w * .035,
            horizontal: w * .04,
          ),
          filled: true,

          fillColor: widget.backgroundColor ?? ColorsList.scaffoldColor,
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              left: widget.preffixhorizontalPadding ?? w * .02,
              top: widget.preffixverticalPadding ?? w * .04,
              bottom: widget.preffixverticalPadding ?? w * .04,
            ),
            child: Image.asset(
              widget.preffixImage,
              width: w * .05,
              height: w * .05,
            ),
          ),

          // suffixIcon: Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: widget.suffixhorizontalPadding ?? w * .03,
          //     vertical: widget.suffixverticalPadding ?? w * .001,
          //   ),
          //   child: widget.suffixImage,
          // ),
        ),
      ),
    );
  }
}
