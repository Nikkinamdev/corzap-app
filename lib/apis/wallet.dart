import 'dart:convert';
import 'package:corezap_driver/apis/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../session/session_manager.dart';

class WalletApiController extends GetxController {
  RxBool loading = false.obs;
  RxBool walletStatus = false.obs;
  RxString walletMessage = "".obs;
  RxString orderId = "".obs;
  RxString walletBalance = "".obs;

  Future<void> addWallet(String amount) async {
    try {
      loading.value = true;

      // Remove rupee symbol
      String cleanAmount = amount.replaceAll("₹", "").trim();

      final body = jsonEncode({"amount": cleanAmount});

      final response = await http.post(
        Uri.parse("https://corezap.smarttechbros.com/api/payments/wallet"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": SessionManager.getToken().toString(),
        },
        body: body,
      );

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        walletStatus.value = jsonData['success'];
        walletMessage.value = jsonData['message'];
        orderId.value = jsonData['data']['orderId'];
      } else {
        print("API Error Code: ${response.statusCode}");
        print("API Error Body: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> paymentVerify({
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    try {
      loading.value = true;

      final body = jsonEncode({
        "razorpay_order_id": razorpayOrderId,
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_signature": razorpaySignature,
      });

      print("VERIFY REQUEST BODY: $body");

      final response = await http.post(
        Uri.parse("https://corezap.smarttechbros.com/api/payments/verify"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": SessionManager.getToken().toString(),
        },
        body: body,
      );

      print("Verify Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        walletStatus.value = jsonData['success'];
        walletMessage.value = jsonData['message'];
      } else {
        print("API Error Code: ${response.statusCode}");
        print("API Error Body: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> getWallet() async {
    try {
      loading.value = true;

      // Remove rupee symbol

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/wallet"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": SessionManager.getToken().toString(),
        },
      );

      print("Response: get wallet ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        walletStatus.value = jsonData['success'];
        walletMessage.value = jsonData['message'];
        print(
          "walletBalance eeeeee${jsonData['data']['walletBalance'].toString()}",
        );
        walletBalance.value = (jsonData['data']['walletBalance'] ?? 0)
            .toString();

        //orderId.value=jsonData['data']['orderId'];
        print("walletBalance eeeeee${walletBalance.value}");
      } else {
        print("API Error Code: ${response.statusCode}");
        print("API Error Body: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      loading.value = false;
    }
  }
}
