import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../apis/ride_apis.dart';
import '../../controller/controllers.dart';
import '../../utilities/colors.dart';
import '../../utilities/custom_font.dart';


class RidehistoryScreen extends StatefulWidget {
  const RidehistoryScreen({super.key});

  @override
  State<RidehistoryScreen> createState() => _RidehistoryScreenState();
}

class _RidehistoryScreenState extends State<RidehistoryScreen> with TickerProviderStateMixin {
  Controllers currentTabBar = Get.find<Controllers>();
  RideApisController rideHistory = Get.put(RideApisController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      currentTabBar.currentTabIndex.value = _tabController.index;
    });

    rideHistory.getRideHistory(); // Fetch ride history on init
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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: SizedBox(),
        title: AppFonts.textPoppins(
          context,
          "Ride History",
          w * 0.05,
          FontWeight.w600,
          AppColors.black,
          TextAlign.center,
          TextOverflow.ellipsis,
          maxLines: 1,
        ).animate().fade(duration: 800.ms, curve: Curves.easeInOut).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
      ),
      body: Column(
        children: [
          // Tab bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .03),
            child: Container(
              height: w * .11,
              width: w,
              decoration: BoxDecoration(
                color: AppColors.lightGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(w * .035),
                border: Border.all(color: AppColors.black.withOpacity(0.4), width: w * .002),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .005, vertical: w * .005),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(color: AppColors.primaryRed, borderRadius: BorderRadius.circular(w * .03)),
                  labelColor: AppColors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: AppColors.darkGray.withOpacity(0.4),
                  labelStyle: TextStyle(fontSize: w * .034, fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: "New trip"),
                    Tab(text: "Completed"),
                    Tab(text: "Cancelled"),
                  ],
                ),
              ),
            ).animate().fade(duration: 820.ms, curve: Curves.easeInOut).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
          ),
          Divider(color: AppColors.mediumGray.withOpacity(0.4), thickness: w * .002),

          // Tab bar view
          Expanded(
            child: Obx(() {
              if (rideHistory.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              List<dynamic> currentList = [];
              if (currentTabBar.currentTabIndex.value == 0) {
                currentList = rideHistory.newTrips;
              } else if (currentTabBar.currentTabIndex.value == 1) {
                currentList = rideHistory.completedTrips;
              } else if (currentTabBar.currentTabIndex.value == 2) {
                currentList = rideHistory.cancelledTrips;
              }

              if (currentList.isEmpty) {
                return Center(
                  child: AppFonts.textPoppins(
                    context,
                    "No rides found",
                    w * 0.04,
                    FontWeight.w500,
                    AppColors.black,
                    TextAlign.center,
                    TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.02),
                itemCount: currentList.length,
                separatorBuilder: (_, __) => SizedBox(height: w * 0.06),
                itemBuilder: (context, index) {
                  final ride = currentList[index];
                  return buildRideWidget(context, ride);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Ride widget
  Widget buildRideWidget(BuildContext context, dynamic ride) {
    double w = MediaQuery.of(context).size.width;

    final vehicleName = ride['vehicleId']?['vehicleName'] ?? "Vehicle";
    final fare = "₹${ride['totalFare'] ?? 0}";
    final date = ride['createdAt']?.substring(0, 16) ?? "N/A";
    final paymentType = ride['paymentMethod'] ?? "Cash";
    final tripType = ride['orderType'] ?? "One way | 4 Hours";
    final pickup = ride['startLocation']?['address'] ?? "Pickup";
    final destination = ride['endLocation']?['address'] ?? "Destination";
    final riderName = ride['userId']?['_id'] ?? "Rider";
    final rating = ride['ratings'] ?? 0.0;
    final cancelReason = ride['cancellationHistory']?.isNotEmpty == true
        ? ride['cancellationHistory'][0]['reason']
        : "Booked by mistake";

    return Container(
      width: w,
      decoration: BoxDecoration(
        color: AppColors.lightGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(w * .035),
        border: Border.all(color: AppColors.black.withOpacity(0.1), width: w * .002),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row1: Vehicle & Fare
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppFonts.textPoppins(context, vehicleName, w * 0.035, FontWeight.w600,
                    AppColors.black.withOpacity(0.5), TextAlign.center, TextOverflow.ellipsis, maxLines: 1),
                AppFonts.textPoppins(context, fare, w * 0.042, FontWeight.w600,
                    AppColors.black, TextAlign.center, TextOverflow.ellipsis, maxLines: 1),
              ],
            ),
            SizedBox(height: w * 0.02),
            // Row2: Date & Payment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppFonts.textPoppins(context, date, w * 0.032, FontWeight.w600,
                    AppColors.black.withOpacity(0.5), TextAlign.center, TextOverflow.ellipsis, maxLines: 1),
                Row(
                  children: [
                    Image.asset("assets/icons/moneys.png", height: w * 0.05, width: w * 0.05),
                    AppFonts.textPoppins(context, " $paymentType", w * 0.035, FontWeight.w600,
                        AppColors.black, TextAlign.center, TextOverflow.ellipsis, maxLines: 1),
                  ],
                ),
              ],
            ),
            SizedBox(height: w * 0.02),
            // Trip type
            IntrinsicWidth(
              child: Container(
                decoration: BoxDecoration(color: AppColors.primaryRed, borderRadius: BorderRadius.circular(w * .05)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: w * 0.01),
                  child: Center(
                    child: AppFonts.textPoppins(
                        context, tripType, w * 0.030, FontWeight.w500, AppColors.white, TextAlign.center, TextOverflow.ellipsis, maxLines: 1),
                  ),
                ),
              ),
            ),
            SizedBox(height: w * 0.02),
            Divider(color: AppColors.mediumGray.withOpacity(0.4), thickness: w * .002, height: w * 0.1),
            // Pickup & Destination
            Row(
              children: [
                Column(
                  children: [
                    Image.asset("assets/icons/greenDot.png", height: w * 0.06, width: w * 0.06),
                    Container(width: w * 0.002, height: w * 0.10, color: AppColors.mediumGray),
                    Image.asset("assets/icons/redDot.png", height: w * 0.06, width: w * 0.06),
                  ],
                ),
                SizedBox(width: w * 0.04),
                SizedBox(
                  width: w * 0.70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFonts.textPoppins(context, "Pickup", w * 0.032, FontWeight.w600, AppColors.green,
                          TextAlign.start, TextOverflow.ellipsis, maxLines: 1),
                      SizedBox(height: w * 0.02),
                      AppFonts.textPoppins(context, pickup, w * 0.032, FontWeight.w600, AppColors.black,
                          TextAlign.start, TextOverflow.ellipsis, maxLines: 1),
                      SizedBox(height: w * 0.06),
                      AppFonts.textPoppins(context, "Destination", w * 0.032, FontWeight.w600, AppColors.primaryRed,
                          TextAlign.start, TextOverflow.ellipsis, maxLines: 1),
                      SizedBox(height: w * 0.02),
                      AppFonts.textPoppins(context, destination, w * 0.032, FontWeight.w600, AppColors.black,
                          TextAlign.start, TextOverflow.ellipsis, maxLines: 1),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: w * 0.02),
            // Rider info / Rating / Cancel reason
            Obx(() {
              if (currentTabBar.currentTabIndex.value == 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/profile.png", height: w * 0.06, width: w * 0.06, color: AppColors.primaryRed),
                    SizedBox(width: w * 0.02),
                    AppFonts.textPoppins(context, riderName, w * 0.04, FontWeight.w600, AppColors.black,
                        TextAlign.start, TextOverflow.ellipsis, maxLines: 1),
                  ],
                );
              } else if (currentTabBar.currentTabIndex.value == 1) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBarIndicator(
                      rating: rating.toDouble(),
                      itemCount: 5,
                      itemSize: w * 0.08,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => Icon(Icons.star, color: index < rating ? Colors.amber : Colors.grey),
                    ),
                    SizedBox(width: w * 0.02),
                    AppFonts.textPoppins(context, "($rating)", w * 0.045, FontWeight.w600, AppColors.black,
                        TextAlign.start, TextOverflow.ellipsis, maxLines: 1),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: const Color.fromRGBO(224, 45, 60, 1), size: w * .055),
                    SizedBox(width: w * .02),
                    AppFonts.textPoppins(context, cancelReason, w * 0.042, FontWeight.w400,
                        const Color.fromRGBO(224, 45, 60, 1), TextAlign.start, TextOverflow.ellipsis, maxLines: 1),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
