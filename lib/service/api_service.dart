import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<bool> isConnected() async {
    var res = await Connectivity().checkConnectivity();
    return res != ConnectivityResult.none;
  }

  Future<Map<String, dynamic>?> getMessageFromApi() async {
    if (!await isConnected()) return null;

    final url = Uri.parse("https://yourapi.com/get-message");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
