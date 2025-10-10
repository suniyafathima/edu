
import 'dart:async';
import 'package:edu/core/storage/token_storage.dart';
import 'package:edu/view/bottom_navigation/bottom_navigation.dart';
import 'package:edu/view/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    String? token = await TokenStorage.getToken();

    await Future.delayed(const Duration(seconds: 2));

    if (token != null && token.isNotEmpty) {
      
      try {
        final response = await http.get(
          Uri.parse('https://machinetest.flutter.penoft.com/api/user/get-user'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          // Valid token - go to home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Bottomnavigationsc(token: token),
            ),
          );
          return;
        }
      } catch (e) {
        debugPrint("Token verification failed: $e");
      }
    }

    // No valid token - go to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/image 4.png',height: 120,width: 120,),
            const SizedBox(height: 24),
            Text(
            "educatory",
            textAlign: TextAlign.center,
             style: GoogleFonts.interTight(
              fontSize: 52,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              height: 20 / 52, 
              letterSpacing: 0,
              color: Color(0xff131842),
             ),
            ),
          ],
         ) 
      ),
    );
  }
}

