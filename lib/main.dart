import 'package:edu/controller/auth_controller.dart';
import 'package:edu/controller/banner_controller.dart';
import 'package:edu/controller/cart_controller.dart';
import 'package:edu/controller/courses_controller.dart';
import 'package:edu/controller/googleauth_controller.dart';
import 'package:edu/controller/material_controller.dart';
import 'package:edu/controller/subject_controller.dart';
import 'package:edu/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => GoogleAuthController()),
        ChangeNotifierProvider(create: (_) => SubjectController()),
        ChangeNotifierProvider(create: (_) => BannerController()),
        ChangeNotifierProvider(create: (_) => CoursesController()),
        ChangeNotifierProvider(create: (_) => MaterialsController()),
        ChangeNotifierProvider(create: (_) => CartController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
