import 'package:corezap_driver/apis/bank_account_apis.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/bottom_Sheets/custom_bottom_sheets.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_cupon_card.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/popups/pop_ups.dart';
import 'package:corezap_driver/utilities/text_fields.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/money_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../apis/auth.dart';
import '../../../apis/wallet.dart';
import '../../../payment_gateway/rezorpay.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  BankDetails GetBankAccount = Get.put(BankDetails());
  Auth id = Get.find<Auth>();
  WalletApiController addWallet = Get.put(WalletApiController());
  final razorpayController = Get.put(RazorpayController());
  TextEditingController amountController = TextEditingController();
  Widget build(BuildContext context) {
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
              text: "Add Money",
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
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // keyboard height
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: CustomImages.images(
                  "assets/images/addmoney1.png",
                  w * .55,
                  w * .55,
                ),
              ),
              SizedBox(height: w * .06),
              Center(
                child: SizedBox(
                  width: w * .8,
                  child: AppFonts.textPoppins(
                    context,
                    "Maintain minimum balance to continue accepting rides.",
                    w * 0.037,
                    FontWeight.w500,
                    AppColors.black,
                    TextAlign.center,
                    TextOverflow.visible,
                    maxLines: 2,
                  ),
                ),
              ),
              //? add money textfield-
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .03),
                child: BalanceTextField(
                  border: true,
                  textColor: AppColors.black, controller: amountController,
                ),
              ),
              SizedBox(height: w * .02),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: w * .04,
                  horizontal: w * .03,
                ),
                child: AppFonts.textPoppins(
                  context,
                  "Coupon",
                  w * 0.045,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.start,
                  TextOverflow.visible,
                ),
              ),
              //? coupan offer's
              InkWell(
                onTap: () {
                  PopUps().coupanAdd(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * .03),
                  child: NotchedCard(
                    width: w,
                    height: w * .3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImages.images(
                          "assets/icons/Logo.png",
                          w * .25,
                          w * .25,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * .03,
                            vertical: w * .045,
                          ),
                          child: VerticalDottedDivider(
                            width: w * .01,
                            height: w * .4,
                            strokeWidth: 1,
                            color: AppColors.mediumGray,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: w * .05),
                            AppFonts.textPoppins(
                              context,
                              "50% off up to ₹100",
                              w * 0.04,
                              FontWeight.w600,
                              AppColors.black,
                              TextAlign.start,
                              TextOverflow.ellipsis,
                            ),
                            SizedBox(height: w * .01),
                            SizedBox(
                              width: w * .46,
                              // color: Colors.amber,
                              child: AppFonts.textPoppins(
                                context,
                                "Add ₹100 to your wallet, pay only ₹50 with this coupon.",
                                w * 0.022,
                                FontWeight.w500,
                                AppColors.mediumGray,
                                TextAlign.start,
                                TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(height: w * .01),
                            AppFonts.textPoppins(
                              context,
                              "Works only on ₹100 and above",
                              w * 0.025,
                              FontWeight.w500,
                              AppColors.primaryRed,
                              TextAlign.start,
                              TextOverflow.ellipsis,
                            ),
                            SizedBox(height: w * .01),
                            AppFonts.textPoppins(
                              context,
                              "Valid until 03 October 2025",
                              w * 0.02,
                              FontWeight.w500,
                              AppColors.mediumGray,
                              TextAlign.start,
                              TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: w * .3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .03),
                child: AppButtons.solid(
                  context: context,
                  text: "+ Add Money",
                  onClicked: () async {
                    print("amounttttttttttt${amountController.text}");
                    await addWallet.addWallet(amountController.text);
                    if (addWallet.walletStatus == true) {
                      razorpayController.openCheckout(
                        amount: amountController.text,
                        orderId: addWallet.orderId.value,
                      );
                    }
                  },
                  isFullWidth: true,

                  // ⭐ Change color based on input text
                  backgroundColor: amountController.text.isNotEmpty
                      ? AppColors.primaryRed          // when not empty
                      : AppColors.lightGray, // when empty

                  textColor: amountController.text.isNotEmpty
                      ? Colors.white        // better contrast
                      : AppColors.mediumGray,

                  fontSize: w * .045,
                  height: w * .140,
                  radius: 12.0,
                ),
              )
,
              SizedBox(height: w * .02),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: w * .03),
              //   child: AppButtons.solid(isLoading: GetBankAccount.loading.value,
              //     context: context,
              //     text: "money transfer screen",
              //     onClicked: () async{
              //      // await GetBankAccount.getbankAccount(id: id.driverId.value);
              //
              //     },
              //     isFullWidth: true,
              //     backgroundColor: AppColors.primaryRed,
              //     textColor: AppColors.white,
              //     fontSize: w * .045,
              //     height: w * .140,
              //     radius: 12.0,
              //   ),
              // ),
              SizedBox(height: w * .1),
            ],
          ),
        ),
      ),
    );
  }
}
