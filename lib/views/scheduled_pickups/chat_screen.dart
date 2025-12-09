import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    String imagePath = "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
                color: AppColors.black,
              ),
            ),
            SizedBox(width: w * .03),
            CircleAvatar(
              radius: w * .055,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: imagePath != null && imagePath.isNotEmpty
                  ? AssetImage(imagePath) //  NetworkImage(imageUrl)
                  : null,
              child: (imagePath == null || imagePath.isEmpty)
                  ? Icon(
                      Icons.person,
                      size: w * .08,
                      color: Colors.grey.shade700,
                    )
                  : null,
            ),
            SizedBox(width: w * .02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppFonts.textPoppins(
                  context,
                  "Amaan Shaikh",
                  w * 0.03,
                  FontWeight.w400,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.visible,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: w * .007,
                      backgroundColor: AppColors.green.withOpacity(0.2),
                    ),
                    SizedBox(width: w * .01),
                    AppFonts.textPoppins(
                      context,
                      "Online",
                      w * 0.03,
                      FontWeight.w400,
                      AppColors.green,
                      TextAlign.left,
                      TextOverflow.visible,
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Container(
              // margin: EdgeInsets.all(w * .02),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),

              padding: EdgeInsets.all(w * 0.02),
              child: Icon(Icons.call, color: AppColors.black, size: w * .04),
            ),
            SizedBox(width: w * .02),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(w * 0.04),
              children: [
                _receiverMessage(
                  w,
                  h,
                  "Okay, so are you there now because I’m about to leave the hold up now",
                  "2:55 PM",
                ),
                _senderMessage(
                  w,
                  h,
                  "Yes. Currently at the that petrol station at that junction",
                  "3:12 PM",
                ),
                _senderMessage(w, h, "Hi", "3:12 PM"),
                _senderMessage(
                  w,
                  h,
                  "Hello, are you there?\nI’m waiting for you already",
                  "3:12 PM",
                ),
                _receiverMessage(w, h, "Yes, 2 mins out", "2:55 PM"),
              ],
            ),
          ),
          _messageBox(w, h),
        ],
      ),
    );
  }

  Widget _senderMessage(double w, double h, String text, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(top: h * 0.01),
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.012,
        ),
        constraints: BoxConstraints(maxWidth: w * 0.7),
        decoration: BoxDecoration(
          color: Colors.pink.shade100,
          borderRadius: BorderRadius.circular(w * 0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: w * 0.04, color: Colors.black),
            ),
            SizedBox(height: h * 0.005),
            Text(
              time,
              style: TextStyle(fontSize: w * 0.03, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _receiverMessage(double w, double h, String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: h * 0.01),
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.012,
        ),
        constraints: BoxConstraints(maxWidth: w * 0.7),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(w * 0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: w * 0.04, color: Colors.black),
            ),
            SizedBox(height: h * 0.005),
            Text(
              time,
              style: TextStyle(fontSize: w * 0.03, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageBox(double w, double h) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * .03, vertical: w * .02),
      child: Container(
        height: w * .13,
        //  padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * .02),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Send Message",
                  hintStyle: TextStyle(fontSize: w * 0.04, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: w * .04,
                    vertical: w * .01,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(right: w * .04),
            //   child: CustomImages.images(
            //     "assets/icons/messageSend.png",
            //     w * .06,
            //     w * .06,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
