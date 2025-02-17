import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/screens/forgot_password.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/roundButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  //getting current user id
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  //getting current user email
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  //creating reference to user record in firebase database
  final firestore = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: AppBar(
        title: Text(
          'Password & Security',
          style: TextStyle(
            color: secondaryWhite,
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryBlue,
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Transform.scale(
            scale: 1.1,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const ImageIcon(
                AssetImage('assets/images/back.png'),
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Color(0xff9C9C9C),
            height: 2,
            thickness: 2,
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Current Password',
              style: TextStyle(
                color: itemsColor,
                fontFamily: 'Inter',
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder(
              stream: firestore.doc(currentUserId).snapshots(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (snapshot.hasData) {
                  Map<String, dynamic> userInfo =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Text(
                      '${userInfo['password']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        color: primaryBlue,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 30),
          Center(
              child: RoundButton(
                  title: 'Change Password',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()),
                    );
                  }))
        ],
      ),
    );
  }
}
