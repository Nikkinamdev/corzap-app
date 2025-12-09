import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,

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
              text: "Transactions",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: w * .02,
              horizontal: w * .03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                index == 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: w * .03),
                        child: AppFonts.textPoppins(
                          context,
                          "Today",
                          w * 0.037,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.center,
                          TextOverflow.visible,
                        ),
                      )
                    : index == 4
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: w * .03),
                        child: AppFonts.textPoppins(
                          context,
                          "Yesterday",
                          w * 0.037,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.center,
                          TextOverflow.visible,
                        ),
                      )
                    : SizedBox(),

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
                              backgroundColor: ColorsList.mainButtonLightColor,
                              child: Image.asset(
                                "assets/icons/transArrowUp.png",
                                width: w * .055,
                              ),
                            ),
                            SizedBox(width: w * .02),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
              ],
            ),
          );
        },
      ),
    );
  }
}

//?-------reusable widget
// Widget transactionTile(BuildContext context, TransactionModel txn) {
//   double w = MediaQuery.of(context).size.width;
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: w * .02, horizontal: w * .03),
//     child: Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 1)],
//         borderRadius: BorderRadius.circular(w * 0.03),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: w * .025, horizontal: w * .04),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: w * .055,
//               backgroundColor: ColorsList.mainButtonLightColor,
//               child: Image.network(txn.icon, width: w * .055), // API icon
//             ),
//             SizedBox(width: w * .02),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AppFonts.textPoppins(context, txn.name, w * 0.037, FontWeight.w600,
//                     AppColors.black, TextAlign.center, TextOverflow.visible),
//                 AppFonts.textPoppins(context, txn.time, w * 0.03, FontWeight.w500,
//                     AppColors.mediumGray, TextAlign.center, TextOverflow.visible),
//               ],
//             ),
//             Spacer(),
//             AppFonts.textPoppins(context, "₹${txn.amount}", w * 0.05,
//                 FontWeight.w500, AppColors.primaryRed, TextAlign.center,
//                 TextOverflow.visible),
//           ],
//         ),
//       ),
//     ).animate().fade(duration: 820.ms, curve: Curves.easeInOut).scale(
//           begin: const Offset(0.95, 0.95),
//           end: const Offset(1, 1),
//         ),
//   );
// }
