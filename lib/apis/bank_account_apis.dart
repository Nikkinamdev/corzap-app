import 'dart:convert';
import 'package:corezap_driver/apis/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/bank_detail_model.dart';
import '../session/session_manager.dart';

class BankDetails extends GetxController {
  RxBool loading = false.obs;
  RxString bankdetailMessage = "".obs;
  RxString name = "".obs;
  RxString ifsc = "".obs;
  RxString accountnumber = "".obs;
  RxList<Data> bankList = <Data>[].obs;
  RxString bankId="".obs;
  RxBool addBankAccoundButtonController = false.obs;
  Future<void> addbankDetail({
    required String bankName,
    required String accountNumber,
    required String id,
    required String ifscCode,
    required String accountHolderName,
  }) async {
    try {
      loading.value = true;

      final token = await SessionManager.getToken();
      print("📡 API URL: ${Urls.baseUrl}/bank-accounts/add");
      print("🔑 Token: $token");

      final bodyData = jsonEncode({
        "driverId": id,
        "bankName": bankName,
        "accountNumber": accountNumber,
        "ifscCode": ifscCode,
        "accountHolderName": accountHolderName,
      });

      print("📦 Sending Body: $bodyData");

      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/bank-accounts/add"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: bodyData,
      );

      print("🧾 Response body: ${response.body}");
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData["success"] == true) {
        bankdetailMessage.value = jsonData["message"];
        addBankAccoundButtonController.value = true;
        print("✅ Bank details added: ${bankdetailMessage.value}");
      } else {
        bankdetailMessage.value = jsonData["message"] ?? "Something went wrong";
        print("⚠️ API Error: ${bankdetailMessage.value}");
      }
    } catch (e) {
      print("🚨 Error in addbankDetail: $e");
      bankdetailMessage.value = "Request failed";
    } finally {
      loading.value = false;
    }
  }

  Future<void> getbankAccount({required String id}) async {
    try {
      loading.value = true;

      final token = await SessionManager.getToken();
      print("📡 API URL: ${Urls.baseUrl}/bank-accounts/driverid/$id");
      print("🔑 Token: $token");

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/bank-accounts/driverid/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("🧾 Response body: ${response.body}");

      final BankDetailsModel model = BankDetailsModel.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200 && model.success == true) {
        // ⬇️ Clear old list
        bankList.clear();

        if (model.data != null && model.data!.isNotEmpty) {
          // ⬇️ Add entire data list from API
          bankList.addAll(model.data!);

          print("📌 Total Accounts Loaded: ${bankList.length}");
        } else {
          print("⚠️ No bank accounts found.");
        }
      } else {
        print("⚠️ Error: ${model.message}");
      }
    } catch (e) {
      print("🚨 Error in getbankAccount: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> deletebankAccount({required String id}) async {
    try {
      loading.value = true;

      final token = await SessionManager.getToken();

      print("🔑 Token: $token");

      final response = await http.delete(
        Uri.parse("${Urls.baseUrl}/bank-accounts/delete/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("🧾 Response bodydelete: ${response.body}");
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData["success"] == true) {
      } else {}
    } catch (e) {
      print("🚨 Error in addbankDetail: $e");
    } finally {
      loading.value = false;
    }
  }
}
