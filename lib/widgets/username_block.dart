import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

class UsernameBlock extends StatefulWidget {
  const UsernameBlock({
    super.key,
  });

  @override
  State<UsernameBlock> createState() => _UsernameBlockState();
}

class _UsernameBlockState extends State<UsernameBlock> {
  //getting current user id
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //getting current user information
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  //creating reference to firestore database
  final firestore = FirebaseFirestore.instance.collection('Users');
  // late DocumentSnapshot document;

  //get username from the current logged in user
  // Future getUsername() async {
  //   final userEmail = currentUser!.email!;
  //   document = await firestore.collection('Users').doc(userEmail).get();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getUsername();
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.doc(currentUserId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: color2DarkBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                '',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          Map<String, dynamic> userInfo =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: color2DarkBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                userInfo['username'].toString().capitalizeEach(),
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          );
        } else {
          return Container(
            height: 45.0,
            decoration: BoxDecoration(
              color: color2DarkBlue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                '',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
