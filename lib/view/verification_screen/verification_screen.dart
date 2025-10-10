import 'package:edu/controller/auth_controller.dart';
import 'package:edu/global_widget/gradientButton.dart';
import 'package:edu/view/login_profile/login_profile.dart';
import 'package:edu/view/name_screen/namescreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatelessWidget {
   final String email;
   final bool isSignup;
  const VerificationScreen({super.key,required this.email,required this.isSignup,});

  @override
  Widget build(BuildContext context) {
    
    final authController = context.watch<AuthController>();
    authController.emailController.text = email;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(left:24.0,right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 72),
              Text("Enter verification code",
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 26 / 18, 
                  letterSpacing: 0,
                  color: const Color(0xFF0F172A),
                ),
              ),
            SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
              children: [
              TextSpan(
                text: "Enter the verification code sent to \n",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14, 
                  color: const Color(0xFF475569),
                ),
              ),
              TextSpan(
                text: "mail id",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500, 
                  height: 20 / 14,
                  color: const Color(0xFF9F54F8), 
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: PinCodeTextField(
            appContext: context,
            controller: authController.otpController,
            length: 6, 
            keyboardType: TextInputType.number,
            autoDismissKeyboard: true,
            enableActiveFill: true,
            animationType: AnimationType.none,
             hintCharacter: "_", 
         hintStyle: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
              height: 24 / 24,
            ),
           textStyle: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
              height: 24 / 24,
            ),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 48,
              fieldWidth: 48,
              activeColor: const Color(0xFFCBD5E1),
              selectedColor: const Color(0xFF9F54F8),
              inactiveColor: const Color(0xFFCBD5E1),
              activeFillColor: Colors.white,
              selectedFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              borderWidth: 1,
            ),
            boxShadows: const [
              BoxShadow(
                color: Color(0x23344054), 
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
            onChanged: (value) {
              // Handle OTP change
              debugPrint("OTP: $value");
            },
          ),
        ),
          SizedBox(height: 20),
          authController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : GradientButton(
            text: "Continue",
                  onPressed: () async {
                    final response = await authController.verifyOtp(context);
                    if (response != null) {
                       if (isSignup) {
                                // Navigate to NameScreen for signup
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>  Namescreen()),
                                );
                              } else {
                                // Navigate to LoginProfile for login
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginProfile()),
                                );
                              }
                    }
                   },
                ),
        SizedBox(height: 20,),
         
        Center(
          child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
            color: const Color(0xFF475569),
          ),
          children: [
            const TextSpan(text: "Didn’t receive the code? "),
            TextSpan(
              text: "Resend",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF8932EB), 
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  // resend action
                    await authController.sendOtp(context);
                },
            ),
            const TextSpan(text: " in 6 second"), 
            ],
           ),
          ),
         )
              ],
            ),
          ),
        );
        
        }
  
  }
