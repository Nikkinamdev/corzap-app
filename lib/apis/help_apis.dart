import 'dart:convert';

import 'package:corezap_driver/apis/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/faQs_model.dart';
import '../models/get_company_model.dart';
import '../session/session_manager.dart';

class HelpApisController extends GetxController {
  RxBool loading = false.obs;
  RxList<FaqData> faqList = <FaqData>[].obs;
  Rxn<Data> companyData = Rxn<Data>();


  Future<void> FAQ() async {
    try {
      loading.value = true;

      final String token = SessionManager.getToken().toString();
      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/getAllQuestion"),
        headers: {"Authorization": "Bearer $token"},
      );

      print("FAQ Response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final parsed = FAQsResponse.fromJson(jsonData);

        faqList.value = parsed.data ?? [];

        print("First Question: ${faqList.first.question}");
      }
    } catch (e) {
      print("FAQ Error: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<void> getCompanyData() async {
    try {
      loading.value = true;

      final token = await SessionManager.getToken();
      print("📡 API URL: ${Urls.baseUrl}/company/getCompany");
      print("🔑 Token: $token");

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/company/getCompany"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("🧾 Response body: ${response.body}");

      final GetCompanyModel model = GetCompanyModel.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200 && model.success == true) {
        if (model.data != null && model.data.toString().isNotEmpty) {
          if (model.data != null && model.data.toString().isNotEmpty) {
            companyData.value = model.data!;
            print("company dataaaaaaaaa${companyData.value!.privacyPolicy }");
          } else {
            print("⚠️ No bank accounts found.");
          }
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
}
