import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFormFields {
  static Widget custTextFormOther({
    required BuildContext context,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    VoidCallback? onClicked,
    int maxLines = 1,
    int? maxLength,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool autofocus = false,
    bool readOnly = false,
    FocusNode? focusNode,
    double? borderRadius,
    Color? borderColor,
    Color? hintColor,
    Color? textColor,
    FontWeight fontWeight = FontWeight.w500,
    double? fontSize,
    bool filled = false,
    Color? fillColor,
    double? width,
    double? height,
  }) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        controller: controller,
        cursorHeight: h * .025,
        cursorColor: Colors.grey,
        focusNode: focusNode,
        readOnly: readOnly,
        validator: validator,
        autofocus: autofocus,
        onTap: onClicked,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        style: GoogleFonts.lexendDeca(
          fontSize: fontSize ?? w * .040,
          fontWeight: fontWeight,
          color: textColor ?? Colors.black87,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: fillColor,
          filled: filled,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * .020,
            vertical: w * .035,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.lexendDeca(
            fontSize: fontSize ?? w * .040,
            fontWeight: fontWeight,
            color: hintColor ?? Colors.grey.shade400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? w * .020),
            borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? w * .020),
            borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? w * .020),
            borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? w * .020),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }
}
