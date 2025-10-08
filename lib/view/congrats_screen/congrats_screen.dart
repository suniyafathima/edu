
import 'package:confetti/confetti.dart';
import 'package:edu/core/storage/token_storage.dart';
import 'package:edu/global_widget/gradientButton.dart';
import 'package:edu/view/bottom_navigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Confetti area
          Positioned(
            top: 184,
            left: 0,
            width: 375,
            height: 339,
            child: ClipRect(
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.08,
                numberOfParticles: 30,
                maxBlastForce: 15,
                minBlastForce: 7,
                gravity: 0.05,
                colors: const [
                  Colors.pinkAccent,
                  Colors.blueAccent,
                  Colors.purpleAccent,
                  Colors.orangeAccent,
                  Colors.tealAccent,
                  Colors.yellowAccent,
                  Colors.greenAccent,
                  Colors.redAccent,
                ],
                createParticlePath: (size) {
                  final path = Path();
                  path.addOval(Rect.fromCircle(center: Offset.zero, radius: 4));
                  return path;
                },
              ),
            ),
          ),

          // Success content
          Positioned(
            top: 407,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Animated check circle
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, scale, child) => Transform.scale(
                      scale: scale,
                      child: child,
                    ),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 60),
                    ),
                  ),
                  const SizedBox(height: 48),

                  SizedBox(
                    width: 83,
                    height: 26,
                    child: Text(
                      "Congrats!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.interTight(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 26 / 18,
                        letterSpacing: 0,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 319,
                    height: 40,
                    child: Text(
                      "You have signed up successfully. Go to home & start exploring courses",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 20 / 14,
                        letterSpacing: 0,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
          top: 812, 
          child: Container(
            width: 375+24+24,
            padding: const EdgeInsets.only(left: 24,right:24,top: 16,bottom:53), 
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1, color: const Color(0xFFE2E8F0)), 
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: GradientButton(
                    text: "Go to Home",
                  onPressed: () async {
                      final token = await TokenStorage.getToken(); 
                      if (token != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bottomnavigationsc(token: token),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        ],
      ),
    );
  }
}


