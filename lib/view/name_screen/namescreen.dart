import 'package:edu/controller/auth_controller.dart';
import 'package:edu/global_widget/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Namescreen extends StatelessWidget {
  const Namescreen({super.key});
 
  @override
  Widget build(BuildContext context) {
     final authController = context.watch<AuthController>();
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
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
            // other widgets
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
                "What’s your name?",
                style: GoogleFonts.inter(
                  fontSize: 18,                   
                  fontWeight: FontWeight.w600,                   
                  letterSpacing: 0,                
                  color: const Color(0xFF0F172A), 
                ),
              ),
                    SizedBox(height: 40,),
                    SizedBox(
                width: 36,
                height: 20,
                child: Text(
                  "Full Name",
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
                controller: authController.fullnameController,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14, 
                    color: const Color(0xFF64748B),
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal:12, vertical:10),
                    hintText: 'Name',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                      color: const Color(0xFF64748B),
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
                  ),
                ),
              SizedBox(height: 20,),
              GradientButton(
                text: "Continue",
                onPressed: () {
                  _handleContinue(context,  authController);
                },
              ),
          ],  ),
        ),
      ),
    );
  }
   Future<void> _handleContinue(
      BuildContext context, AuthController authController) async {
    final name = authController.fullnameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your full name")),
      );
      return;
    }

    await authController.addFullName(context);

  }
}