import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final TextAlign? textalign;
  final int? maxLines;
  final TextOverflow? overflow;
  const CustomText({
    super.key,
    required this.text,
    this.maxLines,
    this.overflow,
    this.textColor,
    this.textFontSize,
    this.textFontWeight,
    this.textalign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textalign ?? TextAlign.start,
      //   overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.rubik(
        fontSize: textFontSize,
        fontWeight: textFontWeight,
        color: textColor,
        //
      ),
    );
  }
}
