import 'package:corezap_driver/controller/controllers.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  ButtonController controller = Get.put(ButtonController());
  PageController _pageController = PageController(initialPage: 0);
  final tripStatuses = [
    {'name': 'Completed Trip', 'progress': 3, 'color': AppColors.yellow},
    {'name': 'Canceled Trip', 'progress': 2, 'color': AppColors.mediumYellow},
    {'name': 'Denied Trip', 'progress': 1, 'color': AppColors.lightYellow},
  ];
  final weeklyTripData = [
    {'day': 'Mon', 'completed': 8, 'canceled': 3, 'denied': 1},
    {'day': 'Tue', 'completed': 6, 'canceled': 2, 'denied': 4},
    {'day': 'Wed', 'completed': 9, 'canceled': 1, 'denied': 2},
    {'day': 'Thu', 'completed': 3, 'canceled': 5, 'denied': 6},
    {'day': 'Fri', 'completed': 7, 'canceled': 4, 'denied': 3},
    {'day': 'Sat', 'completed': 5, 'canceled': 2, 'denied': 7},
  ];
  final totalEarnings = ["500.0", "5000.0", "10000.0"];

  @override
  void initState() {
    super.initState();
    controller.selectedIndex.value = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      //appbar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(w * .300),
        child:
            Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * .04,
                          vertical: w * .02,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: w * .01),
                            AppFonts.textPoppins(
                              context,
                              "Earning Report",
                              w * 0.05,
                              FontWeight.w600,
                              AppColors.black,
                              TextAlign.center,
                              TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: w * .05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(3, (index) {
                                return Obx(() {
                                  bool isSelected =
                                      controller.selectedIndex.value == index;
                                  List<String> buttonText = [
                                    "Today",
                                    "Weekly",
                                    "Monthly",
                                  ];
                                  return AppButtons.solid(
                                    width: w * .28,
                                    context: context,
                                    text: buttonText[index],
                                    onClicked: () {
                                      controller.selectedIndex.value = index;
                                      _pageController.animateToPage(
                                        index,
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    isFullWidth: false,
                                    backgroundColor: isSelected
                                        ? AppColors.primaryRed
                                        : AppColors.lightGray,
                                    textColor: isSelected
                                        ? AppColors.white
                                        : AppColors.primaryRed,
                                    fontSize: w * .035,
                                    height: w * .1,
                                    radius: 30,
                                  );
                                });
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .animate()
                .fade(duration: 800.ms, curve: Curves.easeInOut)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int index) {
          controller.selectedIndex.value = index;
        },
        itemCount: 3,
        itemBuilder: (context, pageIndex) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: w * .5,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Background Image
                      Image.asset(
                        "assets/images/earning1.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppFonts.textPoppins(
                                context,
                                "Total Earnings",
                                w * 0.03,
                                FontWeight.w500,
                                AppColors.black,
                                TextAlign.center,
                                TextOverflow.visible,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    color: AppColors.green,
                                    size: w * .063,
                                  ),
                                  AppFonts.textPoppins(
                                    context,
                                    totalEarnings[pageIndex],
                                    w * 0.08,
                                    FontWeight.bold,
                                    AppColors.green,
                                    TextAlign.center,
                                    TextOverflow.visible,
                                  ),
                                ],
                              ),
                              SizedBox(height: w * 0.05),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        AppFonts.textPoppins(
                                          context,
                                          "1000 - ",
                                          w * 0.032,
                                          FontWeight.w600,
                                          AppColors.black,
                                          TextAlign.left,
                                          TextOverflow.visible,
                                        ),
                                        AppFonts.textPoppins(
                                          context,
                                          "Cash",
                                          w * 0.028,
                                          FontWeight.w400,
                                          AppColors.black,
                                          TextAlign.left,
                                          TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        AppFonts.textPoppins(
                                          context,
                                          "1000 - ",
                                          w * 0.032,
                                          FontWeight.w600,
                                          AppColors.black,
                                          TextAlign.left,
                                          TextOverflow.visible,
                                        ),
                                        AppFonts.textPoppins(
                                          context,
                                          "Online",
                                          w * 0.028,
                                          FontWeight.w400,
                                          AppColors.black,
                                          TextAlign.left,
                                          TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                          .animate()
                          .fade(duration: 820.ms, curve: Curves.easeInOut)
                          .scale(
                            begin: const Offset(0.95, 0.95),
                            end: const Offset(1, 1),
                          ),
                      Positioned(
                        bottom: -w * .12,
                        left: w * .045,
                        right: w * .045,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            // Colors list
                            final colors = [
                              AppColors.yellow,
                              AppColors.mediumYellow,
                              AppColors.lightYellow,
                            ];

                            // Data based on pageIndex
                            List<int> completedList;
                            int totalSteps;
                            if (pageIndex == 0) {
                              // Today
                              completedList = [3, 2, 1];
                              totalSteps = 6;
                            } else {
                              // Weekly/Monthly - sum from weeklyTripData
                              int completed = 0, canceled = 0, denied = 0;
                              for (var data in weeklyTripData) {
                                completed += data['completed'] as int;
                                canceled += data['canceled'] as int;
                                denied += data['denied'] as int;
                              }
                              completedList = [completed, canceled, denied];
                              totalSteps = completed + canceled + denied;
                            }
                            final totalList = List.filled(3, totalSteps);
                            final labelList = [
                              "Completed Trip",
                              "Canceled Trip",
                              "Denied Trip",
                            ];

                            return Container(
                              width: w * .28,
                              height: w * .18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colors[index],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * .03,
                                  vertical: w * .02,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Fraction
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        AppFonts.textRubik(
                                          context,
                                          completedList[index].toString(),
                                          w * 0.07,
                                          FontWeight.w500,
                                          AppColors.black,
                                          TextAlign.center,
                                          TextOverflow.visible,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: w * .002,
                                            right: w * .002,
                                            top: w * .03,
                                          ),
                                          child: AppFonts.textRubik(
                                            context,
                                            "/",
                                            w * 0.05,
                                            FontWeight.w500,
                                            AppColors.black,
                                            TextAlign.center,
                                            TextOverflow.visible,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: w * .002,
                                            right: w * .002,
                                            top: w * .03,
                                          ),
                                          child: AppFonts.textRubik(
                                            context,
                                            totalList[index].toString(),
                                            w * 0.05,
                                            FontWeight.w500,
                                            AppColors.black,
                                            TextAlign.center,
                                            TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Label
                                    AppFonts.textPoppins(
                                      context,
                                      labelList[index],
                                      w * 0.026,
                                      FontWeight.w500,
                                      AppColors.black,
                                      TextAlign.start,
                                      TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: w * .15),
                //? trip request data------------
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * .04,
                    vertical: w * .02,
                  ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: w * .04,
                        vertical: w * .03,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppFonts.textPoppins(
                                context,
                                "Received Trip Request",
                                w * 0.03,
                                FontWeight.w500,
                                AppColors.black,
                                TextAlign.center,
                                TextOverflow.visible,
                              ),
                              CircleAvatar(
                                radius: w * .04,
                                backgroundColor: AppColors.primaryRed,
                                child: AppFonts.textPoppins(
                                  context,
                                  pageIndex == 0
                                      ? "6"
                                      : weeklyTripData
                                            .fold(
                                              0,
                                              (sum, data) =>
                                                  sum +
                                                  (data['completed'] as int) +
                                                  (data['canceled'] as int) +
                                                  (data['denied'] as int),
                                            )
                                            .toString(),
                                  w * 0.03,
                                  FontWeight.w500,
                                  AppColors.white,
                                  TextAlign.center,
                                  TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          pageIndex == 0
                              ? TripStatusSection(
                                  tripStatuses: tripStatuses,
                                  totalSteps: 6,
                                )
                              : TripStatusSectionWeekly(
                                  tripData: weeklyTripData,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * .04,
                    vertical: w * .04,
                  ),
                  child: CustomImages.images(
                    "assets/images/earning2.png",
                    double.infinity,
                    w * .25,
                  ),
                ),
                pageIndex == 0
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * .04,
                          vertical: w * .02,
                        ),
                        child: CustomWeeklyEarningsChart(
                          width: w,
                          height: w * .5,
                          title: pageIndex == 1
                              ? "Weekly Earning"
                              : "Monthly Earning",
                          amount: pageIndex == 1 ? "₹5000" : "₹10000",
                        ),
                      ),
                SizedBox(height: w * .1),
              ],
            ),
          );
        },
      ),
    );
  }
}

//?---------------------
// Reusable widget for displaying trip status progress bars
class TripStatusSection extends StatelessWidget {
  final List<Map<String, dynamic>> tripStatuses;
  final int totalSteps;

  const TripStatusSection({
    Key? key,
    required this.tripStatuses,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tripStatuses.map((status) {
        final name = status['name'] as String;
        final progressValue = (status['progress'] as int) / totalSteps;
        final color = status['color'] as Color;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFonts.textPoppins(
                context,
                name,
                w * 0.03,
                FontWeight.w500,
                AppColors.black,
                TextAlign.center,
                TextOverflow.visible,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progressValue,
                backgroundColor: AppColors.lightGray,
                borderRadius: BorderRadius.circular(5),
                color: color,
                minHeight: 5,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

//? weekly---------------
// Dashed line painter for background
class DashLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;

  DashLinePainter({this.dashWidth = 0.02, this.dashSpace = 0.02});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double totalDashWidth = dashWidth * size.width;
    double totalDashSpace = dashSpace * size.width;
    double y = 0;

    while (y < size.height) {
      double x = 0;
      while (x < size.width) {
        canvas.drawLine(Offset(x, y), Offset(x + totalDashWidth, y), paint);
        x += totalDashWidth + totalDashSpace;
      }
      y += totalDashWidth + totalDashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Reusable widget for displaying trip status bar chart
class TripStatusSectionWeekly extends StatelessWidget {
  final List<Map<String, dynamic>> tripData;

  const TripStatusSectionWeekly({Key? key, required this.tripData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    // Calculate the maximum value dynamically for scaling
    final maxValue = tripData
        .map((e) => e['completed'] as int)
        .followedBy(tripData.map((e) => e['canceled'] as int))
        .followedBy(tripData.map((e) => e['denied'] as int))
        .reduce((a, b) => a > b ? a : b);

    // Colors mapping
    final colors = {
      'completed': AppColors.yellow,
      'canceled': AppColors.mediumYellow,
      'denied': AppColors.lightYellow,
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        Padding(
          padding: EdgeInsets.symmetric(vertical: w * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegend('Completed', colors['completed']!, w),
              _buildLegend('Canceled', colors['canceled']!, w),
              _buildLegend('Denied', colors['denied']!, w),
            ],
          ),
        ),
        SizedBox(height: w * 0.03),
        // Bar chart
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: tripData.map((data) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Dashed background
                        Container(
                          width: w * 0.1,
                          height: w * 0.25,
                          child: CustomPaint(
                            painter: DashLinePainter(
                              dashWidth: 0.15,
                              dashSpace: 0.15,
                            ),
                          ),
                        ),
                        // Bars Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar(
                              context,
                              data['completed'],
                              maxValue,
                              colors['completed']!,
                              w,
                            ),
                            SizedBox(width: w * 0.015),
                            _buildBar(
                              context,
                              data['canceled'],
                              maxValue,
                              colors['canceled']!,
                              w,
                            ),
                            SizedBox(width: w * 0.015),
                            _buildBar(
                              context,
                              data['denied'],
                              maxValue,
                              colors['denied']!,
                              w,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: w * 0.02),
                    // Day Label
                    Text(
                      data['day'],
                      style: TextStyle(
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Legend widget
  Widget _buildLegend(String text, Color color, double w) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.lightGray,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .03, vertical: w * .01),
        child: Row(
          children: [
            Container(
              width: w * 0.02,
              height: w * 0.02,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
            ),
            SizedBox(width: w * 0.01),
            Text(
              text,
              style: TextStyle(
                fontSize: w * 0.03,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Single Bar widget
  Widget _buildBar(
    BuildContext context,
    int value,
    int maxValue,
    Color color,
    double w,
  ) {
    double heightFactor = value / maxValue;
    return Container(
      width: w * 0.023,
      height: (w * 0.25) * heightFactor,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

//?--------------fnksfk
class CustomWeeklyEarningsChart extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String amount;

  const CustomWeeklyEarningsChart({
    super.key,
    this.width = double.infinity,
    this.height = 200.0,
    this.title = "Weekly Earning",
    this.amount = "₹900",
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
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
        padding: EdgeInsets.symmetric(horizontal: w * .04, vertical: w * .02),
        child: Stack(
          children: [
            Positioned(
              top: 8.0,
              left: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppFonts.textPoppins(
                    context,
                    title,
                    w * 0.02,
                    FontWeight.w500,
                    AppColors.black,
                    TextAlign.left,
                    TextOverflow.ellipsis,
                  ),
                  AppFonts.textPoppins(
                    context,
                    amount,
                    w * 0.04,
                    FontWeight.w600,
                    AppColors.black,
                    TextAlign.left,
                    TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 40.0,
              child:
                  LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                  ];
                                  if (value.toInt() >= 0 &&
                                      value.toInt() < days.length) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: w * .02,
                                      ),
                                      child: Text(
                                        days[value.toInt()],
                                        style: TextStyle(
                                          fontSize: w * .03,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: 5,
                          minY: 0,
                          maxY: 1000,
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 200), // Mon
                                FlSpot(1, 500), // Tue
                                FlSpot(2, 300), // Wed
                                FlSpot(3, 800), // Thu
                                FlSpot(4, 600), // Fri
                                FlSpot(5, 900), // Sat
                              ],
                              isCurved: true,
                              color: AppColors.primaryRed,
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.primaryRed.withOpacity(0.2),
                                    Colors.white,
                                  ],
                                ),
                              ),
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  if (index == 4) {
                                    return FlDotCirclePainter(
                                      radius: 4,
                                      color: AppColors.primaryRed,
                                      strokeWidth: 2,
                                      strokeColor: Colors.white,
                                    );
                                  }
                                  return FlDotCirclePainter(
                                    radius: 2,
                                    color: AppColors.primaryRed,
                                  );
                                },
                              ),
                            ),
                          ],
                          extraLinesData: ExtraLinesData(
                            verticalLines: [
                              VerticalLine(
                                x: 4,
                                color: AppColors.primaryRed.withOpacity(0.5),
                                strokeWidth: 2,
                                dashArray: [5, 5],
                              ),
                            ],
                          ),
                        ),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      )
                      .animate()
                      .fadeIn(duration: 500.ms, curve: Curves.easeInOut)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        end: const Offset(1, 1),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
