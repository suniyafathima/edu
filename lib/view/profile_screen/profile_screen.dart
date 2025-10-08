import 'package:edu/controller/auth_controller.dart';
import 'package:edu/global_widget/gradientButton.dart';
import 'package:edu/view/congrats_screen/congrats_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //  final List<String> emailList = [
  //   'fetchedemailid@gmail.com',
  //   'example1@gmail.com',
  //   'example2@gmail.com',
  // ];

  // String? selectedEmail;
  @override
  void initState() {
    super.initState();
    final authController = context.read<AuthController>();
    // Fetch dynamic email list
    authController.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
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
       body: authController.isLoading
          ? const Center(child: CircularProgressIndicator())
          :Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "your Profile",
                style: GoogleFonts.inter(
                  fontSize: 18,                   
                  fontWeight: FontWeight.w600,                   
                  letterSpacing: 0,                
                  color: const Color(0xFF0F172A), 
                ),
              ),
              const SizedBox(height: 12,),
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
              const SizedBox(height: 40,),
              SizedBox(
            width: 94, 
            height: 20,
            child: Text(
              "Profile Picture",
              style: GoogleFonts.inter(
                fontSize: 14,                  
                fontWeight: FontWeight.w500,  
                letterSpacing: 0,                
                color: const Color(0xFF0F172A), 
              ),
            ),
          ),
            const SizedBox(height: 6,),
            Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: authController.selectedImage != null
                    ? FileImage(authController.selectedImage!)
                    : authController.profilePictureUrl != null
                        ? NetworkImage(
                            authController.profilePictureUrl!)
                        : const AssetImage(
                                'assets/images/outerimage.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: authController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.purple,
                        ),
                      )
                    : null,
              ),
              Positioned(
                child: GestureDetector(
                  onTap: () =>
                      authController.pickAndUploadImage(context),
                  child: Container(
                    width: 39.58,
                    height: 37.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/innerimage.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
                      ],
                    ),
              SizedBox(height: 12,),
                Text(
                "Full name",
                style: GoogleFonts.inter(
                  fontSize: 14,                     
                  fontWeight: FontWeight.w500,                 
                  letterSpacing: 0,               
                  color: const Color(0xFF0F172A),  
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
                hintText: 'Fetched Name',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                  color: const Color(0xFF64748B),
                ),
              
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                ),
              
              ),
              onChanged:authController.updateFullName,
              ),
            ),
              SizedBox(height: 12,),
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
                value: authController.email,
                items: authController.emailList.map((email) {
                  return DropdownMenuItem<String>(
                    value: email,
                    child: Text(
                      email,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.0, 
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  );
                }).toList(),
              onChanged: (val) {
              if (val != null) authController.updateEmail(val);
            },

                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), 
                // hintText: 'fetchedemailid@gmail.com',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.0,
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
              const SizedBox(height: 20,),
              
              GradientButton(
                text: "Continue",
               onPressed: () {
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