import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class RidehistoryScreen extends StatefulWidget {
  const RidehistoryScreen({super.key});

  @override
  State<RidehistoryScreen> createState() => _RidehistoryScreenState();
}

class _RidehistoryScreenState extends State<RidehistoryScreen>
    with TickerProviderStateMixin {
  Controllers currentTabBar = Get.find<Controllers>();

  late TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 3, vsync: this);
  // }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      currentTabBar.currentTabIndex.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      //appbar
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: SizedBox(),
        title:
            AppFonts.textPoppins(
                  context,
                  "Ride History",
                  w * 0.05,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.center,
                  TextOverflow.ellipsis,
                  maxLines: 1,
                )
                .animate()
                .fade(duration: 800.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
      ),
      body: Column(
        children: [
          //tab bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * .04,
              vertical: w * .03,
            ),
            child:
                Container(
                      height: w * .11,
                      width: w,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(w * .035),
                        border: Border.all(
                          color: AppColors.black.withOpacity(0.4),
                          width: w * .002,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * .005,
                          vertical: w * .005,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            color: AppColors.primaryRed,
                            borderRadius: BorderRadius.circular(w * .03),
                          ),
                          indicatorColor: AppColors.darkGray,
                          labelColor: AppColors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerHeight: 0.0,
                          unselectedLabelColor: AppColors.darkGray.withOpacity(
                            0.4,
                          ),
                          labelStyle: TextStyle(
                            fontSize: w * .034,
                            fontWeight: FontWeight.bold,
                          ),
                          tabs: [
                            Tab(text: "New trip"),
                            Tab(text: "Completed"),
                            Tab(text: "Cancelled"),
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

          //divider
          Divider(
            color: AppColors.mediumGray.withOpacity(0.4),
            thickness: w * .002,
          ),

          //tab bar view
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // New trip tab content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: w * 0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                        SizedBox(height: w * 0.06),
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                        SizedBox(height: w * 0.06),
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                      ],
                    ),
                  ),
                ),
                // Completed tab content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: w * 0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                        SizedBox(height: w * 0.06),
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                        SizedBox(height: w * 0.06),
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                      ],
                    ),
                  ),
                ),
                // Cancelled tab content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: w * 0.02,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                        SizedBox(height: w * 0.06),
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                        SizedBox(height: w * 0.06),
                        commonWidget(w)
                            .animate()
                            .fade(duration: 400.ms, curve: Curves.easeInOut)
                            .scale(
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1, 1),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //commmon Widget
  Widget commonWidget(double w) {
    return Container(
      width: w,
      decoration: BoxDecoration(
        color: AppColors.lightGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(w * .035),
        border: Border.all(
          color: AppColors.black.withOpacity(0.1),
          width: w * .002,
        ),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // row1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //text1
                    AppFonts.textPoppins(
                      context,
                      "Roll ",
                      w * 0.035,
                      FontWeight.w600,
                      AppColors.black.withOpacity(0.5),
                      TextAlign.center,
                      TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    AppFonts.textPoppins(
                      context,
                      "•",
                      w * 0.030,
                      FontWeight.w600,
                      AppColors.mediumGray,
                      TextAlign.center,
                      TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    AppFonts.textPoppins(
                      context,
                      " Mini",
                      w * 0.035,
                      FontWeight.w600,
                      AppColors.black.withOpacity(0.5),
                      TextAlign.center,
                      TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),

                //text2
                AppFonts.textPoppins(
                  context,
                  "₹105.99",
                  w * 0.042,
                  FontWeight.w600,
                  AppColors.black,
                  TextAlign.center,
                  TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),

            //row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //text1
                AppFonts.textPoppins(
                  context,
                  "18/11/2025, 10:24 AM",
                  w * 0.032,
                  FontWeight.w600,
                  AppColors.black.withOpacity(0.5),
                  TextAlign.center,
                  TextOverflow.ellipsis,
                  maxLines: 1,
                ),

                Row(
                  children: [
                    Image.asset(
                      "assets/icons/moneys.png",
                      height: w * 0.05,
                      width: w * 0.05,
                    ),
                    //text2
                    AppFonts.textPoppins(
                      context,
                      " Cash",
                      w * 0.035,
                      FontWeight.w600,
                      AppColors.black,
                      TextAlign.center,
                      TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: w * 0.02),
            //container with primary red color and at center some text with white colo
            IntrinsicWidth(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(w * .05),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.03,
                    vertical: w * 0.01,
                  ),
                  child: Center(
                    child: AppFonts.textPoppins(
                      context,
                      "One way | 4 Hours",
                      w * 0.030,
                      FontWeight.w500,
                      AppColors.white,
                      TextAlign.center,
                      TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ),

            Divider(
              color: AppColors.mediumGray.withOpacity(0.4),
              thickness: w * .002,
              height: w * 0.1,
            ),

            // row 3
            Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/icons/greenDot.png",
                      height: w * 0.06,
                      width: w * 0.06,
                    ),
                    //vertical dotted line
                    Container(
                      width: w * 0.002,
                      height: w * 0.10,
                      color: AppColors.mediumGray,
                    ),
                    Image.asset(
                      "assets/icons/redDot.png",
                      height: w * 0.06,
                      width: w * 0.06,
                    ),
                  ],
                ),

                SizedBox(width: w * 0.04),

                SizedBox(
                  width: w * 0.70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //text1
                      AppFonts.textPoppins(
                        context,
                        "Pickup",
                        w * 0.032,
                        FontWeight.w600,
                        AppColors.green,
                        TextAlign.start,
                        TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      SizedBox(height: w * 0.02),

                      ///text2
                      AppFonts.textPoppins(
                        context,
                        "Bus Sta Upas, Majestic, Bengaluru, Karnataka 560009",
                        w * 0.032,
                        FontWeight.w600,
                        AppColors.black,
                        TextAlign.start,
                        TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      SizedBox(height: w * 0.06),

                      //text3
                      AppFonts.textPoppins(
                        context,
                        "Destination",
                        w * 0.032,
                        FontWeight.w600,
                        AppColors.primaryRed,
                        TextAlign.start,
                        TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      SizedBox(height: w * 0.02),

                      ///text4
                      AppFonts.textPoppins(
                        context,
                        "Bus Sta Upas, Majestic, Bengaluru, Karnataka 560009",
                        w * 0.032,
                        FontWeight.w600,
                        AppColors.black,
                        TextAlign.start,
                        TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(
              color: AppColors.mediumGray.withOpacity(0.4),
              thickness: w * .002,
              height: w * 0.1,
            ),

            // row4 with profile icon and name
            Obx(() {
              return currentTabBar.currentTabIndex.value == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/profile.png",
                          height: w * 0.06,
                          width: w * 0.06,
                          color: AppColors.primaryRed,
                        ),
                        SizedBox(width: w * 0.02),
                        AppFonts.textPoppins(
                          context,
                          "Muskan",
                          w * 0.04,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.start,
                          TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )
                  : currentTabBar.currentTabIndex.value == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // RatingBarIndicator(
                        //   rating: 4.5,
                        //   unratedColor: AppColors.white,
                        //   itemBuilder: (context, index) =>
                        //       Icon(Icons.star, color: Colors.amber),
                        //   itemCount: 5,
                        //   itemSize: w * .08,
                        //   direction: Axis.horizontal,
                        // ),
                        RatingBarIndicator(
                          rating: 4.5,
                          itemCount: 5,
                          itemSize: w * .08,
                          direction: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index < 4) {
                              // fully filled stars
                              return Icon(Icons.star, color: Colors.amber);
                            } else if (index < 4.5) {
                              // half star
                              return Icon(Icons.star_half, color: Colors.amber);
                            } else {
                              // empty border star
                              return Icon(
                                Icons.star_border,
                                color: Colors.grey,
                              ); // visible border
                            }
                          },
                        ),

                        SizedBox(width: w * .02),
                        AppFonts.textPoppins(
                          context,
                          "(4.5)",
                          w * 0.045,
                          FontWeight.w600,
                          AppColors.black,
                          TextAlign.start,
                          TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )
                  : currentTabBar.currentTabIndex.value == 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: Color.fromRGBO(224, 45, 60, 1),
                          size: w * .055,
                        ),
                        SizedBox(width: w * .02),
                        AppFonts.textPoppins(
                          context,
                          "Booked by mistake",
                          w * 0.042,
                          FontWeight.w400,
                          Color.fromRGBO(224, 45, 60, 1),
                          TextAlign.start,
                          TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )
                  : SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
