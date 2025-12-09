import 'package:corezap_driver/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceTextField extends StatefulWidget {
  bool border = true;
  Color textColor;
  FontWeight? fontWeight;
  TextEditingController?controller;
  BalanceTextField({
    super.key,
    required this.border,
    required this.textColor,
    required this.controller,
    this.fontWeight,
  });

  @override
  State<BalanceTextField> createState() => _BalanceTextFieldState();
}

class _BalanceTextFieldState extends State<BalanceTextField> {
  final TextEditingController _controller = TextEditingController(text: "₹");

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: w * 0.1),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: widget.border
            ? Border(bottom: BorderSide(color: AppColors.mediumGray))
            : null,
      ),
      padding: EdgeInsets.symmetric(vertical: w * .02),
      child: TextField(
        controller: widget.controller,
        textAlign: TextAlign.center,
        style: GoogleFonts.rubik(
          fontSize: w * .07,
          fontWeight: widget.fontWeight ?? FontWeight.w400,
          color: widget.textColor,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          _RupeeInputFormatter(maxAmount: 50000),
        ],
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}

class _RupeeInputFormatter extends TextInputFormatter {
  final int maxAmount;
  _RupeeInputFormatter({required this.maxAmount});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove ₹ symbol
    String newText = newValue.text.replaceAll("₹", "");

    // Handle empty input
    if (newText.isEmpty) {
      return const TextEditingValue(text: "₹");
    }

    // Parse numeric value safely
    int? amount = int.tryParse(newText);
    if (amount == null) return oldValue;

    if (amount > maxAmount) {
      // Keep old value (don't allow change)
      return oldValue;
    }

    final updatedText = "₹$amount";
    return TextEditingValue(
      text: updatedText,
      selection: TextSelection.collapsed(offset: updatedText.length),
    );
  }
}
