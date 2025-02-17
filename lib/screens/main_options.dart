import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/pages/input_page.dart';
import 'package:doc_insight/screens/daily_tips.dart';
import 'package:doc_insight/screens/health_page.dart';
import 'package:doc_insight/screens/medicine_page.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:http/http.dart' as http;

class MainOptions extends StatefulWidget {
  const MainOptions({super.key});

  @override
  State<MainOptions> createState() => _MainOptionsState();
}

class _MainOptionsState extends State<MainOptions> {
  //getting current user id
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //getting current user email
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  //creating reference to user record in firebase database
  final firestore = FirebaseFirestore.instance.collection('Users');

  //carousel slider index reference
  int _currentSliderIndex = 0;
  // carousel controller
  final CarouselController _carouselController = CarouselController();
  //carousel slider items here
  final List<Widget> _carouselItems = [
    Image.asset(
      'assets/images/banner_1.png',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/banner_2.png',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/banner_3.png',
      fit: BoxFit.cover,
    ),
  ];
  // services names here
  List<String> servicesNames = [
    'Symptoms\nInsight',
    'Drugs\nInsight',
    'Daily Health\nTips',
    'Bmi\nCalculator',
  ];
  // services icon names here
  List<String> servicesIcons = [
    'doctor',
    'meds',
    'tips',
    'bmi',
  ];

  List<Widget> servicePages = const [
    HealthPage(),
    MedicinePage(),
    DailyHealthTips(),
    InputPage(),
  ];

  bool _isConnected = false;

  Future<void> _checkInternetConnection(BuildContext context) async {
    try {
      final result = await http.head(Uri.parse('https://google.com'));
      if (result.statusCode == 200) {
        _isConnected = !_isConnected;
      } else {
        _isConnected = !_isConnected;

        Utils().showInfoMsg(context, "No Internet Connection");
      }
    } catch (e) {
      _isConnected = false;
      Utils().showInfoMsg(context, "No Internet Connection");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // move carousel sliders after every 2 seconds
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentSliderIndex < _carouselItems.length - 1) {
        _currentSliderIndex++;
      } else {
        _currentSliderIndex = 0;
      }
      _carouselController.animateToPage(
        _currentSliderIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

    // check if the phone is connected to internet
    _checkInternetConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: secondaryWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 45, bottom: 15),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder(
                        stream: firestore.doc(currentUserId).snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child:
                                  CircularProgressIndicator(color: primaryBlue),
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
                                        color:
                                            Color.fromARGB(255, 222, 221, 221),
                                      ),
                                    ]),
                                child: userInfo['profileImage'] == ""
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/profileImage.png'),
                                        minRadius: 27.0,
                                        maxRadius: 27.0,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            Uri.parse(userInfo['profileImage'])
                                                .toString()),
                                        minRadius: 27.0,
                                        maxRadius: 27.0,
                                      ),
                              ),
                            );
                          } else {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: primaryBlue));
                          }
                        },
                      ),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/images/bell.png',
                              width: 30.0,
                              fit: BoxFit.cover,
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              width: 13,
                              height: 13,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello,',
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 40,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                          StreamBuilder(
                            stream: firestore.doc(currentUserId).snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        DocumentSnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                );
                              } else if (snapshot.hasData) {
                                Map<String, dynamic> userInfo = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                return Container(
                                  width: 280,
                                  child: Text(
                                    '${userInfo['username']}!',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Container(
                        child: Lottie.asset(
                          'assets/animations/robo.json',
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            CarouselSlider(
              options: CarouselOptions(viewportFraction: 1, height: 180),
              items: _carouselItems,
              carouselController: _carouselController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Our Services',
                style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  color: itemsColor,
                  fontSize: 28,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Empowering you with insight,\none symptom at a time',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: itemsColor.withOpacity(0.7),
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 168,
                      crossAxisSpacing: 0),
                  itemCount: servicesNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: servicePages[index],
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/serviceBlock.png'),
                          fit: BoxFit.contain,
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Image.asset(
                                'assets/images/${servicesIcons[index]}.png',
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              textAlign: TextAlign.center,
                              servicesNames[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final FirebaseAuth _auth = FirebaseAuth.instance;
      //     final Utils utils = Utils();
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
      //   child: Icon(Icons.logout),
      // ),
    );
  }
}
