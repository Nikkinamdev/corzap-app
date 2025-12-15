import 'dart:convert';

import 'package:corezap_driver/apis/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/faQs_model.dart';
import '../models/get_company_model.dart';
import '../models/ride_history_model.dart';
import '../session/session_manager.dart';

class RideApisController extends GetxController {
  RxBool loading = false.obs;

  Rxn<Data> companyData = Rxn<Data>();
  RxBool RideAcceptStatus = false.obs;
  RxString RideAcceptMessage = "".obs;
  RxBool RideDeclinetStatus = false.obs;
  RxString RideDeclinetMessage = "".obs;
  Rx<RideHistoryModel?> rideHistoryModel = Rx<RideHistoryModel?>(null);
  RxList<Data> rideHistoryList = <Data>[].obs;
  RxList allRides = <dynamic>[].obs;
  RxList newTrips = <dynamic>[].obs;
  RxList completedTrips = <dynamic>[].obs;
  RxList cancelledTrips = <dynamic>[].obs;

  Future<void> AcceptRide({
    required String orderId,
    required String vehicleId,
    required String orderStatus, // example: "Declined" / "Accepted"
  }) async {
    try {
      loading.value = true;

      final String token = SessionManager.getToken().toString();

      final url = "${Urls.baseUrl}/order/update/$orderId";

      print("📡 Accept Ride URL: $url");

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"vehicleId": vehicleId, "orderStatus": orderStatus}),
      );

      print("📩 Accept Ride Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        RideAcceptStatus.value = jsonData['success'];
        RideAcceptMessage.value = jsonData['message'];
        print("✅ Accept ride success: $jsonData");
      } else {
        final jsonData = jsonDecode(response.body);
        RideAcceptStatus.value = jsonData['success'];
        RideAcceptMessage.value = jsonData['message'];
        print("❌ Accept ride failed: ${response.statusCode}");
        print("Message: ${response.body}");
      }
    } catch (e) {
      print("🚨 Accept Ride Error: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> RideOtp({
    required String orderId,
    required String rideOtp, // example: "Declined" / "Accepted"
  }) async {
    try {
      loading.value = true;

      final String token = SessionManager.getToken().toString();

      final url = "${Urls.baseUrl}/order/verifyOtp";

      print("📡 Otp Ride URL: $url");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "orderId": "693a8e41626c35ea4035029e",
          "rideOtp": rideOtp,
        }),
      );

      print("📩 Otp Ride Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        RideAcceptStatus.value = jsonData['success'];
        RideAcceptMessage.value = jsonData['message'];
        print("✅ Otp ride success: $jsonData");
      } else {
        print("❌ Otp ride failed: ${response.statusCode}");
        print("Message: ${response.body}");
      }
    } catch (e) {
      print("🚨 Otp Ride Error: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> declineRide({
    required String orderId,
    required String driverId,
    required String vehicleId,
    required String status, // example: "Declined" / "Accepted"
  }) async {
    try {
      loading.value = true;

      final String token = SessionManager.getToken().toString();

      final url = "${Urls.baseUrl}/order/decline/$orderId";

      print("📡 Decline Ride URL: $url");

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "driverId": driverId,
          "vehicleId": vehicleId,
          "orderStatus": status,
        }),
      );

      print("📩 Decline Ride Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        RideDeclinetStatus.value = jsonData['success'];
        RideDeclinetMessage.value = jsonData['message'];
        print("✅ Decline ride success: $jsonData");
      } else {
        final jsonData = jsonDecode(response.body);
        RideDeclinetStatus.value = jsonData['success'];
        RideDeclinetMessage.value = jsonData['message'];
        print("❌ Decline ride failed: ${response.statusCode}");
        print("Message: ${response.body}");
      }
    } catch (e) {
      print("🚨 Decline Ride Error: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> getRideHistory() async {
    try {
      loading.value = true;
      final String token = SessionManager.getToken().toString();
      final url = "${Urls.baseUrl}/order/driver/history";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
print("getride historyyyyyyyyyyyy${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        allRides.value = data['data'] ?? [];

        // Filter rides into tabs
        newTrips.value = allRides
            .where((ride) => ride['orderStatus'] == 'New')
            .toList();
        completedTrips.value = allRides
            .where((ride) => ride['orderStatus'] == 'Completed')
            .toList();
        cancelledTrips.value = allRides
            .where((ride) => ride['orderStatus'] == 'Cancelled')
            .toList();

        print("✅ All rides: ${allRides.length}");
        print("✅ Completed rides: ${completedTrips.length}");
        print("✅ Cancelled rides: ${cancelledTrips.length}");
      } else {
        print("❌ Failed to fetch rides: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Ride history error: $e");
    } finally {
      loading.value = false;
    }
  }
}
