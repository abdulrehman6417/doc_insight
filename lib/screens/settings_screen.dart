import 'package:doc_insight/screens/about_screen.dart';
import 'package:doc_insight/screens/help_page.dart';
import 'package:doc_insight/screens/login_screen.dart';
import 'package:doc_insight/screens/password_screen.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/utils/utils.dart';
import 'package:doc_insight/widgets/roundButton.dart';
import 'package:doc_insight/widgets/settingsCard.dart';
import 'package:doc_insight/widgets/top_bar3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Utils utils = Utils();
  List<String> cardTitles = ['Password & Security', 'Help', 'About Us'];
  List pages = [
    PasswordPage(),
    const HelpPage(),
    const AboutPage(),
  ];
  List<String> imagePaths = ['lock', 'help', 'about'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondaryWhite,
        child: Column(
          children: [
            const TopBar3(pageTitle: 'Settings'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardTitles.length,
                itemBuilder: (context, index) {
                  return SettingsCard(
                    cardTitle: cardTitles[index],
                    leadingImagePath: imagePaths[index],
                    onTap: () => PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: pages[index],
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    ),
                  );
                },
              ),
            ),
            RoundButton(
              title: 'Log out',
              onTap: () {
                GoogleSignIn().signOut();
                _auth.signOut().then((value) {
                  utils.toastMessage('Logout Success', Colors.green);
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const LoginScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }).catchError((error) {
                  utils.toastMessage(error.toString(), Colors.red);
                });
              },
            )
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: primaryBlue,
            //     elevation: 0,
            //   ),
            //   onPressed: () {
            //     GoogleSignIn().signOut();
            //     _auth.signOut().then((value) {
            //       utils.toastMessage('Logout Success', Colors.green);
            //       PersistentNavBarNavigator.pushNewScreen(
            //         context,
            //         screen: const LoginScreen(),
            //         withNavBar: false,
            //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
            //       );
            //     }).catchError((error) {
            //       utils.toastMessage(error.toString(), Colors.red);
            //     });
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //     child: Text(
            //       'Log out',
            //       style: TextStyle(
            //         fontSize: 25.0,
            //         color: Colors.white,
            //         fontFamily: 'Poppins',
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
