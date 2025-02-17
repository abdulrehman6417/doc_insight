import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String pageTitle;
  const TopBar({
    super.key,
    required this.pageTitle,
  });

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(180.0);
}

class _TopBarState extends State<TopBar> {
  //getting current user id
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //getting current user email
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  //creating reference to user record in firebase database
  final firestore = FirebaseFirestore.instance.collection('Users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: primaryBlue,
                border: Border(bottom: BorderSide(color: itemsColor, width: 2)),
              ),
              padding: const EdgeInsets.only(
                  left: 20, top: 45, bottom: 15, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: firestore.doc(currentUserId).snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child:
                              CircularProgressIndicator(color: color2DarkBlue),
                        );
                      } else if (snapshot.hasData) {
                        Map<String, dynamic> userInfo =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return ClipOval(
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 222, 221, 221),
                                  ),
                                ]),
                            child: userInfo['profileImage'] == ""
                                ? const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/profileImage.png'),
                                    minRadius: 25.0,
                                    maxRadius: 25.0,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        Uri.parse(userInfo['profileImage'])
                                            .toString()),
                                    minRadius: 25.0,
                                    maxRadius: 25.0,
                                  ),
                          ),
                        );
                      } else {
                        return Center(
                            child:
                                CircularProgressIndicator(color: primaryBlue));
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'DocInsight',
                    style: TextStyle(
                      fontFamily: 'Request',
                      fontSize: 12,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.width * 0.12,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Transform.scale(
                  scale: 1.1,
                  child: const ImageIcon(
                    AssetImage('assets/images/back.png'),
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            widget.pageTitle,
            style: TextStyle(
              color: itemsColor,
              fontFamily: 'PoppinsBold',
              fontSize: 25,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(
          color: Color(0xff9C9C9C),
          height: 2,
          thickness: 2,
        ),
      ],
    );
  }
}
