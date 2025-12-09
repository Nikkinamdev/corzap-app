import 'package:corezap_driver/apis/bank_account_apis.dart';
import 'package:corezap_driver/session/session_manager.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/utilities/text_fields.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/add_bank.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/add_upi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../apis/auth.dart';

class MoneyTransferScreen extends StatefulWidget {
  const MoneyTransferScreen({super.key});

  @override
  State<MoneyTransferScreen> createState() => _MoneyTransferScreenState();
}

class _MoneyTransferScreenState extends State<MoneyTransferScreen> {
  @override
  BankDetails BankDetailController = Get.find<BankDetails>();

  Future? bankFuture;
  BankDetails GetBankAccount = Get.put(BankDetails());
  TextEditingController amountController = TextEditingController();

  Widget build(BuildContext context) {
    bankFuture ??= GetBankAccount.getbankAccount(
      id: SessionManager.getDriverId().toString(),
    );
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
              text: "Money Transfer",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                    width: w,
                    height: w * 0.40,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(w * 0.03),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: w * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Icon(
                          //       Icons.currency_rupee,
                          //       color: AppColors.green,
                          //       size: w * .063,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //     AppFonts.textPoppins(
                          //       context,
                          //       "100.0",
                          //       w * 0.08,
                          //       FontWeight.bold,
                          //       AppColors.green,
                          //       TextAlign.center,
                          //       TextOverflow.visible,
                          //     ),
                          //   ],
                          // ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: w * .03),
                            child: BalanceTextField(
                              border: false,
                              textColor: AppColors.green,
                              fontWeight: FontWeight.w600,
                              controller: amountController,
                            ),
                          ),
                          AppFonts.textPoppins(
                            context,
                            "Total amount to be transferred",
                            w * 0.03,
                            FontWeight.w500,
                            AppColors.black,
                            TextAlign.center,
                            TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                  .animate()
                  .fade(duration: 820.ms, curve: Curves.easeInOut)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                  ),
              Padding(
                padding: EdgeInsets.only(top: w * .03, bottom: w * .1),
                child: AppFonts.textPoppins(
                  context,
                  "A service fee of 10% is deducted from each completed ride to cover platform charges.",
                  w * 0.032,
                  FontWeight.w500,
                  AppColors.mediumGray,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              AppFonts.textPoppins(
                context,
                "Deposit to",
                w * 0.043,
                FontWeight.w600,
                AppColors.black,
                TextAlign.left,
                TextOverflow.ellipsis,
              ),

              FutureBuilder(
                future: bankFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error loading bank details"));
                  }

                  // data loaded successfully
                  return Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: BankDetailController.bankList.length,
                      itemBuilder: (context, index) {
                        final bank = BankDetailController.bankList[index];

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: w * .02),
                          child: Container(
                            width: w,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(w * 0.03),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: w * .04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// --- Header Row ---
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * .04,
                                    ),
                                    child: Row(
                                      children: [
                                        CustomImages.images(
                                          "assets/icons/addBank1.png",
                                          w * .05,
                                          w * .05,
                                        ),
                                        SizedBox(width: w * .02),
                                        AppFonts.textPoppins(
                                          context,
                                          "Bank Details",
                                          w * 0.04,
                                          FontWeight.w400,
                                          AppColors.black,
                                          TextAlign.left,
                                          TextOverflow.ellipsis,
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            CustomNavigator.push(
                                              context,
                                              AddBank(),
                                              transition:
                                                  TransitionType.slideLeft,
                                            );
                                          },
                                          child: AppFonts.textPoppins(
                                            context,
                                            "ADD NEW",
                                            w * 0.03,
                                            FontWeight.w500,
                                            ColorsList.linksTextColor,
                                            TextAlign.left,
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: w * .02),

                                  /// --- Bank Details ---
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * .07,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppFonts.textPoppins(
                                          context,
                                          bank.accountHolderName ?? "",
                                          w * 0.032,
                                          FontWeight.w500,
                                          AppColors.black,
                                          TextAlign.left,
                                          TextOverflow.ellipsis,
                                        ),
                                        AppFonts.textPoppins(
                                          context,
                                          "IFSC: ${bank.ifscCode ?? ""}",
                                          w * 0.032,
                                          FontWeight.w500,
                                          AppColors.black,
                                          TextAlign.left,
                                          TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppFonts.textPoppins(
                                              context,
                                              bank.accountNumber ?? "",
                                              w * 0.032,
                                              FontWeight.w500,
                                              AppColors.black,
                                              TextAlign.left,
                                              TextOverflow.ellipsis,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await BankDetailController.deletebankAccount(
                                                  id: bank.sId.toString(),
                                                );

                                                // 🔥 Refresh FutureBuilder
                                                bankFuture =
                                                    GetBankAccount.getbankAccount(
                                                      id: SessionManager.getDriverId()
                                                          .toString(),
                                                    );

                                                // 🔥 Rebuild screen
                                                setState(() {});
                                              },
                                              child: AppFonts.textPoppins(
                                                context,
                                                "Delete",
                                                w * 0.04,
                                                FontWeight.w500,
                                                AppColors.primaryRed,
                                                TextAlign.left,
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
                },
              ),

              SizedBox(height: 0.05),
              // upi details
              Container(
                width: w,
                //  height: w * 0.36,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(w * 0.03),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: w * .04),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * .04,
                          //  vertical: w * .04,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImages.images(
                              "assets/icons/addUpi1.png",
                              w * .05,
                              w * .05,
                            ),
                            SizedBox(width: w * .02),
                            AppFonts.textPoppins(
                              context,
                              "UPI Details",
                              w * 0.04,
                              FontWeight.w400,
                              AppColors.black,
                              TextAlign.left,
                              TextOverflow.ellipsis,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                CustomNavigator.push(
                                  context,
                                  AddUpi(),
                                  transition: TransitionType.slideLeft,
                                );
                              },
                              child: AppFonts.textPoppins(
                                context,
                                "ADD NEW",
                                w * 0.03,
                                FontWeight.w500,
                                ColorsList.linksTextColor,
                                TextAlign.left,
                                TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: w * .02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * .07),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppFonts.textPoppins(
                              context,
                              "Ayaan Malviya",
                              w * 0.032,
                              FontWeight.w500,
                              AppColors.black,
                              TextAlign.left,
                              TextOverflow.ellipsis,
                            ),
                            AppFonts.textPoppins(
                              context,
                              "872000416@paytm",
                              w * 0.032,
                              FontWeight.w500,
                              AppColors.black,
                              TextAlign.left,
                              TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: w * .3),
              AppButtons.solid(
                context: context,
                text: "Transfer",
                onClicked: () {
                  // CustomNavigator.push(
                  //   context,
                  //   MoneyTransferScreen(),
                  //   transition: TransitionType.fade,
                  // );
                },
                isFullWidth: true,
                backgroundColor: AppColors.primaryRed,
                textColor: AppColors.white,
                fontSize: w * .045,
                height: w * .140,
                radius: 12.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
