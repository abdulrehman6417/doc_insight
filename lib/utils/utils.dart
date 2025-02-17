import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMessage(String message, Color clr) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: clr,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showInfoMsg(BuildContext context, String msg) {
    Flushbar(
      messageText: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: "Poppins",
        ),
      ),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeInOut,
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    ).show(context);
  }
}
