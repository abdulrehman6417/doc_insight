// import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/models/profile_controller.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/widgets/profile_card.dart';
import 'package:doc_insight/widgets/top_bar3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_capitalize/string_capitalize.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //getting current user id
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //fetching current user email from logged in user
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  // creating reference to firestore database collections
  final firestore = FirebaseFirestore.instance.collection('Users');

  List<String> gender = <String>['Male', 'Female'];
  String? dropDownValue;

  // Future getData() async {
  //   //getting current user
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   //get current user email
  //   String currentUserEmail = currentUser!.email!;
  //   //fetch data of the current user from the firebase database
  //   document = await firestore.collection('Users').doc(currentUserEmail).get();
  // }

  //edit or update the fields
  // Future<void> editField(String field) async {
  //   String newValue = "";
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           color: Colors.red,
  //           child: Text('Edit $field'),
  //         );
  //       });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileController>(context);

    return Scaffold(
      backgroundColor: secondaryWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopBar3(pageTitle: 'My Profile'),
            const SizedBox(height: 8),
            StreamBuilder(
                stream: firestore.doc(currentUserId).snapshots(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    Map<String, dynamic> userInfo =
                        snapshot.data!.data() as Map<String, dynamic>;
                    String username = userInfo['username'];
                    String email = userInfo['email'];
                    String bio = userInfo['bio'];
                    String profileImage = userInfo['profileImage'];
                    String phone = userInfo['phone'];
                    String genderName = userInfo['gender'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.012,
                          width: double.infinity,
                        ),
                        Stack(
                          children: [
                            ClipOval(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: itemsColor,
                                      ),
                                    ]),
                                child: profileImage == ""
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/profileImage.png'),
                                        minRadius: 80.0,
                                        maxRadius: 80.0,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            Uri.parse(profileImage).toString()),
                                        minRadius: 80.0,
                                        maxRadius: 80.0,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 130,
                              child: GestureDetector(
                                onTap: () {
                                  profileProvider.pickImage(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: itemsColor,
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Image.asset(
                                    'assets/images/add-photo.png',
                                    width: 22.0,
                                    fit: BoxFit.cover,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          username.capitalizeEach(),
                          style: TextStyle(
                            color: itemsColor,
                            fontSize: 28.0,
                            letterSpacing: 1.0,
                            fontFamily: 'PoppinsBold',
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: primaryBlue,
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ProfileCard(
                          cardTitle: 'Username',
                          cardData: username.capitalizeEach(),
                          dataTextStyle: TextStyle(
                            color: itemsColor,
                            fontSize: 22.0,
                            letterSpacing: 1.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                          onTap: () =>
                              profileProvider.editFields(context, 'username'),
                        ),
                        ProfileCard(
                          cardTitle: 'Email',
                          cardData: email,
                          dataTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 2, 7, 34),
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          onTap: () =>
                              profileProvider.editFields(context, 'email'),
                        ),
                        ProfileCard(
                          cardTitle: 'Phone',
                          cardData: phone,
                          dataTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 2, 7, 34),
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          onTap: () =>
                              profileProvider.editFields(context, 'phone'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.only(
                                left: 30, right: 35, top: 7, bottom: 7),
                            child: DropdownButton(
                              hint: Text(
                                'Select Gender',
                                style: TextStyle(
                                  fontFamily: 'Gothic',
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 2, 7, 34)
                                      .withOpacity(0.7),
                                ),
                              ),
                              isExpanded: true,
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(15),
                              style: TextStyle(
                                color: itemsColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                fontSize: 17,
                              ),
                              icon: ImageIcon(
                                const AssetImage('assets/images/dropDown.png'),
                                color: itemsColor,
                                size: 20,
                              ),
                              value:
                                  genderName == '' ? dropDownValue : genderName,
                              items: gender
                                  .map<DropdownMenuItem<String>>((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                  if (newValue != "") {
                                    firestore
                                        .doc(currentUserId)
                                        .update({'gender': newValue});
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        ProfileCard(
                          cardTitle: 'Bio',
                          cardData: bio.capitalize(),
                          dataTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 2, 7, 34),
                            fontSize: 16.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          onTap: () =>
                              profileProvider.editFields(context, 'bio'),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
