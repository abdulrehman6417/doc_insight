import 'package:doc_insight/screens/forgot_password.dart';
import 'package:doc_insight/screens/home_page.dart';
import 'package:doc_insight/screens/signup_screen.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/utils/utils.dart';
import 'package:doc_insight/widgets/google_signin_button.dart';
import 'package:doc_insight/widgets/roundButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  bool _obscureText = true;
  Utils utils = Utils();
  bool _isChecked = false;

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
              Image.asset('assets/images/FYPLOGO.png', width: 120, height: 120),
              const SizedBox(height: 35.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width),
                    Text(
                      'Sign in to your \naccount ',
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
                                  // borderSide: const BorderSide(
                                  //   color: Colors.white,
                                  //   width: 2.0,
                                  // ),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  // borderSide: const BorderSide(
                                  //   color: Colors.white,
                                  //   width: 2.0,
                                  // ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
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
                                  //   color: itemsColor,
                                  //   width: 2,
                                  // ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // borderSide: BorderSide(
                                  //   color: itemsColor,
                                  //   width: 2,
                                  // ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: _isChecked,
                            onChanged: (newValue) {
                              setState(() {
                                _isChecked = newValue!;
                              });
                            },
                            activeColor: primaryBlue,
                          ),
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            color: primaryBlue,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    RoundButton(
                      title: 'Login',
                      loading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          _auth
                              .signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString(),
                          )
                              .then((value) {
                            utils.toastMessage(
                                'Login Successful', Colors.green);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Homepage()),
                            );
                            setState(() {
                              loading = false;
                            });
                          })
                              // ignore: body_might_complete_normally_catch_error
                              .catchError((error) {
                            utils.toastMessage(error.toString(), Colors.red);
                            setState(() {
                              loading = false;
                            });
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPassword()),
                  );
                },
                child: Text(
                  'Forgot the Password?',
                  style: TextStyle(
                    color: itemsColor,
                    fontSize: 18.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
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
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
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
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign up',
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
