import 'package:get/get.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';

import '../apis/wallet.dart';

class RazorpayController extends GetxController {
  late Razorpay _razorpay;
WalletApiController verifyPayment= Get.find<WalletApiController>();
  @override
  void onInit() {
    super.onInit();

    _razorpay = Razorpay();

    // Event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  // ---------- OPEN RAZORPAY PAYMENT ----------
  void openCheckout({
    required String amount,

    required String orderId
  }) {
    // Remove ₹ symbol
    String cleanAmount = amount.replaceAll("₹", "").trim();

    int amountInPaise = int.parse(cleanAmount) * 100;

    var options = {
      "key": "rzp_test_Rfx6rVjyohb2Su",
      "amount": amountInPaise,
      "order_id": orderId,
      "description": "Wallet Top-up",
      // "prefill": {
      //   "contact": userMobile,
      //   "email": userEmail,
      // }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Razorpay Error: $e");
    }
  }


  // ---------- EVENT HANDLERS ----------
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("ORDER ID = ${response.orderId}");
    print("PAYMENT ID = ${response.paymentId}");
    print("SIGNATURE = ${response.signature}");

    WalletApiController walletApi = Get.find<WalletApiController>();

    walletApi.paymentVerify(
      razorpayOrderId: response.orderId.toString(),
      razorpayPaymentId: response.paymentId.toString(),
      razorpaySignature: response.signature.toString(),
    );

    Get.snackbar("Success", "Payment Verified Successfully");
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed: ${response.message}");

    Get.snackbar("Payment Failed", "Please try again",
        snackPosition: SnackPosition.BOTTOM);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", response.walletName ?? "");
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
