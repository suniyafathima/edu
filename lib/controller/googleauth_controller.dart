import 'package:edu/core/services/edu_api_services.dart';
import 'package:edu/view/congrats_screen/congrats_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleAuthController with ChangeNotifier {
  bool isLoadingGoogle = false;

  void toggleGoogleLoading(bool value) {
    isLoadingGoogle = value;
    notifyListeners();
  }

 Future<void> signInWithGoogle(BuildContext context) async {
  toggleGoogleLoading(true);
  try {
    final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    final account = await googleSignIn.signIn();

    if (account == null) {
      toggleGoogleLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Sign-In cancelled')));
      return;
    } 
    final fullname = account.displayName ?? "New User";
    final email = account.email;
    final picture = account.photoUrl ?? "https://example.com/default.png";
    final phone = "";

    // Call create user API
    final createResponse = await EduApiServices.createUser(
      fullname: fullname,
      email: email,
      phone: phone,
      picture: picture,
    );

    if (createResponse != null && createResponse['message'] != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(createResponse['message'])));

      // Navigate to BottomNavScreen or SuccessScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SuccessScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create user')));
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Google Sign-In Error: $e')));
  } finally {
    toggleGoogleLoading(false);
  }
}

}
