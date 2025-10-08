
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // Box Shadow
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000), 
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
        // Border Gradient,Background Gradient
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8932EB), 
            Color(0xFF8932EB), 
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            style: BorderStyle.solid,
            color: Colors.white.withAlpha(36),
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 255, 255, 0.4),
              Color.fromRGBO(255, 255, 255, 0.0),
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child:SizedBox(
            width: 80,  
            height: 20,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,                    
                  fontWeight: FontWeight.w500,     
                  height: 20 / 14,               
                  letterSpacing: 0,                
                  color: const Color(0xFFffffff), 
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}