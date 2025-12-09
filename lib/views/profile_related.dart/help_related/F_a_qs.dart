import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apis/help_apis.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  final HelpApisController faq = Get.put(HelpApisController());

  List<bool> expanded = [];

  @override
  void initState() {
    super.initState();
    loadFAQ();
  }

  Future<void> loadFAQ() async {
    await faq.FAQ();
    expanded = List.generate(faq.faqList.length, (index) => false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsList.scaffoldColor,
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
              text: "FAQs",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),

      body: Obx(() {
        if (faq.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (faq.faqList.isEmpty) {
          return const Center(child: Text("No FAQs available"));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .025),
          child: Card(
            elevation: 1,
            color: ColorsList.scaffoldColor,
            child: Column(
              children: List.generate(faq.faqList.length, (index) {
                final item = faq.faqList[index];

                return Column(
                  children: [
                    if (index == 0) SizedBox(height: w * .02),

                    /// QUESTION ROW
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          expanded[index] = !expanded[index];
                        });
                      },
                      child: Container(
                        color: ColorsList.scaffoldColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * .04, vertical: w * .03),
                          child: Row(
                            children: [
                              SizedBox(
                                width: w * .75,
                                child: CustomText(
                                  text: item.question ?? "",
                                  textColor: ColorsList.backIconColor,
                                  textFontSize: w * .045,
                                  textFontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              AnimatedRotation(
                                turns: expanded[index] ? 0.25 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorsList.backIconColor,
                                  size: w * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// ANSWER SECTION
                    if (expanded[index])
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: w * .05, vertical: w * .02),
                        child: CustomText(
                          text: item.answer ?? "--",
                          textFontSize: w * .038,
                          textColor: ColorsList.subtitleTextColor,
                          textFontWeight: FontWeight.w400,
                        ),
                      ),

                    /// DIVIDER
                    if (index < faq.faqList.length - 1)
                      Divider(
                        indent: w * .04,
                        color: ColorsList.textfieldBorderColorSe,
                      ),

                    if (index == faq.faqList.length - 1)
                      SizedBox(height: w * .02),
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
