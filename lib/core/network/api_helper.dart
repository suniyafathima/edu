import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AppConfig {
  static const String baseUrl = "https://machinetest.flutter.penoft.com";
}

class ApiHelper {
  
  static Future<Map<String, dynamic>?> getData({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(AppConfig.baseUrl + endpoint);

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          ...?headers,
        },
      );

      log('GET ${url.toString()}');
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        log('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      log('Exception in GET request: $e');
      return null;
    }
  }
  
  
  // POST request
  static Future<Map<String, dynamic>?> postData({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(AppConfig.baseUrl + endpoint);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
           ...?headers,
        },
        body: jsonEncode(data ?? {}),
      );

      log('POST ${url.toString()}');
      log('Request Body: ${jsonEncode(data)}');
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        log('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      log('Exception in POST request: $e');
      return null;
    }
  }
}
