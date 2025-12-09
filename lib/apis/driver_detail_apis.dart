import 'dart:convert';
import 'dart:io';

import 'package:corezap_driver/apis/urls.dart';
import 'package:corezap_driver/session/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class DashBoardApis extends GetxController {
  RxBool loading = false.obs;

  // Reactive variables for driver profile
  var driverName = ''.obs;
  var driverPhone = ''.obs;
  var driverEmail = ''.obs;
  var driverImage = ''.obs;
  var driverId = ''.obs;

  RxBool updateSuccess = false.obs;
  RxString message = ''.obs;
  RxBool driverStatus = false.obs;
  RxBool checkvehicle = false.obs;
  RxString vehiclemessage = "".obs;
  RxString vehicleId = ''.obs;

  Future<void> DriverProfile(String id) async {
    try {
      //loading.value = true;
      print("📡 Fetching driver profile for ID: $id");

      // 🔑 Get saved token
      final token = await SessionManager.getToken();
      print("🔑 Retrieved token: $token");

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/driver/getDriverProfile/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // 👈 Token added here
        },
      );

      print("🔹get driverrrrrrrrrrrr Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("✅ Response Datadriverrrrrrr: $jsonData");

        if (jsonData['success'] == true && jsonData['driver'] != null) {
          final driver = jsonData['driver'];

          driverName.value = driver['name'] ?? '';
          driverEmail.value = driver['email'] ?? '';
          driverPhone.value = driver['phone'] ?? '';
          driverImage.value =
              "https://leadkart.in-maa-1.linodeobjects.com/${driver['image']}";
          vehicleId.value = driver['vehicleId']['vehicleType'] ?? '';
          print("vehicleIddddddddd${vehicleId.value}");
        } else {
          print("⚠️ Unexpected response: $jsonData");
        }
      } else {
        print("❌ API Error - Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (e) {
      print("🚨 Exception in DriverProfile(): $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> editProfile({
    required String id,
    required String name,
    required File? rcImage, // this should be a file path
  }) async {
    try {
      loading.value = true;
      print("📡 Updating driver profile for ID: $id");

      // 🔑 Get saved token
      final token = await SessionManager.getToken();
      print("🔑 Retrieved token: $token");

      // ✅ Use MultipartRequest for file upload
      var request = http.MultipartRequest(
        'PUT', // or 'POST' depending on your API
        Uri.parse("${Urls.baseUrl}/driver/update/userId=$id&userType=Driver")
      );

      // Add headers
      request.headers.addAll({"Authorization": "Bearer $token"});

      // Add text fields
      request.fields['name'] = name;

      // Add file field (must match multer field name)
      if (rcImage != null) {
        print("📷 Uploading RC Image: ${rcImage.path}");

        request.files.add(
          await http.MultipartFile.fromPath("rcImage", rcImage.path),
        );
      }

      // Send request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("🔹 Status Code: ${response.statusCode}");
      print("🔹 Response: $responseBody");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(responseBody);
        if (jsonData['success'] == true) {
          final driver = jsonData['driver'];
          updateSuccess.value = true;
          driverName.value = driver['name'] ?? '';
          driverEmail.value = driver['email'] ?? '';
          driverPhone.value = driver['phone'] ?? '';
          driverImage.value =
              "https://leadkart.in-maa-1.linodeobjects.com/${driver['RcImage']}";
          print("✅ Profile updated successfully${driverImage.value}");
        } else {
          print("⚠️ Unexpected response: $jsonData");
        }
      } else {
        print("❌ API Error - Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Exception in editProfile(): $e");
    } finally {
      loading.value = false;
    }
  }

  // Future<void> toggleDriverStatus({required String id}) async {
  //   print("sesion driveridddddddd${SessionManager.getDriverId().toString()}");
  //   try {
  //     final token = await SessionManager.getToken();
  //     print("📡 API URL: ${Urls.baseUrl}/driver/toggleDuty/$id");
  //     print("🔑 Token: $token");

  //     final response = await http.patch(
  //       Uri.parse(
  //         "https://corezap.framekarts.com/api/v1/driver/toggleDuty/$id",
  //       ),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer $token",
  //       },
  //     );

  //     print("🧾 Response body: ${response.body}");
  //     final jsonData = jsonDecode(response.body);

  //     if (response.statusCode == 200 && jsonData["success"] == true) {
  //       driverStatus.value = jsonData["driver"]["startDuty"];
  //       // Get.snackbar(
  //       //   "Status",
  //       //   driverStatus.value ? "You are now Online" : "You are now Offline",
  //       //   snackPosition: SnackPosition.BOTTOM,
  //       // );
  //     } else {
  //       // Get.snackbar("Error", jsonData["message"] ?? "Something went wrong");
  //     }
  //   } catch (e) {
  //     print("🚨 Error in toggleDriverStatus: $e");
  //     // Get.snackbar("Error", "Unable to update status");
  //   }
  // }
  // newww 03/12.2025
  Future<void> toggleDriverStatus({required String id}) async {
    print("Toggling duty status for driver: $id");

    try {
      final token = await SessionManager.getToken();

      final response = await http.patch(
        Uri.parse(
          "https://corezap.framekarts.com/api/v1/driver/toggleDuty/$id",
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Toggle API Response: ${response.body}");
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData["success"] == true) {
        // YE LINE HATA DO YA COMMENT KAR DO
        driverStatus.value = jsonData["driver"]["startDuty"];

        // Ab status sirf user action se control hoga, backend se nahi
        print("Status toggled on backend. UI controlled locally.");

        // Optional: SnackBar dikhao
        // Get.snackbar(
        //   "Status Updated",
        //   jsonData["driver"]["startDuty"] == true ? "You are now Online" : "You are now Offline",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.black87,
        //   colorText: Colors.white,
        //   duration: Duration(seconds: 2),
        // );
      }
    } catch (e) {
      print("Error in toggleDriverStatus: $e");
      // API fail bhi ho to UI change mat karo
    }
  }

  Future<void> createVehicle({
    required String vehicleColor,
    required String vehicleYear,
    required String vehicleName,
    required String vehicleNumber,
    required String vehicleType,
    required String vehicleStatus,
    required String vehicleModel,
    required String vehicleCapacity,
    required String driverId,
    required File? vehicleImage,
    required File? vehicleInsuraneImage,
  }) async {
    try {
      loading.value = true;
      print("📡 Creating new vehicle...");

      final token = await SessionManager.getToken();
      print("🔑 Token: $token");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Urls.baseUrl}/createVehicle"),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // ------------ TEXT FIELDS ------------
      request.fields.addAll({
        "vehicleColor": vehicleColor,
        "vehicleYear": vehicleYear,
        "vehicleName": vehicleName,
        "vehicleNumber": vehicleNumber,
        "vehicleType": "6913170fad6f5c2b199b52fb",
        "vehicleStatus": "Active",
        "vehicleModel": vehicleModel,
        "vehicleCapacity": vehicleCapacity,
        "driverId": SessionManager.getDriverId().toString(),
      });

      // ------------ IMAGE 1 ------------
      if (vehicleImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "vehicleNumberImage",
            vehicleImage.path, // IMPORTANT
          ),
        );
        print("📷 vehicleNumberImage attached: ${vehicleImage.path}");
      }

      // ------------ IMAGE 2 ------------
      if (vehicleInsuraneImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "vehicleInsuraneImage",
            vehicleInsuraneImage.path, // IMPORTANT
          ),
        );
        print("📷 vehicleInsuraneImage attached: ${vehicleInsuraneImage.path}");
      }

      print("📤 Sending request...");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("🔹 Status Code: ${response.statusCode}");
      print("🔹 Response Bodyvehicleeeeee: $responseBody");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(responseBody);
        if (jsonData['success'] == true) {
          checkvehicle.value = true;
          vehiclemessage.value = jsonData['success'];
          print("✅ Vehicle created successfully!");
        } else {
          print("⚠️ API returned failure: $jsonData");
        }
      } else {
        print("❌ API Error: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Exception in createVehicle(): $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> createProfile({
    required String name,
    required String email,
    required String aadharNumber,
    required String panNumber,

    required File? dlImage,
    required File? aadharFront,
    required File? aadharBack,
    required File? panImage,
  }) async {
    try {
      loading.value = true;
      print("📡 Creating new profile...");

      final token = await SessionManager.getToken();
      print("🔑 Token: $token");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Urls.baseUrl}/driver/register"),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // ----------- TEXT FIELDS -----------
      request.fields.addAll({
        "name": name,
        "email": email,
        "aadharNumber": aadharNumber,
        "panNumber": panNumber,
      });

      // ----------- FILE FIELDS -----------
      Future<void> attachFile(String field, File? file) async {
        if (file != null) {
          request.files.add(
            await http.MultipartFile.fromPath(field, file.path),
          );
          print("📷 Attached $field: ${file.path}");
        }
      }

      await attachFile("dlImage", dlImage);
      await attachFile("aadharFront", aadharFront);
      await attachFile("aadharBack", aadharBack);
      await attachFile("panImage", panImage);

      print("📤 Sending request...");
      print("📦 Fields: ${request.fields}");
      print("📦 Files Count: ${request.files.length}");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("🔹 Status Code: ${response.statusCode}");
      print("🔹 Response BodyProfile: $responseBody");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(responseBody);

        if (jsonData['success'] == true) {
          print("✅ Profile created successfully!");
        } else {
          print("⚠️ API returned failure: $jsonData");
        }
      } else {
        print("❌ API Error: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Exception in createProfile(): $e");
    } finally {
      loading.value = false;
    }
  }
}
