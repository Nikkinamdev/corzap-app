import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  /// Inter Font
  static Widget textRubik(
    BuildContext context,
    String item,
    double size,
    FontWeight weight,
    Color color,
    TextAlign textAlign,
    TextOverflow overflow, {
    int maxLines = 1,
  }) {
    return Text(
      item,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.rubik(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  /// Poppins Font
  static Widget textPoppins(
    BuildContext context,
    String item,
    double size,
    FontWeight weight,
    Color color,
    TextAlign textAlign,
    TextOverflow overflow, {
    int maxLines = 1,
  }) {
    return Text(
      item,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  /// Roboto Font
  static Widget textRoboto(
    BuildContext context,
    String item,
    double size,
    FontWeight weight,
    Color color,
    TextAlign textAlign,
    TextOverflow overflow, {
    int maxLines = 1,
  }) {
    return Text(
      item,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.roboto(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }

  /// Montserrat Font
  static Widget textMontserrat(
    BuildContext context,
    String item,
    double size,
    FontWeight weight,
    Color color,
    TextAlign textAlign,
    TextOverflow overflow, {
    int maxLines = 1,
  }) {
    return Text(
      item,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.montserrat(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
