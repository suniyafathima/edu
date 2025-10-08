
import 'dart:async';
import 'package:edu/core/storage/token_storage.dart';
import 'package:edu/view/bottom_navigation/bottom_navigation.dart';
import 'package:edu/view/login_screen/login_screen.dart';
import 'package:edu/view/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFlow();
  }

  Future<void> _checkFlow() async {
    final prefs = await SharedPreferences.getInstance();
    bool isNewUser = prefs.getBool('isNewUser') ?? true;
    String? token = await TokenStorage.getToken();
    await Future.delayed(const Duration(seconds: 2)); 
   
    if (isNewUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignupScreen()),
      );
    } else if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Bottomnavigationsc(token: token)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar( 
      //   systemOverlayStyle: SystemUiOverlayStyle.dark, 
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   ),
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
