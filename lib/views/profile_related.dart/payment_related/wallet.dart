import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/profile_related.dart/payment_related/add_money.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'money_transfer_screen.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
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
            SizedBox(width: w * .035),
            CustomText(
              text: "Wallet",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .04),
        child: Column(
          children: [
            Container(
                  width: w,
                  // height: w * 0.40,
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
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: w * .1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.currency_rupee,
                            color: AppColors.green,
                            size: w * .063,
                            fontWeight: FontWeight.bold,
                          ),
                          AppFonts.textPoppins(
                            context,
                            "100.0",
                            w * 0.08,
                            FontWeight.bold,
                            AppColors.green,
                            TextAlign.center,
                            TextOverflow.visible,
                          ),
                        ],
                      ),

                      AppFonts.textPoppins(
                        context,
                        "Your wallet balance",
                        w * 0.03,
                        FontWeight.w500,
                        AppColors.black,
                        TextAlign.center,
                        TextOverflow.visible,
                      ),
                      SizedBox(height: w * .02),
                      Divider(),
                      AppButtons.solid(
                        context: context,
                        text: "Add Money",
                        onClicked: () {
                          CustomNavigator.push(
                            context,
                            AddMoney(),
                            transition: TransitionType.slideLeft,
                          );
                        },
                        prefixIcon: Icon(
                          Icons.add,
                          size: w * .05,
                          color: AppColors.primaryRed,
                        ),
                        isFullWidth: true,
                        backgroundColor: AppColors.white,
                        textColor: AppColors.primaryRed,
                      ),
                    ],
                  ),
                )
                .animate()
                .fade(duration: 820.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
            SizedBox(height: w * .03),
            AppFonts.textPoppins(
              context,
              "Maintain a minimum balance of ₹200 in your wallet to accept rides.",
              w * 0.03,
              FontWeight.w500,
              AppColors.mediumGray,
              TextAlign.left,
              TextOverflow.visible,
              maxLines: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * .12,
                vertical: w * .05,
              ),
              child:
                  InkWell(onTap: (){
                    CustomNavigator.push(
                      context,
                      MoneyTransferScreen(),
                      transition: TransitionType.fade,
                    );
                  },
                    child: Container(
                          width: w,
                          //  height: w * 0.40,
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
                            padding: EdgeInsets.symmetric(vertical: w * .05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomImages.images(
                                  "assets/icons/wallet1.png",
                                  w * .1,
                                  w * .1,
                                ),

                                AppFonts.textPoppins(
                                  context,
                                  "Money Transfer",
                                  w * 0.032,
                                  FontWeight.w600,
                                  AppColors.black,
                                  TextAlign.center,
                                  TextOverflow.visible,
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
                  ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: w * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFonts.textPoppins(
                    context,
                    "Transactions",
                    w * 0.04,
                    FontWeight.w600,
                    AppColors.black,
                    TextAlign.center,
                    TextOverflow.visible,
                  ),
                  AppFonts.textPoppins(
                    context,
                    "See All",
                    w * 0.035,
                    FontWeight.w500,
                    AppColors.mediumGray,
                    TextAlign.center,
                    TextOverflow.visible,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: w * .02,
                      horizontal: w * .005,
                    ),
                    child:
                        Container(
                              width: w,
                              //  height: w * 0.40,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    // spreadRadius: 1,
                                    blurRadius: 1,
                                    // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(w * 0.03),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: w * .025,
                                  horizontal: w * .04,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: w * .055,
                                      backgroundColor:
                                          ColorsList.mainButtonLightColor,
                                      child: Image.asset(
                                        "assets/icons/transArrowUp.png",
                                        width: w * .055,
                                      ),
                                    ),
                                    SizedBox(width: w * .02),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppFonts.textPoppins(
                                          context,
                                          "Paid to Aditya",
                                          w * 0.037,
                                          FontWeight.w600,
                                          AppColors.black,
                                          TextAlign.center,
                                          TextOverflow.visible,
                                        ),
                                        AppFonts.textPoppins(
                                          context,
                                          "Today at 09:20 am",
                                          w * 0.03,
                                          FontWeight.w500,
                                          AppColors.mediumGray,
                                          TextAlign.center,
                                          TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    AppFonts.textPoppins(
                                      context,
                                      "₹50.0",
                                      w * 0.05,
                                      FontWeight.w500,
                                      AppColors.primaryRed,
                                      TextAlign.center,
                                      TextOverflow.visible,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
