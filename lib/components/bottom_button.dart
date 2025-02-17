import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  BottomButton({this.bottomButtonText, this.onTap});

  final String? bottomButtonText;
  late final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: primaryBlue,
        margin: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 70.0,
        child: Center(
          child: Text(
            bottomButtonText.toString(),
            style: const TextStyle(
              letterSpacing: 2.0,
              fontSize: 22.0,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}
