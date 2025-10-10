import 'package:edu/controller/auth_controller.dart';
import 'package:edu/controller/googleauth_controller.dart';
import 'package:edu/global_widget/gradientButton.dart';
import 'package:edu/global_widget/social_button.dart';
import 'package:edu/view/login_screen/login_screen.dart';
import 'package:edu/view/verification_screen/verification_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_icons.dart';
class SignupScreen extends StatefulWidget {
   const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  
  @override
void initState() {
  super.initState();
  final authController = context.read<AuthController>();
  authController.emailController.clear(); // clear last email
}

  @override
  Widget build(BuildContext context) {
final authController = context.watch<AuthController>();
final googleauthController = context.watch<GoogleAuthController>();
return Scaffold(
  backgroundColor: Colors.white,
  appBar:AppBar(
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
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 24),
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
                SizedBox(height: 20),
                Text(
                "Enter your number",
                style: GoogleFonts.inter(
                  fontSize: 18,                   
                  fontWeight: FontWeight.w600,                   
                  letterSpacing: 0,                
                  color: const Color(0xFF0F172A), 
                ),
              ),
                SizedBox(height: 12,),
                SizedBox(
                width: 327, 
                child: Text(
                  "Enter your email to receive verification code.",
                  style: GoogleFonts.inter(
                    fontSize: 14,                    
                    fontWeight: FontWeight.w400,  
                    height: 20 / 14,                  
                    letterSpacing: 0,                 
                    color: const Color(0xFF475569), 
                  ),
                ),
              ),
              SizedBox(height: 40,),
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
              SizedBox(height: 6,),
              SizedBox(
                height: 40,
                child:TextField(
                  controller: authController.emailController,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: const Color(0xFF64748B),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal:12, vertical:10),
              hintText: 'penoftdesign@gmail.com',
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
                color: const Color(0xFF64748B),
              ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.5, 
                        top: 4.17,
                        bottom: 4.17,
                      ),
                      child: SizedBox(
                        width: 15,      
                        height: 11.6667, 
                        child: const Icon(
                          Icons.mail_outline,
                          size: 15,     
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 15 + 2.5, 
                      minHeight: 40,     
                    ),
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
                ),),
              SizedBox(height: 20,),
              
               authController.isLoading
                ? Center(child: const CircularProgressIndicator())
                :GradientButton(
                text: "Continue",
               onPressed: () async {
                  final response = await authController.sendOtp(context);
                      if (response != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VerificationScreen(
                              email: authController.emailController.text,
                              isSignup: true,
                            ),
                          ),
                        );
                      }
                },
              ),
              SizedBox(height: 32,),
                    SizedBox(
                    width: 327,
                    height: 20, 
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 20 / 14,          
                            letterSpacing: 0,
                            color: const Color(0xFF64748B), 
                          ),
                          children: [
                            TextSpan(
                              text: "Login",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 20 / 14,
                                letterSpacing: 0,
                                color: const Color(0xFF9F54F8), 
                              ),
                            recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                
              SizedBox(height: 32,),  
              SizedBox(
                width: double.infinity, 
                height: 20,
                child: Row(
                  children: [
                    // Left line
                    Container(
                      width: 147+15,       
                      height: 1,          
                      color: const Color(0xFFCBD5E1),
                    ),
                    const SizedBox(width: 10), 
                    // OR Text
                    Text(
                      "OR",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 20 / 12,        
                        letterSpacing: 0,
                        color: const Color(0xFF64748B), 
                      ),
                    ),
                    const SizedBox(width: 10), 
                    // Right line
                    Container(
                      width:147+15,
                      height: 1,
                      color: const Color(0xFFCBD5E1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32,),
              googleauthController.isLoadingGoogle
            ? Center(child: const CircularProgressIndicator())
            : SocialButton(
                iconPath: Icon(
                  SocialMediaIcons.google,
                  color: Colors.black,
                  size: 24,
                ),
                text: "Continue with Google",
                onPressed: () {
                  // Google Sign-In
                googleauthController.signInWithGoogle(context,);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
