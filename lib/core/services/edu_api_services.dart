
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:edu/core/network/api_helper.dart';
import 'package:edu/model/banner_res.dart';
import 'package:edu/model/courses_res.dart';
import 'package:edu/model/material_res.dart';
import 'package:edu/model/sub_res.dart';
import 'package:http/http.dart' as http;

class EduApiServices {
  static Future<Map<String, dynamic>?> sendOtp({
    required String email,
  }) async {
    final responseBody = await ApiHelper.postData(
      endpoint: "/api/user/send-otp",
      data: {'email': email}, 
    );

    return responseBody; 
  }
  
  /// Verify OTP 
   static Future<Map<String, dynamic>?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final responseBody = await ApiHelper.postData(
      endpoint: "/api/user/verify-otp",
      data: {
        'email': email,
        'otp': otp,
      },
    );
    return responseBody;
  }
   
 
  // Add Full Name
  static Future<Map<String, dynamic>?> addFullName({
    required String token,
    required String fullname,
  }) async {
    final response = await ApiHelper.postData(
      endpoint: "/api/user/add-fullname",
      data: {"fullname": fullname},
      headers: {
        "Authorization": "Bearer $token", 
      },
    );

    return response;
  }
  
   /// Upload Profile Picture
  static Future<Map<String, dynamic>?> uploadProfilePicture({
    required String token,
    required File imageFile,
  }) async {
    final url = Uri.parse("${AppConfig.baseUrl}/api/user/add-picture");

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('picture', imageFile.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      log('POST ${url.toString()}');
      log('Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(responseBody) as Map<String, dynamic>;
      } else {
        log('Error: ${response.statusCode} - $responseBody');
        return null;
      }
    } catch (e) {
      log('Exception in uploadProfilePicture: $e');
      return null;
    }
  }
  
  /// Fetch user profile data
static Future<Map<String, dynamic>?> getUserData({required String token}) async {
  final url = Uri.parse("${AppConfig.baseUrl}/api/user/get-user");

  try {
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // data['user'] contains user info
      return data['user'] != null ? Map<String, dynamic>.from(data['user']) : null;
    } else {
      log('Error fetching user: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    log(' Exception in getUserData: $e');
  }
  return null;
}

/// Create new user after Google SignIn
static Future<Map<String, dynamic>?> createUser({
  required String fullname,
  required String email,
  required String phone,
  required String picture,
}) async {
  final response = await ApiHelper.postData(
    endpoint: "/api/user/create-user",
    data: {
      "fullname": fullname,
      "email": email,
      "phone": phone,
      "picture": picture,
    },
  );

  return response;
}


 // Fetch subjects list
  static Future<Subjectres?> fetchSubjects(String token) async {
    final response = await ApiHelper.getData(
      endpoint: "/api/data/subjects",
      headers: {"Authorization": "Bearer $token"},
    );

    if (response != null) {
      return Subjectres.fromJson(response);
    } else {
      return null;
    }
  }
  
  static Future<BannerRes?> fetchBanner(String token) async {
    final url = Uri.parse('https://machinetest.flutter.penoft.com/api/data/banner');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return BannerRes.fromJson(jsonData);
      } else {
        print('Failed to fetch banner: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching banner: $e');
    }
    return null;
  }
  
   static Future<CoursesRes?> fetchCourses(String token) async {
    final response = await ApiHelper.getData(
      endpoint: "/api/data/courses",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response != null) {
      return CoursesRes.fromJson(response);
    }
    return null;
  }
   
    static Future<MaterialRes?> fetchMaterials(String token) async {
    final response = await ApiHelper.getData(
      endpoint: "/api/data/materials",
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response != null) {
      return MaterialRes.fromJson(response);
    }
    return null;
  }
 
}


