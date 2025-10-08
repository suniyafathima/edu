import 'package:edu/controller/auth_controller.dart';

import 'package:edu/global_widget/gradientButton.dart';
import 'package:edu/view/congrats_screen/congrats_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginProfile extends StatefulWidget {
  const LoginProfile({
    super.key});

  @override
  State<LoginProfile> createState() => _LoginProfileState();
}

class _LoginProfileState extends State<LoginProfile> {
  
  late TextEditingController fullnameController;
  final List<String> emailList = [];
  String? selectedEmail;
  String? selectedPhone;
  final List<String> phoneList = [];
  @override
  void initState() {
    super.initState();
   final authController = context.read<AuthController>();

    fullnameController = TextEditingController(text: authController.fullName ?? '');
    selectedEmail = authController.email;
   }
  
  @override
  void dispose() {
    fullnameController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    fullnameController.text = authController.fullName ?? '';
    selectedEmail = authController.email;
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
                    const Icon(Icons.arrow_back_ios_new,
                        size: 14, color: Color(0xFF0F172A)),
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
              const SizedBox(height: 20),
              Text(
                "Your Profile",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 327,
                child: Text(
                  "If needed you can change the details by clicking on them",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    letterSpacing: 0,
                    color: const Color(0xFF475569),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Profile Picture
              SizedBox(
                width: 94,
                height: 20,
                child: Text(
                  "Profile Picture",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 20 / 14,
                    letterSpacing: 0,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: authController.profilePictureUrl != null
                ? Image.network(
                    authController.profilePictureUrl!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/outerimage.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )],
              ),
              const SizedBox(height: 12),
              // Full Name
              Text(
                "Full name",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  letterSpacing: 0,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: fullnameController,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    color: const Color(0xFF64748B),
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    hintText: 'Fetched Name',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                      color: const Color(0xFF64748B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color(0xFFCBD5E1), width: 1.0),
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
              const SizedBox(height: 12),
              // Mail Id 
              Text(
                "Mail Id",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  letterSpacing: 0,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
          SizedBox(
            height: 40,
            child: DropdownButtonFormField<String>(
              value: selectedEmail,
              onChanged: (value) => authController.updateEmail(value!),
              items: authController.emailList.map((email) {
                return DropdownMenuItem<String>(
                  value: email,
                  child: Text(
                    email,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.0, // important for vertical centering
                      color: const Color(0xFF64748B),
                    ),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // center vertically
                hintText: 'fetchedemailid@gmail.com',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.0, // center hint text vertically
                  color: const Color(0xFF64748B),
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: Color(0xFF64748B),
                  ),
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
              dropdownColor: Colors.white,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.0, 
                color: const Color(0xFF64748B),
              ),
              iconSize: 0, 
              isExpanded: true,
            ),
          ),
          
           const SizedBox(height: 12),
              Text(
                "Phone Number",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  letterSpacing: 0,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
                SizedBox(
                height: 40,
                child: DropdownButtonFormField<String>(
                  value: selectedPhone,
                  onChanged: (value) {
                    setState(() {
                      selectedPhone = value;
                    });
                  },
                  items: phoneList.map((phone) {
                    return DropdownMenuItem<String>(
                      value: phone,
                      child: Text(
                        phone,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.0, // important for vertical centering
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), // center vertically
                    hintText: '+91 12345 67890',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.0, // center hint text vertically
                      color: const Color(0xFF64748B),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Color(0xFF64748B),
                      ),
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
                  dropdownColor: Colors.white,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.0, // vertical center selected text
                    color: const Color(0xFF64748B),
                  ),
                  iconSize: 0, // remove default arrow
                  isExpanded: true,
                ),
              ),
              const SizedBox(height: 20),
              GradientButton(
                text: "Continue",
                onPressed: () async {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
