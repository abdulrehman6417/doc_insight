import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/utils/utils.dart';
import 'package:doc_insight/widgets/roundButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final utils = Utils();
  bool loading = false;

  void passwordReset() {
    final email = emailController.text.toString();
    try {
      setState(() {
        loading = true;
      });
      auth.sendPasswordResetEmail(email: email).then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Password reset link has been sent to your email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: itemsColor),
                  ),
                ],
              ),
            );
          },
        );
        setState(() {
          loading = false;
        });
      }).catchError((error) {
        print(error);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.dangerous_outlined,
                    color: Colors.red,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Invalid or incorrect email. Please check your email again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: itemsColor),
                  ),
                ],
              ),
            );
          },
        );
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      print(e);
      utils.toastMessage(e.toString(), Colors.red);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryWhite,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        toolbarHeight: 100,
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 27,
            color: secondaryWhite,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Enter your email address and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: itemsColor,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            RoundButton(
                title: 'Send Link',
                onTap: () {
                  passwordReset();
                }),
          ],
        ),
      ),
    );
  }
}
