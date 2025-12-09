import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppButtons {
  // solid button
  static Widget solid({
    required BuildContext context,
    required String text,
    required VoidCallback onClicked,
    bool isLoading = false,
    bool isFullWidth = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color backgroundColor = AppColors.primaryRed,
    Color textColor = AppColors.white,
    double height = 48.0,
    double? width,
    double? fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w600,
    double radius = 8.0,
    EdgeInsetsGeometry? padding,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading
              ? backgroundColor.withOpacity(0.3)
              : backgroundColor,
          padding: padding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: isLoading ? null : onClicked,
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    suffixIcon,
                  ],
                ],
              ),
      ),
    );
  }

  // outline button
  static Widget outlined({
    required BuildContext context,
    required String text,
    required VoidCallback onClicked,
    bool isLoading = false,
    bool isFullWidth = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color borderColor = AppColors.primaryRed,
    Color textColor = AppColors.primaryRed,
    Color backgroundColor = Colors.transparent,
    double height = 48.0,
    double? width,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w600,
    double radius = 8.0,
    EdgeInsetsGeometry? padding,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: padding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: borderColor, width: 1),
          ),
        ),
        onPressed: isLoading ? null : onClicked,
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: borderColor,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    suffixIcon,
                  ],
                ],
              ),
      ),
    );
  }
}
