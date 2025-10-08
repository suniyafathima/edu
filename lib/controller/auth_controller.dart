import 'dart:developer';
import 'dart:io';
import 'package:edu/core/services/edu_api_services.dart';
import 'package:edu/core/storage/token_storage.dart';
import 'package:edu/view/profile_screen/profile_screen.dart';
import 'package:edu/view/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthController with ChangeNotifier {
  File? selectedImage;
  // Signup screen email input
  TextEditingController emailController = TextEditingController();
  // Verification screen OTP input
  TextEditingController otpController = TextEditingController();
   TextEditingController fullnameController = TextEditingController();
  // Loading state for both operations
  bool isLoading = false;
  String? profilePictureUrl; 
  String? fullName;
  String? email;
  List<String> emailList = [];
  // Toggle loading
  void toggleLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
  // Send OTP
  Future<Map<String, dynamic>?> sendOtp(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return null;
    }

    toggleLoading(true);

    try {
      final response = await EduApiServices.sendOtp(email: email);

      if (response != null && response['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
        return response;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send OTP')),
        );
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      return null;
    } finally {
      toggleLoading(false);
    }
  }

  // Verify OTP
  Future<Map<String, dynamic>?> verifyOtp(BuildContext context) async {
  final email = emailController.text.trim();
  final otp = otpController.text.trim();

  if (otp.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter OTP')),
    );
    return null;
  }

  toggleLoading(true);

  try {
    final response = await EduApiServices.verifyOtp(email: email, otp: otp);

    if (response != null && response['token'] != null) {
      // Save token to SharedPreferences
      await TokenStorage.saveToken(response['token']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'OTP Verified!')),
      );

      return response;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
      return null;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
    return null;
  } finally {
    toggleLoading(false);
  }
}

  Future<void> addFullName(BuildContext context) async {
  final fullname = fullnameController.text.trim();

  if (fullname.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter your full name')),
    );
    return;
  }

  // Get token automatically
  final token = await TokenStorage.getToken();

  if (token == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No token found. Please verify OTP first.')),
    );
    return;
  }

  toggleLoading(true);
  try {
    final response = await EduApiServices.addFullName(
      token: token,
      fullname: fullname,
    );

    if (response != null && response['message'] != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add full name')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  } finally {
    toggleLoading(false);
  }
}

Future<void> logout(BuildContext context) async {
  await TokenStorage.clearToken();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Logged out successfully')),
  );

  // Navigate back to signup screen
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const SignupScreen()),
    (route) => false,
  );
}

Future<void> pickAndUploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
      return;
    }

    selectedImage = File(pickedFile.path);
    notifyListeners();

    final token = await TokenStorage.getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No token found. Please log in again.')),
      );
      return;
    }

    toggleLoading(true);
    try {
      final response = await EduApiServices.uploadProfilePicture(
        token: token,
        imageFile: selectedImage!,
      );

      if (response != null && response['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload picture')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      toggleLoading(false);
    }
  }


Future<void> fetchUserData() async {
  final token = await TokenStorage.getToken();
  if (token == null) return;

  toggleLoading(true);

  try {
    final userData = await EduApiServices.getUserData(token: token);
    if (userData != null) {
      fullName = userData['fullname'] ?? '';
      fullnameController.text = fullName!;
      emailList = [userData['email'] ?? ''];
      email = emailList.first;
      profilePictureUrl = userData['picture'];
      notifyListeners();
    }
  } catch (e) {
    log('❌ Exception in fetchUserData: $e');
  } finally {
    toggleLoading(false);
  }
}
void updateFullName(String val) {
  fullName = val;
  fullnameController.text = val;
  notifyListeners();
}
void updateEmail(String val) {
  email = val;
  notifyListeners();
}
 void updateProfilePicture(String url) {
    profilePictureUrl = url;
    notifyListeners();
  }
 
  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
