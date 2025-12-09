import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/add_bank.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/add_money.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/add_upi.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/transactions.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../apis/wallet.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  WalletApiController getWallet = Get.put(WalletApiController());
  // Controllers checkBoxController = Get.find<Controllers>();
  // final WalletButtonController walletButtonController = Get.put(
  //   WalletButtonController(),
  // );
  // final List uplAppIconList = [
  //   "assets/icons/phonepayIcon.png",
  //   "assets/icons/googlepayIcon.png",
  //   "assets/icons/paytmIcon.png",
  //   "assets/icons/amazonpayIcon.png",
  // ];
  final List paymentAppNameList = [
    "PhonePe UPI",
    "Google Pay",
    "Paytm UPI",
    "Amazon Pay UPI",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWallet.getWallet();
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
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
            SizedBox(width: w * .02),
            CustomText(
              text: "Payment",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFonts.textPoppins(
                    context,
                    "Wallets",
                    w * 0.03,
                    FontWeight.w600,
                    AppColors.black,
                    TextAlign.left,
                    TextOverflow.visible,
                  )
                  .animate()
                  .fade(duration: 900.ms, curve: Curves.easeInOut)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                  ),
              SizedBox(height: w * .02),
              //wallet container
              InkWell(
                onTap: () {
                  CustomNavigator.push(
                    context,
                    Wallet(),
                    transition: TransitionType.slideLeft,
                  );
                },
                child: Container(
                  width: double.infinity,
                  // height: w * .28,
                  color: ColorsList.scaffoldColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * .04,
                      vertical: w * .04,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            // horizontal: w * .04,
                            vertical: w * .005,
                          ),
                          child: CustomImages.images(
                            "assets/icons/wallet2.png",
                            w * .04,
                            w * .04,
                          ),
                        ),
                        SizedBox(width: w * .02),
                        SizedBox(
                          width: w * .75,
                          // color: Colors.amber,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFonts.textPoppins(
                                    context,
                                    "Wallet",
                                    w * 0.035,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                  )
                                  .animate()
                                  .fade(
                                    duration: 900.ms,
                                    curve: Curves.easeInOut,
                                  )
                                  .scale(
                                    begin: const Offset(0.95, 0.95),
                                    end: const Offset(1, 1),
                                  ),
                              // CustomText(
                              //   text: "Balance: ₹100.0",
                              //   textColor: ColorsList.greenButtonColor,
                              //   textFontSize: w * .028,
                              //   textFontWeight: FontWeight.w400,
                              // ),
                              AppFonts.textPoppins(
                                    context,
                                    "Balance: ₹${getWallet.walletBalance.value}",
                                    w * 0.03,
                                    FontWeight.w500,
                                    AppColors.green,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                  )
                                  .animate()
                                  .fade(
                                    duration: 900.ms,
                                    curve: Curves.easeInOut,
                                  )
                                  .scale(
                                    begin: const Offset(0.95, 0.95),
                                    end: const Offset(1, 1),
                                  ),
                              SizedBox(height: w * .02),
                              Row(
                                children: [
                                  Spacer(),
                                  // Obx(
                                  //   () => Buttons(
                                  //     buttonWidth: w * .3,
                                  //     buttonHeight: w * .07,
                                  //     borderRadius: w * .05,
                                  //     buttonColor:
                                  //         walletButtonController
                                  //                 .selectedIndex
                                  //                 .value ==
                                  //             0
                                  //         ? ColorsList
                                  //               .mainButtonColor // Active color
                                  //         : ColorsList
                                  //               .scaffoldColor, // Default color
                                  //     borderColor: ColorsList.mainBlurLightColor,
                                  //     onTap: () async {
                                  //       walletButtonController.selectButton(0);
                                  //       await Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (_) => AddMoneyScreen(),
                                  //         ),
                                  //       );
                                  //       walletButtonController.resetSelection();
                                  //     },

                                  //     buttonText: Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //         horizontal: w * .01,
                                  //         vertical: w * .01,
                                  //       ),
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Container(
                                  //             width: w * .05,
                                  //             height: w * .05,
                                  //             decoration: BoxDecoration(
                                  //               borderRadius:
                                  //                   BorderRadius.circular(20),
                                  //               color:
                                  //                   ColorsList.addBackgroundColor,
                                  //             ),
                                  //             child: Icon(
                                  //               Icons.add,
                                  //               color: ColorsList.mainButtonColor,
                                  //               size: w * .04,
                                  //             ),
                                  //           ),
                                  //           SizedBox(width: w * .015),
                                  //           CustomText(
                                  //             text: "Add Money",
                                  //             textColor:
                                  //                 walletButtonController
                                  //                         .selectedIndex
                                  //                         .value ==
                                  //                     0
                                  //                 ? // Active color
                                  //                   ColorsList.scaffoldColor
                                  //                 : ColorsList.mainButtonColor,
                                  //             textFontSize: w * .03,
                                  //             textFontWeight: FontWeight.w400,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  AppButtons.outlined(
                                    context: context,
                                    text: "Add Money",
                                    onClicked: () {
                                      CustomNavigator.push(
                                        context,
                                        AddMoney(),
                                        transition: TransitionType.slideLeft,
                                      );
                                    },
                                    prefixIcon: Container(
                                      width: w * .04,
                                      height: w * .04,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorsList.addBackgroundColor,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: ColorsList.mainButtonColor,
                                        size: w * .04,
                                      ),
                                    ),
                                    isFullWidth: false,
                                    width: w * .3,
                                    height: w * .08,
                                    borderColor: AppColors.primaryRed,
                                    backgroundColor: AppColors.white,
                                    textColor: AppColors.primaryRed,
                                    fontSize: w * .03,
                                    radius: 30,
                                    fontWeight: FontWeight.w500,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * .005,
                                    ),
                                  ),
                                  //-----------------
                                  SizedBox(width: w * .02),
                                  AppButtons.outlined(
                                    context: context,
                                    text: "Transactions",
                                    onClicked: () {
                                      CustomNavigator.push(
                                        context,
                                        Transactions(),
                                        transition: TransitionType.slideLeft,
                                      );
                                    },
                                    prefixIcon: CustomImages.images(
                                      "assets/icons/transButtonIcon.png",
                                      w * .04,
                                      w * .04,
                                    ),
                                    isFullWidth: false,
                                    width: w * .3,
                                    height: w * .08,
                                    borderColor: AppColors.primaryRed,
                                    backgroundColor: AppColors.white,
                                    textColor: AppColors.primaryRed,
                                    fontSize: w * .03,
                                    radius: 30,
                                    fontWeight: FontWeight.w500,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * .005,
                                    ),
                                  ),
                                  // Obx(
                                  //   () => Buttons(
                                  //     buttonWidth: w * .3,
                                  //     buttonHeight: w * .07,
                                  //     borderRadius: w * .05,
                                  //     buttonColor:
                                  //         walletButtonController
                                  //                 .selectedIndex
                                  //                 .value ==
                                  //             1
                                  //         ? ColorsList
                                  //               .mainButtonColor // Active color
                                  //         : ColorsList
                                  //               .scaffoldColor, // Default color
                                  //     borderColor: ColorsList.mainBlurLightColor,
                                  //     onTap: () async {
                                  //       walletButtonController.selectButton(1);

                                  //       await Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (_) =>
                                  //               TransactionsHistoryScreen(),
                                  //         ),
                                  //       );

                                  //       walletButtonController.resetSelection();
                                  //     },
                                  //     buttonText: Padding(
                                  //       padding: EdgeInsets.symmetric(
                                  //         horizontal: w * .005,
                                  //         vertical: w * .01,
                                  //       ),
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           CustomImages.images(
                                  //             "assets/icons/transactionsIcon.png",
                                  //             w * .04,
                                  //             w * .04,
                                  //           ),
                                  //           SizedBox(width: w * .015),
                                  //           CustomText(
                                  //             text: "Transactions",
                                  //             textColor:
                                  //                 walletButtonController
                                  //                         .selectedIndex
                                  //                         .value ==
                                  //                     1
                                  //                 ? // Active color
                                  //                   ColorsList.scaffoldColor
                                  //                 : ColorsList.mainButtonColor,
                                  //             textFontSize: w * .03,
                                  //             textFontWeight: FontWeight.w400,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: w * .02),

              AppFonts.textPoppins(
                    context,
                    "Add your Account",
                    w * 0.03,
                    FontWeight.w500,
                    AppColors.black,
                    TextAlign.left,
                    TextOverflow.visible,
                  )
                  .animate()
                  .fade(duration: 900.ms, curve: Curves.easeInOut)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                  ),
              SizedBox(height: w * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButtons.solid(
                    context: context,
                    text: "Bank",
                    onClicked: () {
                      CustomNavigator.push(
                        context,
                        AddBank(),
                        transition: TransitionType.fade,
                      );
                    },
                    prefixIcon: CustomImages.images(
                      "assets/icons/bank1.png",
                      w * .04,
                      w * .04,
                    ),
                    isFullWidth: false,
                    width: w * .44,
                    // height: w * .0,
                    backgroundColor: AppColors.white,
                    textColor: AppColors.black,
                    fontSize: w * .039,
                    //  radius: 3,
                    fontWeight: FontWeight.w500,
                  ),
                  AppButtons.solid(
                    context: context,
                    text: "UPI Account",
                    onClicked: () {
                      CustomNavigator.push(
                        context,
                        AddUpi(),
                        transition: TransitionType.fade,
                      );
                    },
                    prefixIcon: CustomImages.images(
                      "assets/icons/upi1.png",
                      w * .042,
                      w * .042,
                    ),
                    isFullWidth: false,
                    width: w * .44,
                    //    height: w * .0,
                    backgroundColor: AppColors.white,
                    textColor: AppColors.black,
                    fontSize: w * .039,
                    //radius: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
