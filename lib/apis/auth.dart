import 'dart:io';

import 'package:corezap_driver/apis/urls.dart';
import 'package:corezap_driver/session/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Auth extends GetxController {
  var tempProfileImage = ''.obs;
  RxInt totalSells = 0.obs;
  RxInt todaySell = 0.obs;
  RxInt totalReplaces = 0.obs;
  RxInt pendingReplacements = 0.obs;
  RxBool loading = false.obs;

  // profile data
  RxString profileImage = ''.obs;
  RxString shopName = ''.obs;
  RxString email = ''.obs;
  RxString userAddress = ''.obs;
  RxString landmark = ''.obs;
  RxString pinCode = ''.obs;
  RxString district = ''.obs;
  RxString state = ''.obs;

  //===========
  RxString role = ''.obs;
  RxString phoneNumber = ''.obs;

  RxString userExistMessage = ''.obs;
  RxBool successotpverify = false.obs;
  RxString token = ''.obs;
  RxString userId = ''.obs;
  RxBool successotpsent = false.obs;

  // Rx<GetUserByIdModel?> userModel = Rx(GetUserByIdModel());
  RxString shopOwnerHomeImage = ''.obs;
  RxString name = ''.obs;
  RxString userType = ''.obs;
  RxInt currentIndex = 0.obs;

  // wallet params
  // new
  RxBool userExist = false.obs;
  RxBool sendOtpSuccessfully = false.obs;
  RxBool otpVerify = false.obs;
  RxBool otpLoading = true.obs;

  RxString otp = "".obs;

  // Text fields
  // var name = ''.obs;
  // var email = ''.obs;
  // var phoneNumber = ''.obs;
  var aadharNumber = ''.obs;
  var panNumber = ''.obs;

  // File paths (observables for images)
  var rcImagePath = ''.obs;
  var dlImagePath = ''.obs;
  var aadharFrontPath = ''.obs;
  var aadharBackPath = ''.obs;
  var panImagePath = ''.obs;
  var profileImagePath = ''.obs;
  var otpMessage = ''.obs;
  var driverId = ''.obs;
  RxBool registerSuccess = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool checkRagister = false.obs;
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Auto-check on app start
  }

  Future<void> checkLoginStatus() async {
    final savedToken = await SessionManager.getToken();

    if (savedToken != null && savedToken.isNotEmpty) {
      token.value = savedToken;
      isLoggedIn.value = true;
      print("Auto Login Success - Token Found");
    } else {
      isLoggedIn.value = false;
    }
  }

  Future<void> registerDriverApi({
    required String name,
    required String email,
    required String aadharNumber,
    required String panNumber,
    required String phoneNumber,
    required Map<String, File?> uploadedFiles,
  }) async {
    try {
      loading.value = true;
      print(
        "Running registerDriverApi - Name: $name, Email: $email, Aadhar: $aadharNumber, PAN: $panNumber, Phone: $phoneNumber",
      );
      print(
        "Files: ${uploadedFiles.length} total (non-null: ${uploadedFiles.values.where((f) => f != null).length})",
      );

      var uri = Uri.parse("${Urls.baseUrl}/driver/register");
      var request = http.MultipartRequest("POST", uri);

      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['aadharNumber'] = aadharNumber;
      request.fields['panNumber'] = panNumber;
      request.fields['phone'] = phoneNumber;

      // Attach files safely
      for (var entry in uploadedFiles.entries) {
        String key = entry.key;
        File? file = entry.value;
        if (file != null && await file.exists()) {
          print("Attaching file: $key - ${file.path}");
          request.files.add(await http.MultipartFile.fromPath(key, file.path));
        } else {
          print("Skipping null/missing file: $key");
        }
      }

      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("Raw Response: Status=${response.statusCode}, Body=$respStr");

      if (response.statusCode == 200) {
        try {
          final jsonData = jsonDecode(respStr);
          print("Parsed JSON: $jsonData");

          if (jsonData['success'] == true || jsonData['status'] == 'success') {
            print(
              "Success: ${jsonData['message'] ?? 'Driver registered successfully'}",
            );
            registerSuccess.value = true;

            if (Get.context != null) {
              ScaffoldMessenger.of(Get.context!).showSnackBar(
                SnackBar(
                  content: Text(
                    jsonData['message'] ?? "Driver registered successfully!",
                  ),
                ),
              );
            } else {
              print("⚠ Snackbar skipped: context is null");
            }
          } else {
            final errorMsg = jsonData['message'] ?? 'Registration failed';
            print("Backend Error: $errorMsg");

            if (Get.context != null) {
              ScaffoldMessenger.of(
                Get.context!,
              ).showSnackBar(SnackBar(content: Text(errorMsg)));
            } else {
              print("⚠ Snackbar skipped: context is null");
            }
          }
        } catch (parseE) {
          print("JSON Parse Error: $parseE - Raw: $respStr");
          if (Get.context != null) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              const SnackBar(
                content: Text("Invalid server response. Check data."),
              ),
            );
          }
        }
      } else {
        try {
          final jsonData = jsonDecode(respStr);
          final errorMsg =
              jsonData['message'] ?? 'Server error: ${response.statusCode}';
          if (Get.context != null) {
            ScaffoldMessenger.of(
              Get.context!,
            ).showSnackBar(SnackBar(content: Text(errorMsg)));
          }
        } catch (_) {
          if (Get.context != null) {
            ScaffoldMessenger.of(Get.context!).showSnackBar(
              SnackBar(content: Text("Server error ${response.statusCode}")),
            );
          }
        }
      }
    } catch (e) {
      print("API Exception: $e");
      if (Get.context != null) {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(SnackBar(content: Text("Network/Upload error: $e")));
      }
    } finally {
      loading.value = false;
    }
  }

  // ... (rest unchanged)

  Future<void> userExistApi(String number) async {
    try {
      loading.value = true;
      print("Running checkUserExistApi");
      print("Phone Number: $number");

      phoneNumber.value = number;

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/isUserExist?phone=$number"),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Response Datauser : $jsonData");

        userExist.value = jsonData['success'];
        print(userExist.value);
        // userExistMessage.value = jsonData['message'] ?? '';
      } else {
        print(" API Error - Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        userExist.value = false;
        userExistMessage.value =
            "Something went wrong! (${response.statusCode})";
      }
    } catch (e) {
      print(" Exception in userExistApi: $e");
      userExist.value = false;
      userExistMessage.value = "An error occurred. Please try again.";
    } finally {
      loading.value = false;
    }
  }

  Future<void> sendOtpApi() async {
    try {
      // loading.value = true;
      print("Running sentOtp");
      print("Phone Number: ${phoneNumber.value}");

      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/driver/registerLogin"),
        body: {"phone": phoneNumber.value},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Response Data: $jsonData");

        sendOtpSuccessfully.value = jsonData['success'];
        print(sendOtpSuccessfully.value);
        // userExistMessage.value = jsonData['message'] ?? '';
      } else {
        print(" API Error - Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        userExist.value = false;
        userExistMessage.value =
            "Something went wrong! (${response.statusCode})";
      }
    } catch (e) {
      print(" Exception in sendOtpSuccessfully: $e");
      userExist.value = false;
      userExistMessage.value = "An error occurred. Please try again.";
    } finally {
      loading.value = false;
    }
  }

  //  --- verify otp----
  Future<void> verifyOtpApi() async {
    try {
      loading.value = true;
      print("Running verify otp");
      print("Phone: ${phoneNumber.value}");
      print("OTP: ${otp.value}");

      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/driver/verifyOtp"),
        body: {
          "phone": phoneNumber.value,
          "otp": otp.value,
          "fcmToken":
              "jhgoernggoojrngojerngorengojrengojerngojrngnergjnrgregnregojerngre",
          "deviceId": "sybccifrfiug931pj",
        },
      );

      print("Response status: ${response.statusCode}");
      print("Responseotp verify body: ${response.body}");
      print("Responseotp verify body: ${response.body}");
      // ✅ Decode JSON
      final data = jsonDecode(response.body);
      print("Responseotp verify bodysucesssssss: ${data['success']}");
      print("Responseotp verify bodysucesssssss: ${data['driver']['id']}");
      if (response.statusCode == 200 && data['success'] == true) {
        otpVerify.value = true;
        otpMessage.value = data['message'];
        driverId.value = data['driver']['id'];
        checkRagister.value = data['driver']['isProfileCompleted'];
        SessionManager.saveSession(
          token: data['token'].toString(),
          driverId: data['driver']['id'].toString(),
        );

        print(
          "✅ OTP Verified Successfully!${SessionManager.getToken().toString()}",
        );
      } else {
        otpVerify.value = false;
        otpMessage.value = data['message'];
        print("❌ OTP verification failed: ${data['message']}");
      }
    } catch (e) {
      otpVerify.value = false;
      print("⚠️ Exception in verifyOtpApi: $e");
    } finally {
      loading.value = false;
    }
  }
}
