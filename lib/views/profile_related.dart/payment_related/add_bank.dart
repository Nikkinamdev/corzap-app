import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/form_field.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/money_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../../../apis/auth.dart';
import '../../../apis/bank_account_apis.dart';
import '../../../session/session_manager.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  Controllers controllers = Get.find<Controllers>();
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController =
      TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  BankDetails adbankDetailController = Get.put(BankDetails());


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllers.addBankAccoundButtonController.value = false;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text.isNotEmpty
        ? controllers.addBankAccoundButtonController.value = true
        : false;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsList.scaffoldColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
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
            SizedBox(width: w * .035),
            CustomText(
              text: "Add a Bank Account",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .03, vertical: w * .04),
          child: Form(
            key: _formKey,
            onChanged: () {
              // Validation check for enabling button
              if (_formKey.currentState!.validate()) {
                controllers.addBankAccoundButtonController.value = true;
              } else {
                controllers.addBankAccoundButtonController.value = false;
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppFonts.textPoppins(
                  context,
                  "Bank Account Details",
                  w * 0.046,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .04),
                AppFonts.textPoppins(
                  context,
                  "Account Holder Name",
                  w * 0.035,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "Monika",
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Account Holder Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: w * .04),
                AppFonts.textPoppins(
                  context,
                  "Bank Account Number",
                  w * 0.035,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "Enter here",
                  controller: accountNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter account number";
                    }
                    if (value.length < 8) {
                      return "Invalid account number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: w * .04),
                AppFonts.textPoppins(
                  context,
                  "Confirm Account Number",
                  w * 0.035,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "Enter here",
                  controller: confirmAccountNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Re-enter account number";
                    }
                    if (value != accountNumberController.text) {
                      return "Account numbers do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: w * .04),
                AppFonts.textPoppins(
                  context,
                  "IFSC Code",
                  w * 0.035,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "Enter here",
                  controller: ifscController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "IFSC Code is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: w * .04),
                AppFonts.textPoppins(
                  context,
                  "Bank Name",
                  w * 0.035,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "Enter here",
                  controller: bankNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bank Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: w * .4),
                Obx(
                  () => AppButtons.solid(
                    context: context,
                    text: "Submit",
                    onClicked: () {
                      if (_formKey.currentState!.validate()) {
                        // All fields are valid
                        adbankDetailController.addbankDetail(
                          bankName: bankNameController.text,
                          accountNumber: accountNumberController.text,
                          id: SessionManager.getDriverId().toString(),
                          ifscCode: ifscController.text,
                          accountHolderName: nameController.text,
                        );
                        if (adbankDetailController.bankdetailMessage.value ==
                            "Bank account created successfully") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: CustomText(
                                text: "Bank account created successfully",
                                textColor: Colors.white,
                              ),
                            ),
                          );
                          CustomNavigator.pushReplacement(
                            context,
                            MoneyTransferScreen(),
                            transition: TransitionType.slideRight,
                          );
                        } else if (adbankDetailController
                                .bankdetailMessage
                                .value ==
                            "Bank account already exists with this account number") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: CustomText(
                                text:
                                    "Bank account already exists with this account number",
                                textColor: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: CustomText(
                                text: "Something went wrong",
                                textColor: Colors.white,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    isFullWidth: true,
                    backgroundColor: AppColors.primaryRed,
                    textColor: AppColors.white,
                    fontSize: w * .045,
                    height: w * .140,
                    radius: 12.0,
                    isLoading: adbankDetailController.loading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
