import 'dart:io';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_images.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/form_field.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/bottomNavigation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/custom_font.dart';

import '../../apis/auth.dart';
import '../../apis/driver_detail_apis.dart';
import '../../session/session_manager.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

 // Auth authController = Get.find<Auth>();

  Future<void> _pickProfileImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (picked != null) {
        setState(() {
          _profileImage = File(picked.path);
        });
      }
    } catch (e) {
      debugPrint('Image picking failed: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to pick image')));
    }
  }

  DashBoardApis editprofileController = Get.put(DashBoardApis());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        titleSpacing: w * .03,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => CustomNavigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                size: w * .07,
                color: ColorsList.iconColor,
              ),
            ),
            SizedBox(width: w * .02),
            CustomText(
              text: "Edit",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: w * .03),
          // Profile Image
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: w * 0.15,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? Icon(
                          Icons.person,
                          size: w * 0.1,
                          color: Colors.grey.shade700,
                        )
                      : null,
                ),
                // Edit button
                Positioned(
                  bottom: 0,
                  right: w * .05,
                  child: GestureDetector(
                    onTap: _pickProfileImage,
                    child: CustomImages.images(
                      "assets/icons/profileEdit1.png",
                      w * .05,
                      w * .05,
                    ),
                  ),
                ),
                // Cancel / Remove button
                if (_profileImage != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _profileImage = null;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryRed,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(w * 0.01),
                        child: Icon(
                          Icons.close,
                          size: w * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(height: w * .01),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * .04,
              vertical: w * .02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name
                AppFonts.textPoppins(
                  context,
                  "Full Name",
                  w * 0.04,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "Monika",
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: w * .04),
                // Mobile Number
                AppFonts.textPoppins(
                  context,
                  "Mobile number",
                  w * 0.04,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "+91 8344661034",
                  controller: mobileNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                SizedBox(height: w * .04),
                // Email
                AppFonts.textPoppins(
                  context,
                  "Email",
                  w * 0.04,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "email.com",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: w * .04),
                // Date of Birth
                AppFonts.textPoppins(
                  context,
                  "Date of birth",
                  w * 0.04,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "DD/MM/YYYY",
                  controller: dobController,
                  readOnly: true,
                  onClicked: () async {
                    DateTime initialDate = DateTime.now().subtract(
                      const Duration(days: 365 * 20),
                    );
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        dobController.text = DateFormat(
                          "dd/MM/yyyy",
                        ).format(picked);
                      });
                    }
                  },
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: AppColors.primaryRed,
                    size: w * 0.055,
                  ),
                ),
                SizedBox(height: w * .04),
                // Gender
                AppFonts.textPoppins(
                  context,
                  "Gender",
                  w * 0.04,
                  FontWeight.w500,
                  AppColors.black,
                  TextAlign.left,
                  TextOverflow.ellipsis,
                ),
                SizedBox(height: w * .01),
                AppFormFields.custTextFormOther(
                  context: context,
                  hintText: "Select Gender",
                  controller: genderController,
                  readOnly: true,
                  onClicked: () async {
                    final selected = await showModalBottomSheet<String>(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: w * .04),
                              child: Text(
                                "Select Gender",
                                style: TextStyle(
                                  fontSize: w * .045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Divider(height: 1, color: Colors.grey.shade300),
                            ...["Male", "Female", "Other"].map((gender) {
                              return ListTile(
                                title: Text(gender),
                                onTap: () => Navigator.pop(context, gender),
                              );
                            }).toList(),
                            SizedBox(height: w * .05),
                          ],
                        );
                      },
                    );
                    if (selected != null) {
                      setState(() {
                        genderController.text = selected;
                      });
                    }
                  },
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryRed,
                    size: w * 0.065,
                  ),
                ),
                SizedBox(height: w * .1),
                // Update Button
                Obx(() {
                  return AppButtons.solid(
                    context: context,
                    text: "Update Profile",
                    onClicked: () async {
                      print("_profileImage!.path${_profileImage!.path}");
                      await editprofileController.editProfile(
                        id: SessionManager.getDriverId().toString(),
                        name: fullNameController.text,
                        rcImage: File(_profileImage!.path), vehicleId: ''
                      );

                      // 👇 After API call completes
                      if (editprofileController.updateSuccess.value) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(editprofileController.message.value),
                        //     backgroundColor: Colors.green,
                        //   ),
                        // );

                        // Wait a bit so user can see the message
                        await Future.delayed(const Duration(seconds: 1));

                        // 👇 Navigate if success
                        CustomNavigator.push(
                          context,
                          const ProfileScreen(),
                          transition: TransitionType.fade,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(editprofileController.message.value),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    isLoading: editprofileController.loading.value, // loader from controller
                    isFullWidth: true,
                    backgroundColor: AppColors.primaryRed,
                    textColor: AppColors.white,
                    fontSize: w * .045,
                    height: w * .140,
                    radius: 12.0,
                  );
                }),



                SizedBox(height: w * .3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
