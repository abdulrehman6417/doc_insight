import 'package:doc_insight/screens/home_page.dart';
import 'package:doc_insight/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();

    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return GestureDetector(
      onTap: () async {
        try {
          await signInWithGoogle();
          utils.toastMessage('Sign in Success', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } catch (error) {
          utils.toastMessage('No Account Selected', Colors.orange);
        }
      },
      child: Image.asset(
        'assets/images/GoogleWhite.png',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }
}
