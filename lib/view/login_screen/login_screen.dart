import 'package:edu/controller/auth_controller.dart';
import 'package:edu/global_widget/gradientButton.dart';
import 'package:edu/global_widget/social_button.dart';
import 'package:edu/view/login_profile/login_profile.dart';
import 'package:edu/view/signup_screen/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 96,
        titleSpacing: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_ios_new, size: 14, color: Color(0xFF0F172A)),
                    const SizedBox(width: 12),
                    Text(
                      "Back",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              SizedBox(
                width: 36,
                height: 20,
                child: Text(
                  "Email",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: emailController,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    color: const Color(0xFF64748B),
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    hintText: 'penoftdesign@gmail.com',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                      color: const Color(0xFF64748B),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10.5, top: 4.17, bottom: 4.17),
                      child: const Icon(
                        Icons.mail_outline,
                        size: 15,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 18, minHeight: 40),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

          // Remember Me 
          SizedBox(
          width: 375, 
          height: 20,
          child:Row(
          children: [
            Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(0), 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x34405414),
                    offset: Offset(0, 1),
                    blurRadius: 2,      
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Checkbox(
                value: isRememberMe,
                onChanged: (value) {
                  setState(() {
                    isRememberMe = value ?? false;
                  });
                },
                checkColor: Colors.white, 
                fillColor: WidgetStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(WidgetState.selected)) {
                      return const Color(0xFF9F54F8); 
                    }
                    return Colors.white; 
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: WidgetStateBorderSide.resolveWith(
                  (states) => const BorderSide(
                    color: Color(0xFFCBD5E1),
                    width: 1,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),

            const SizedBox(width: 8), 

            // Label
            SizedBox(
              width: 97,
              height: 20,
              child: Text(
                "Remember Me",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                  letterSpacing: 0,
                  color: const Color(0xFF475569),
                ),
              ),
            ),
            const Spacer(), 
              // Forgot Password
              SizedBox(
                width: 121,
                height: 20,
                child: GestureDetector(
                  onTap: () {
                    print("Forgot Password tapped");
                  },
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 20 / 14,
                      letterSpacing: 0,
                      color: const Color(0xFF9F54F8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        GradientButton(
          text: "Continue",
          onPressed: () async {
            final authController = Provider.of<AuthController>(context, listen: false);
            await authController.fetchUserData();

            if (authController.fullName == null || authController.email == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to fetch user data. Please log in again.')),
              );
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginProfile(),
              ),
            );
          },
        ),
         const SizedBox(height: 32),
          // Dont have account,Register
    SizedBox(
      width: 327,
      height: 20,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "Don't have an account? ",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: const Color(0xFF64748B),
            ),
            children: [
              TextSpan(
                text: "Register",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                  color: const Color(0xFF9F54F8),
                ),
                  recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // OR separator
              SizedBox(
                width: double.infinity,
                height: 20,
                child: Row(
                  children: [
                    Container(width: 162, height: 1, color: const Color(0xFFCBD5E1)),
                    const SizedBox(width: 10),
                    Text(
                      "OR",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 20 / 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(width: 162, height: 1, color: const Color(0xFFCBD5E1)),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SocialButton(
                iconPath: Icon(
                  SocialMediaIcons.google,
                  color: Colors.black,
                  size: 24,
                ),
                text: "Continue with Google",
                onPressed: () {
                  print("Google button clicked");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
