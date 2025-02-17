import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/screens/login_screen.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/utils/utils.dart';
import 'package:doc_insight/widgets/google_signin_button.dart';
import 'package:doc_insight/widgets/roundButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Utils utils = Utils();
  bool _obscureText = true;
  bool loading = false;

  void signup(String username) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      //creating user with email and password

      _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );

      // adding the data to the database

      if (loading) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(_auth.currentUser!.uid.toString())
            .set({
          'username': username,
          'email': emailController.text.toString(),
          'bio': '',
          'profileImage': '',
          'phone': phoneController.text.toString(),
          'password': passwordController.text.toString(),
          'gender': '',
        });
        setState(() {
          loading = false;
          usernameController.clear();
          passwordController.clear();
          emailController.clear();
          phoneController.clear();
        });
        Navigator.pop(context);
        utils.toastMessage('Signup Success', Colors.green);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width),
              Image.asset('assets/images/FYPLOGO.png', width: 120, height: 120),
              const SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width),
                    Text(
                      'Create new\naccount',
                      style: TextStyle(
                        fontFamily: 'PoppinsBold',
                        color: itemsColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: usernameController,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                hintStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 137, 137, 137),
                                  letterSpacing: 1.0,
                                ),
                                prefixIcon: IconButton(
                                  icon: ImageIcon(
                                    const AssetImage(
                                        'assets/images/profile.png'),
                                    color: itemsColor,
                                  ),
                                  onPressed: () {},
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: itemsColor,
                                  //   width: 2.5,
                                  // ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: itemsColor,
                                  //   width: 3.0,
                                  // ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 137, 137, 137),
                                  letterSpacing: 1.0,
                                ),
                                prefixIcon: IconButton(
                                  icon: ImageIcon(
                                    const AssetImage('assets/images/email.png'),
                                    color: itemsColor,
                                  ),
                                  onPressed: () {},
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: color2DarkBlue,
                                  //   width: 2.5,
                                  // ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: color2DarkBlue,
                                  //   width: 3.0,
                                  // ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Phone No.',
                                hintStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 137, 137, 137),
                                  letterSpacing: 1.0,
                                ),
                                prefixIcon: IconButton(
                                  icon: ImageIcon(
                                    const AssetImage('assets/images/phone.png'),
                                    color: itemsColor,
                                  ),
                                  onPressed: () {},
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: itemsColor,
                                  //   width: 2.5,
                                  // ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: itemsColor,
                                  //   width: 3.0,
                                  // ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter phone no.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 137, 137, 137),
                                  letterSpacing: 1.0,
                                ),
                                prefixIcon: IconButton(
                                  icon: ImageIcon(
                                    const AssetImage('assets/images/lock.png'),
                                    color: itemsColor,
                                  ),
                                  onPressed: () {},
                                ),
                                suffixIcon: _obscureText
                                    ? IconButton(
                                        icon: ImageIcon(
                                          const AssetImage(
                                              'assets/images/showPass.png'),
                                          color: itemsColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: ImageIcon(
                                          const AssetImage(
                                              'assets/images/hidePass.png'),
                                          color: itemsColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: color2DarkBlue,
                                  //   width: 2.5,
                                  // ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: color2DarkBlue,
                                  //   width: 3.0,
                                  // ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    RoundButton(
                        title: 'Sign up',
                        loading: loading,
                        onTap: () {
                          signup(usernameController.text.toString());
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.26,
                    color: lightGray.withOpacity(0.5),
                    height: 2,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'or continue with',
                    style: TextStyle(
                      color: lightGray.withOpacity(0.75),
                      fontSize: 16,
                      letterSpacing: 1.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.26,
                    color: lightGray.withOpacity(0.5),
                    height: 2,
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              const SignInWithGoogle(),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Already a user?',
                    style: TextStyle(
                      fontSize: 17,
                      color: itemsColor,
                      fontFamily: 'Gothic',
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryBlue,
                        fontFamily: 'PoppinsBold',
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
