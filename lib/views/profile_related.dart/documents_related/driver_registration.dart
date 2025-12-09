import 'dart:io';

import 'package:corezap_driver/apis/auth.dart';
import 'package:corezap_driver/controller/document_upload_controller.dart';
import 'package:corezap_driver/controller/stepper_controller.dart';
import 'package:corezap_driver/session/session_manager.dart';
import 'package:corezap_driver/utilities/app_buttons.dart';
import 'package:corezap_driver/utilities/colors.dart';
import 'package:corezap_driver/utilities/colors/colors_list.dart';
import 'package:corezap_driver/utilities/custom_document_uploader.dart';
import 'package:corezap_driver/utilities/custom_font.dart';
import 'package:corezap_driver/utilities/custom_text.dart';
import 'package:corezap_driver/utilities/form_field.dart';
import 'package:corezap_driver/utilities/navigator.dart';
import 'package:corezap_driver/views/bottomNavigation/bottomNavMain_screen.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../apis/driver_detail_apis.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({super.key});

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
  final _vehicleFormKey = GlobalKey<FormState>();
  final _personalFormKey = GlobalKey<FormState>();

  Auth authController = Get.put(Auth());
  final DocumentUploadController uploadController = Get.put(
    DocumentUploadController(),
  );
  final DriverFormController driverFormController = Get.put(
    DriverFormController(),
  ); // FIXED: Avoid init crash  // add your vehicle textfields cotroller
  final DashBoardApis createvechicleController = Get.put(DashBoardApis());
  final DashBoardApis driverid =
      Get.find<DashBoardApis>(); // TextField controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailControlller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorControlller = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();

  TextEditingController plateNumberController = TextEditingController();
  TextEditingController alternateContactNumber1Controller =
      TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController alternateContactNumber2Controller =
      TextEditingController();
  TextEditingController relation2Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();

  // global key
  // GlobalKeys for document uploaders
  final GlobalKey<CustomDocumentUploaderState> licenceKey =
      GlobalKey<CustomDocumentUploaderState>();
  final GlobalKey<CustomDocumentUploaderState> insuranceKey =
      GlobalKey<CustomDocumentUploaderState>();
  final GlobalKey<CustomDocumentUploaderState> aadharFrontKey =
      GlobalKey<CustomDocumentUploaderState>();
  final GlobalKey<CustomDocumentUploaderState> aadharBackKey =
      GlobalKey<CustomDocumentUploaderState>();
  final GlobalKey<CustomDocumentUploaderState> panKey =
      GlobalKey<CustomDocumentUploaderState>();
  final GlobalKey<CustomDocumentUploaderState> driverLicenceKey =
      GlobalKey<CustomDocumentUploaderState>();
  final GlobalKey<CustomDocumentUploaderState> profileImageKey =
      GlobalKey<CustomDocumentUploaderState>();

  String imagePath = "";
  int activeStep = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // driverFormController.resetSteps();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: ColorsList.scaffoldColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: w * .03,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (driverFormController.documentnav.value) {
                  if (driverFormController.activeStep.value > 1 &&
                      driverFormController.activeStep.value <= 3) {
                    driverFormController.activeStep.value--;
                  } else if (driverFormController.activeStep.value == 1) {
                    driverFormController.resetSteps();
                    driverFormController.documentnav.value = false;
                    driverFormController.selecIndex.value = 1;
                    CustomNavigator.pop(context);
                  }
                }
                //  driverFormController.resetSteps();
                else if (driverFormController.activeStep.value > 0 &&
                    driverFormController.activeStep.value <= 3) {
                  driverFormController.activeStep.value--;
                } else if (driverFormController.activeStep.value == 0) {
                  CustomNavigator.pop(context);
                } else {
                  print(".. condition");
                  CustomNavigator.pop(context);
                }
              },
              child: Icon(
                Icons.arrow_back,
                size: w * .07,
                color: ColorsList.iconColor,
              ),
            ),
            SizedBox(width: w * .02),
            CustomText(
              text: "Driver Registration",
              textColor: ColorsList.titleTextColor,
              textFontSize: w * .05,
              textFontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Obx(
            () => EasyStepper(
              activeStep: driverFormController.activeStep.value,
              lineStyle: LineStyle(
                lineType: LineType.normal,
                unreachedLineType: LineType.normal,
                defaultLineColor: AppColors.lightGray,
                finishedLineColor: AppColors.primaryRed,
                lineLength: w * .18,
                lineThickness: 2,
              ),
              internalPadding: 0,
              stepRadius: w * 0.04,
              showStepBorder: false,
              steps: [
                //                  Preference
                // Vehicle Details
                // Personal Details
                // Profile Photo
                buildStep(
                  0,
                  'Preference',
                  w,
                  driverFormController.activeStep.value,
                ),
                buildStep(
                  1,
                  'Vehicle Details',
                  w,
                  driverFormController.activeStep.value,
                ),
                buildStep(
                  2,
                  'Personal Details',
                  w,
                  driverFormController.activeStep.value,
                ),
                buildStep(
                  3,
                  'Profile Photo',
                  w,
                  driverFormController.activeStep.value,
                ),
              ],
              onStepReached: (index) => driverFormController.reachStep(index),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // preference activestep 0
                  children: [
                    Obx(
                      () => driverFormController.activeStep.value == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: w * .03,
                                  ),
                                  child: AppFonts.textPoppins(
                                    context,
                                    "Tell us your vehicle preference",
                                    w * 0.045,
                                    FontWeight.w600,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                ),
                                // decoration: BoxDecoration(
                                //   color: AppColors.white,
                                //   boxShadow: [
                                //     BoxShadow(
                                //       color: Colors.grey.withOpacity(0.2),
                                //       spreadRadius: 2,
                                //       blurRadius: 3,
                                //     ),
                                //   ],
                                //   borderRadius: BorderRadius.circular(w * 0.03),
                                // ),
                                //  ? documents screen same preference----

                                //?--------have vehicle-------------
                                SizedBox(height: w * .02),
                                InkWell(
                                  onTap: () {
                                    driverFormController.hasVehicle.value =
                                        true;
                                    driverFormController.activeStep.value = 1;
                                    // CustomNavigator.push(
                                    //   context,
                                    //   DriverRegistration(),
                                    //   transition: TransitionType.slideLeft,
                                    // );
                                  },
                                  child: Container(
                                    // width: w * 0.8,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                        w * 0.03,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          child: Image.asset(
                                            "assets/images/vehicle1.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(height: w * .03),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: w * .03,
                                          ),
                                          child: AppFonts.textPoppins(
                                            context,
                                            "I have a vehicle",
                                            w * 0.05,
                                            FontWeight.w600,
                                            AppColors.black,
                                            TextAlign.center,
                                            TextOverflow.visible,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: w * .03,
                                          ),
                                          child: AppFonts.textPoppins(
                                            context,
                                            "Register your vehicle to begin driving. A quick verification will get you on the road.",
                                            w * 0.038,
                                            FontWeight.w500,
                                            AppColors.mediumGray,
                                            TextAlign.left,
                                            TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(height: w * .03),

                                        SizedBox(height: w * .03),
                                      ],
                                    ),
                                  ),
                                ),

                                //?------need vehicle
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: w * .05,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      driverFormController.hasVehicle.value =
                                          false;
                                      driverFormController.activeStep.value = 2;
                                      // CustomNavigator.push(
                                      //   context,
                                      //   DriverRegistration(),
                                      //   transition: TransitionType.slideLeft,
                                      // );
                                    },
                                    child: Container(
                                      // width: w * 0.8,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(
                                          w * 0.03,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            child: Image.asset(
                                              "assets/images/needVehicle.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          SizedBox(height: w * .03),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: w * .03,
                                            ),
                                            child: AppFonts.textPoppins(
                                              context,
                                              "I need a vehicle",
                                              w * 0.05,
                                              FontWeight.w600,
                                              AppColors.black,
                                              TextAlign.center,
                                              TextOverflow.visible,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: w * .03,
                                            ),
                                            child: AppFonts.textPoppins(
                                              context,
                                              "Don’t have a vehicle? We’ll help you get one to start driving.",
                                              w * 0.038,
                                              FontWeight.w500,
                                              AppColors.mediumGray,
                                              TextAlign.left,
                                              TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(height: w * .06),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: w * .1),
                              ],
                            )
                          : driverFormController.activeStep.value == 1
                          ? Form(
                              key: _vehicleFormKey,
                              //  Add a GlobalKey<FormState> above in your class
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: w * .01,
                                    ),
                                    child: AppFonts.textPoppins(
                                      context,
                                      "Add your vehicle",
                                      w * 0.06,
                                      FontWeight.w500,
                                      AppColors.black,
                                      TextAlign.left,
                                      TextOverflow.visible,
                                    ),
                                  ),
                                  AppFonts.textPoppins(
                                    context,
                                    "Add your car, bike, or auto – drive your way.",
                                    w * 0.036,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .04),

                                  // VEHICLE TYPE
                                  AppFonts.textPoppins(
                                    context,
                                    "Vehicle type",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. Car",
                                    controller: vehicleTypeController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Vehicle type is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),

                                  // MODEL
                                  AppFonts.textPoppins(
                                    context,
                                    "Model",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. Swift Dzire",
                                    controller: modelController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Model is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),

                                  // YEAR + COLOR
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppFonts.textPoppins(
                                            context,
                                            "Year",
                                            w * 0.04,
                                            FontWeight.w500,
                                            AppColors.black,
                                            TextAlign.left,
                                            TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: w * .01),
                                          AppFormFields.custTextFormOther(
                                            context: context,
                                            hintText: "e.g. 2014",
                                            controller: yearController,
                                            width: w * .45,
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Year is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppFonts.textPoppins(
                                            context,
                                            "Color",
                                            w * 0.04,
                                            FontWeight.w500,
                                            AppColors.black,
                                            TextAlign.left,
                                            TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: w * .01),
                                          AppFormFields.custTextFormOther(
                                            context: context,
                                            hintText: "e.g. Black",
                                            controller: colorControlller,
                                            width: w * .45,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Color is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: w * .04),

                                  // LICENCE PLATE NUMBER
                                  AppFonts.textPoppins(
                                    context,
                                    "Licence Plate Number",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. 6WED298",
                                    controller: plateNumberController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Licence plate number is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),

                                  // --- DOCUMENT UPLOAD (unchanged as you said) ---
                                  AppFonts.textPoppins(
                                    context,
                                    "Photo of Licence Plate Number",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  CustomDocumentUploader(
                                    key: licenceKey,
                                    width: w,
                                    height: w * .4,
                                    borderRadius: 5,
                                    uploadText: 'Upload',
                                    borderColor: AppColors.black,
                                    uploaderKey: 'Licence',
                                    isRequired: true,
                                  ),
                                  AppFonts.textPoppins(
                                    context,
                                    "Make sure your vehicle’s licence plate number photo are clear and visible.",
                                    w * 0.025,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: w * .04),

                                  AppFonts.textPoppins(
                                    context,
                                    "Photo of Vehicle Insurance",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  CustomDocumentUploader(
                                    key: insuranceKey,
                                    isRequired: true,
                                    width: w,
                                    height: w * .4,
                                    borderRadius: 5,
                                    uploadText: 'Upload',
                                    borderColor: AppColors.black,
                                    uploaderKey: 'Vehicle Insurance',
                                  ),
                                  AppFonts.textPoppins(
                                    context,
                                    "Make sure your vehicle’s insurance photo are clear and visible.",
                                    w * 0.025,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: w * .1),

                                  // CONTINUE BUTTON
                                  AppButtons.solid(isLoading: createvechicleController.loading.value,
                                    context: context,
                                    text: "Continue",
                                    onClicked: () async {
                                      if (_vehicleFormKey.currentState!
                                          .validate()) {
                                        final File? licenceImage =
                                            uploadController.getImage(
                                              "Licence",
                                            );
                                        final File? driverlicence =
                                            uploadController.getImage(
                                              'Vehicle Insurance',
                                            );
                                        await createvechicleController
                                            .createVehicle(
                                              vehicleColor:
                                                  colorControlller.text,
                                              vehicleYear: yearController.text,

                                              vehicleName: modelController.text,
                                              vehicleNumber:
                                                  plateNumberController.text,
                                              vehicleType:
                                                  vehicleTypeController.text,
                                              vehicleStatus: "Active",
                                              vehicleModel:
                                                  modelController.text,
                                              vehicleCapacity: "2",
                                              driverId:
                                                  SessionManager.getDriverId()
                                                      .toString(),
                                              vehicleImage: licenceImage,
                                              vehicleInsuraneImage:
                                                  driverlicence,
                                            );

                                        // all fields filled
                                        driverFormController.activeStep.value =
                                            2;
                                      }
                                    },
                                    isFullWidth: true,
                                    backgroundColor: AppColors.primaryRed,
                                    textColor: AppColors.white,
                                    fontSize: w * .045,
                                    height: w * .140,
                                    radius: 12.0,
                                  ),
                                  SizedBox(height: w * .1),
                                ],
                              ),
                            )
                          : driverFormController.activeStep.value == 2
                          ? Form(
                              key:
                                  _personalFormKey, //  add this key at top of class
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: w * .01,
                                    ),
                                    child: AppFonts.textPoppins(
                                      context,
                                      "Add your Personal Details",
                                      w * 0.06,
                                      FontWeight.w500,
                                      AppColors.black,
                                      TextAlign.left,
                                      TextOverflow.visible,
                                    ),
                                  ),
                                  AppFonts.textPoppins(
                                    context,
                                    "Fill in your details to become a verified driver.",
                                    w * 0.036,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .04),

                                  // NAME
                                  AppFonts.textPoppins(
                                    context,
                                    "Name",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. Mahavir",
                                    controller: nameController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),

                                  // PHONE NUMBER
                                  AppFonts.textPoppins(
                                    context,
                                    "Phone Number",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. 9865431062",
                                    controller: phoneNumberController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Phone number is required';
                                      } else if (value.length != 10) {
                                        return 'Enter a valid 10-digit number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),

                                  // DATE OF BIRTH
                                  AppFonts.textPoppins(
                                    context,
                                    "Date of Birth",
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
                                    controller: dateOfBirthController,
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Date of birth is required';
                                      }
                                      return null;
                                    },
                                    onClicked: () async {
                                      DateTime initialDate = DateTime.now()
                                          .subtract(
                                            const Duration(days: 365 * 20),
                                          );
                                      DateTime firstDate = DateTime(1900);
                                      DateTime lastDate = DateTime.now();

                                      final DateTime? picked =
                                          await showDatePicker(
                                            context: context,
                                            initialDate: initialDate,
                                            firstDate: firstDate,
                                            lastDate: lastDate,
                                          );

                                      if (picked != null) {
                                        setState(() {
                                          dateOfBirthController.text =
                                              DateFormat(
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

                                  // EMAIL
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
                                    hintText: "e.g. Mahavir@gmail.com",
                                    controller: emailControlller,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Email is required';
                                      }
                                      final emailRegex = RegExp(
                                        r'^[\w\.\-]+@[a-zA-Z\d\-]+\.[a-zA-Z]{2,}$',
                                      );
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Alternate Contact (1)",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. 9865431062",
                                    controller:
                                        alternateContactNumber1Controller,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Relation",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. Mother",
                                    controller: relationController,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Address",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. Bhopal",
                                    controller: address1Controller,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Alternate Contact (2)",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. 9865431062",
                                    controller:
                                        alternateContactNumber2Controller,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Relation",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. Mother",
                                    controller: relation2Controller,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Address",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. Bhopal",
                                    controller: address2Controller,
                                  ),
                                  SizedBox(height: w * .04),
                                  // AADHAR NUMBER (NEW)
                                  AppFonts.textPoppins(
                                    context,
                                    "Aadhar Number",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. 123456789012",
                                    controller: aadharNumberController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 12,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Aadhar number is required';
                                      }
                                      if (value.length != 12 ||
                                          int.tryParse(value) == null) {
                                        return 'Enter a valid 12-digit Aadhar number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),

                                  // PAN NUMBER (NEW)
                                  AppFonts.textPoppins(
                                    context,
                                    "PAN Number",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: w * .01),
                                  AppFormFields.custTextFormOther(
                                    context: context,
                                    hintText: "e.g. ABCDE1234F",
                                    controller: panNumberController,
                                    // textCapitalization: TextCapitalization.characters, // Auto uppercase
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'PAN number is required';
                                      }
                                      value = value.toUpperCase().trim();
                                      if (value.length != 10) {
                                        return 'PAN must be exactly 10 characters';
                                      }
                                      final panRegex = RegExp(
                                        r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
                                      );
                                      if (!panRegex.hasMatch(value)) {
                                        return 'Enter a valid PAN format (e.g., ABCDE1234F)';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Upload Photo of Aadhar Card (Front)",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  // upload documnet
                                  CustomDocumentUploader(
                                    key: aadharFrontKey,
                                    isRequired: true,
                                    width: w,
                                    height: w * .4,
                                    borderRadius: 5,
                                    // onUploadPressed: () {
                                    //   // Handle file upload logic here, e.g., show file picker.
                                    // },
                                    uploadText: 'Upload',
                                    borderColor: AppColors.black,
                                    uploaderKey: 'Aadhar Card (Front)',
                                  ),
                                  //    Make sure your vehicle’s licence plate number photo are clear and visible.
                                  AppFonts.textPoppins(
                                    context,
                                    "Make sure your Front Aadhar card photo are clear and visible.",
                                    w * 0.025,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Upload Photo of Aadhar Card (Back)",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  CustomDocumentUploader(
                                    key: aadharBackKey,
                                    isRequired: true,
                                    width: w,
                                    height: w * .4,
                                    borderRadius: 5,
                                    // onUploadPressed: () {
                                    //   // Handle file upload logic here, e.g., show file picker.
                                    // },
                                    uploadText: 'Upload',
                                    borderColor: AppColors.black,
                                    uploaderKey: 'Aadhar Card',
                                  ),
                                  //    Make sure your vehicle’s licence plate number photo are clear and visible.
                                  AppFonts.textPoppins(
                                    context,
                                    "Make sure your Aadhar card back photo are clear and visible.",
                                    w * 0.025,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Upload Photo of PAN Card",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  CustomDocumentUploader(
                                    key: panKey,
                                    isRequired: true,
                                    width: w,
                                    height: w * .4,
                                    borderRadius: 5,
                                    // onUploadPressed: () {
                                    //   // Handle file upload logic here, e.g., show file picker.
                                    // },
                                    uploadText: 'Upload',
                                    borderColor: AppColors.black,
                                    uploaderKey: 'PAN Card',
                                  ),
                                  //    Make sure your vehicle’s licence plate number photo are clear and visible.
                                  AppFonts.textPoppins(
                                    context,
                                    "Make sure your PAN card photo are clear and visible.",
                                    w * 0.025,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: w * .04),
                                  AppFonts.textPoppins(
                                    context,
                                    "Upload Photo of Driver License",
                                    w * 0.04,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.ellipsis,
                                  ),
                                  CustomDocumentUploader(
                                    key: driverLicenceKey,
                                    isRequired: true,
                                    width: w,
                                    height: w * .4,
                                    borderRadius: 5,
                                    // onUploadPressed: () {
                                    //   // Handle file upload logic here, e.g., show file picker.
                                    // },
                                    uploadText: 'Upload',
                                    borderColor: AppColors.black,
                                    uploaderKey: 'Driver License',
                                  ),
                                  //    Make sure your vehicle’s licence plate number photo are clear and visible.
                                  AppFonts.textPoppins(
                                    context,
                                    "Make sure your driver license photo are clear and visible.",
                                    w * 0.025,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: w * .1),

                                  AppButtons.solid(isLoading: createvechicleController.loading.value,
                                    context: context,
                                    text: "Continue",
                                    onClicked: () async {
                                      if (_personalFormKey.currentState!
                                          .validate()) {
                                        // Debug each doc
                                        print("=== Step2 Doc Debug ===");
                                        final isAadharFront = uploadController
                                            .isValid('Aadhar Card (Front)');
                                        print(
                                          "AadharFront: $isAadharFront | Path: ${uploadController.getImage('Aadhar Card (Front)')?.path ?? 'NULL'}",
                                        );
                                        final isAadharBack = uploadController
                                            .isValid('Aadhar Card');
                                        print(
                                          "AadharBack: $isAadharBack | Path: ${uploadController.getImage('Aadhar Card')?.path ?? 'NULL'}",
                                        );
                                        final isPan = uploadController.isValid(
                                          'PAN Card',
                                        );
                                        print(
                                          "Pan: $isPan | Path: ${uploadController.getImage('PAN Card')?.path ?? 'NULL'}",
                                        );
                                        final isDriverLicence = uploadController
                                            .isValid('Driver License');
                                        print(
                                          "DriverLicence: $isDriverLicence | Path: ${uploadController.getImage('Driver License')?.path ?? 'NULL'}",
                                        );
                                        print("=== End Debug ===");

                                        if (!isAadharFront ||
                                            !isAadharBack ||
                                            !isPan ||
                                            !isDriverLicence) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Please upload all required documents before continuing.',
                                              ),
                                            ),
                                          );
                                          return;
                                        }
                                        print(
                                          "Step2: All docs valid → To Step 3",
                                        );
                                        await createvechicleController
                                            .createProfile(
                                              name: nameController.text,
                                              email: emailControlller.text,
                                              aadharNumber:
                                                  aadharNumberController.text,
                                              panNumber:
                                                  panNumberController.text,
                                              // image: image,
                                              // rcImage: rcImage,
                                              dlImage: uploadController
                                                  .getImage('Driver License'),
                                              aadharFront: uploadController
                                                  .getImage(
                                                    'Aadhar Card (Front)',
                                                  ),
                                              aadharBack: uploadController
                                                  .getImage('Aadhar Card'),
                                              panImage: uploadController
                                                  .getImage('PAN Card'),
                                            );
                                        driverFormController.activeStep.value =
                                        3;
                                      }
                                    },
                                    isFullWidth: true,
                                    backgroundColor: AppColors.primaryRed,
                                    textColor: AppColors.white,
                                    fontSize: w * .045,
                                    height: w * .140,
                                    radius: 12.0,
                                  ),
                                  SizedBox(height: w * .1),
                                ],
                              ),
                            )
                          : driverFormController.activeStep.value == 3
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: w * .01,
                                  ),
                                  child: AppFonts.textPoppins(
                                    context,
                                    "Add Profile Photo",
                                    w * 0.06,
                                    FontWeight.w500,
                                    AppColors.black,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                  ),
                                ),

                                SizedBox(
                                  width: w * .8,
                                  child: AppFonts.textPoppins(
                                    context,
                                    "Upload a recent photo of yourself (no sunglasses, no mask).",
                                    w * 0.036,
                                    FontWeight.w500,
                                    AppColors.mediumGray,
                                    TextAlign.left,
                                    TextOverflow.visible,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(height: w * .02),
                                Center(
                                  child: Column(
                                    children: [
                                      CustomDocumentUploader(
                                        key: profileImageKey,
                                        width: w * .55,
                                        height: w * .55,
                                        isCircular: true,
                                        isRequired: true,
                                        // onUploadPressed: () {
                                        //   // Handle file upload logic here, e.g., show file picker.
                                        // },
                                        uploadText: 'Upload',
                                        borderColor: AppColors.black,
                                        uploaderKey: 'photo',
                                      ),
                                      SizedBox(
                                        width: w * .7,
                                        child: AppFonts.textPoppins(
                                          context,
                                          "Your profile photo must clearly show your face.",
                                          w * 0.036,
                                          FontWeight.w500,
                                          AppColors.mediumGray,
                                          TextAlign.center,
                                          TextOverflow.visible,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: w * .4),

                                AppButtons.solid(isLoading: createvechicleController.loading.value,
                                  context: context,
                                  text: "Submit",
                                  onClicked: () async {
                                    await createvechicleController.editProfile(
                                      name: nameController.text.trim(),
                                      id: SessionManager.getDriverId()
                                          .toString(),
                                      rcImage: uploadController.getImage(
                                        "photo",
                                      ),
                                    );
                                    if (createvechicleController
                                            .updateSuccess
                                            .value ==
                                        true) {
                                      CustomNavigator.push(
                                        context,
                                        BottomnavmainScreen(),
                                      );
                                    } else {}
                                  },
                                  isFullWidth: true,
                                  backgroundColor: AppColors.primaryRed,
                                  textColor: AppColors.white,
                                  fontSize: w * .045,
                                  height: w * .140,
                                  radius: 12.0,
                                ),

                                SizedBox(height: w * .1),
                              ],
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //?----------------method
  EasyStep buildStep(int stepIndex, String title, double w, int activeStep) {
    bool isActive = activeStep >= stepIndex;

    return EasyStep(
      customStep: isActive
          ? CircleAvatar(
              radius: w * 0.04,
              backgroundColor: AppColors.primaryRed,
              child: Icon(Icons.check, size: w * 0.045, color: AppColors.white),
            )
          : CircleAvatar(
              radius: w * 0.04,
              backgroundColor: AppColors.lightGray,
              child: CircleAvatar(
                radius: w * 0.025,
                backgroundColor: AppColors.white,
              ),
            ),
      // title:  title,
      customTitle: AppFonts.textPoppins(
        context,
        title,
        w * 0.025,
        FontWeight.w400,
        AppColors.black,
        TextAlign.center,
        TextOverflow.ellipsis,
      ),
    );
  }
}
