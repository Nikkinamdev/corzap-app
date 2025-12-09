import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/views/bottomNavigation/earnings.dart';
import 'package:corezap_driver/views/bottomNavigation/home_screen.dart';
import 'package:corezap_driver/views/bottomNavigation/profile_screen.dart';
import 'package:corezap_driver/views/bottomNavigation/rideHistory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../apis/help_apis.dart';
import '../../controller/stepper_controller.dart';

class BottomnavmainScreen extends StatefulWidget {
  const BottomnavmainScreen({super.key});

  @override
  State<BottomnavmainScreen> createState() => _BottomnavmainScreenState();
}

class _BottomnavmainScreenState extends State<BottomnavmainScreen> {
  int _selectedIndex = 0;

  HelpApisController privacyPolicy = Get.put(HelpApisController());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Calculate responsive font size based on screen width
    double optionFontSize = w * 0.07;

    // Define text style with responsive font size
    TextStyle optionStyle = TextStyle(
      fontSize: optionFontSize,
      fontWeight: FontWeight.w600,
    );

    // Widget options for each tab
    List<Widget> _widgetOptions = <Widget>[
      HomeScreen(),
      RidehistoryScreen(),
      Earnings(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.shade300),
          ),
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.01,
            ),
            child:
                GNav(
                      rippleColor: AppColors.primaryRed.withOpacity(0.1),
                      hoverColor: AppColors.primaryRed.withOpacity(0.1),
                      gap: w * 0.016,
                      activeColor: AppColors.primaryRed,
                      iconSize: w * 0.068,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.05,
                        vertical: h * 0.015,
                      ),
                      duration: Duration(milliseconds: 400),
                      tabBackgroundColor: AppColors.primaryRed.withOpacity(0.1),
                      color: Colors.grey,
                      tabs: [
                        GButton(
                          icon: Icons.home,
                          text: 'Home',
                          iconSize: w * 0.06,
                          leading: Image.asset(
                            'assets/icons/home.png',
                            width: w * 0.06,
                            height: w * 0.06,
                            color: _selectedIndex == 0
                                ? AppColors.primaryRed
                                : Colors.grey,
                          ),
                        ),
                        GButton(
                          icon: Icons.directions_car,
                          text: 'Rides',
                          iconSize: w * 0.06,
                          leading: Image.asset(
                            'assets/icons/rides.png',
                            width: w * 0.06,
                            height: w * 0.06,
                            color: _selectedIndex == 1
                                ? AppColors.primaryRed
                                : Colors.grey,
                          ),
                        ),
                        GButton(
                          icon: Icons.account_balance_wallet,
                          text: 'Wallet',
                          iconSize: w * 0.06,
                          leading: Image.asset(
                            'assets/icons/wallet.png',
                            width: w * 0.06,
                            height: w * 0.06,
                            color: _selectedIndex == 2
                                ? AppColors.primaryRed
                                : Colors.grey,
                          ),
                        ),
                        GButton(
                          icon: Icons.person,
                          text: 'Profile',
                          iconSize: w * 0.06,
                          leading: Image.asset(
                            'assets/icons/profile.png',
                            width: w * 0.06,
                            height: w * 0.06,
                            color: _selectedIndex == 3
                                ? AppColors.primaryRed
                                : Colors.grey,
                          ),
                        ),
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    )
                    .animate()
                    .fade(duration: 900.ms, curve: Curves.easeInOut)
                    .scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1, 1),
                    )
                    .slide(
                      begin: const Offset(1, 0), // from right
                      end: const Offset(0, 0), // to normal position
                      curve: Curves.easeInOut,
                    ),
          ),
        ),
      ),
    );
  }
}
